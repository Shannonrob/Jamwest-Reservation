//
//  HomeVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    //    MARK: - Properties
    var delegate: HomeVcDelegate?
    var currentDate = String()
    var reservations = [Reservation]()
    var filteredReservations = [Reservation]()
    var searchedReservationResult = [Reservation]()
    var inSearchMode = false
    let searchBar = JWSearchBar.init(placeHolder: "Search group")
    
    var fetchLimit = 100
    var currentReservationCount = 100
    var startDataFetchingPoint = "A"
    
    //notification key
    let dateChanged = Notification.Name(rawValue: Listener.dateChangedKey)
    
    // remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        inSearchMode = false
        showSearchBar(shouldShow: false)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        currentReservationCount = 100
        self.reservations.removeAll(keepingCapacity: false)
        self.collectionView.reloadData()
        
        checkEmptyState()
        handleDeletedReservation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(ReservationCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureRefreshControl()
        observeDateChanged()
        fetchCurrentDayReservations(limit: fetchLimit, start: startDataFetchingPoint)
    }
    
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RESERVATION_DATE_REF.removeAllObservers()
        RESERVATION_DATE_REF.child(currentDate).removeAllObservers()
    }
    
    
    //    MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // cell sizes
        let width = (view.frame.width - 60) / 2
        return CGSize(width: width, height: 170)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 23, bottom: 5, right: 23)
    }
    
    
    //    MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredReservations.count
        } else {
            return reservations.count
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReservationCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = Color.Primary.markerColor.cgColor
        
        // cell shadow
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        var reservation: Reservation!
        
        if inSearchMode {
            reservation = filteredReservations[indexPath.row]
        } else {
            reservation = reservations[indexPath.row]
        }
        cell.reservation = reservation
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var reservation: Reservation!
        
        if inSearchMode {
            reservation = filteredReservations[indexPath.row]
        } else {
            reservation = reservations[indexPath.row]
        }
        
        let participantInfoVC = ParticipantInfoVC()
        participantInfoVC.reservation = reservation
        navigationController?.pushViewController(participantInfoVC, animated: true)
    }
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        var reservationCount: Int!
        
        if offsetY > contentHeight - height {
            
            for count in 0...reservations.count { reservationCount = count }
            if currentReservationCount > reservationCount { return }
            
            let startPoint = grabNextLetterToFetch()
            fetchCurrentDayReservations( limit: fetchLimit + 1, start: startPoint)
        }
    }
    
    
    //    MARK: - Handlers
    
    @objc func handleMenuToggle() {
        
        delegate?.handleMenuToggle(forMenuOption: nil)
        
        // dismiss searchBar when presenting menu
        if searchBar.isFirstResponder {
            showSearchBar(shouldShow: false)
        }
    }
    
    
    @objc func handleShowSearchBar() {
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    
    @objc func handleCancelTapped() {
        showSearchBar(shouldShow: false)
        inSearchMode = false
        searchedReservationResult.removeAll()
        collectionView.reloadData()
    }
    
    
    @objc func handleRefresh() {
        currentReservationCount = 100
        
        DispatchQueue.main.async {
            self.reservations.removeAll(keepingCapacity: false)
            self.checkEmptyState()
        }
    }
    
    
    func configureRefreshControl() {
        
        DispatchQueue.main.async {
            let refreshControl = UIRefreshControl()
            refreshControl.tintColor = .gray
            refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
            self.collectionView.refreshControl = refreshControl
        }
    }
    
    
    //    MARK: - Helper functions
    
    func handleSearchResult(for name: String, in reservation: Reservation?, fetchData: Bool) {
        
        if fetchData{
            guard let reservation = reservation else { return }
            searchedReservationResult.append(reservation)
            
            filteredReservations = searchedReservationResult.filter({ (reservation) -> Bool in
                return reservation.fullName.localizedCaseInsensitiveContains(name)
            })
        } else {
            
            filteredReservations = searchedReservationResult.filter({ (reservation) -> Bool in
                return reservation.fullName.localizedCaseInsensitiveContains(name)
            })
        }
        
        
        
        filteredReservations.sort { (reservation1, reservation2) -> Bool in
            return reservation1.fullNameReversed.lowercased() < reservation2.fullNameReversed.lowercased()
        }
        collectionView.reloadData()
    }
    
    
    // switches between searchBar to cancel button
    func showSearchBarButton(shouldShow: Bool) {
        
        if shouldShow {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))]
        } else {
            
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTapped))]
        }
    }
    
    
    func showSearchBar(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    
    func observeDateChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRefresh),
                                               name: dateChanged, object: nil)
    }
    
    
    @objc func formatReservationDate() {
        
        let date: Date = Date()
        let reservationDateFormatter = DateFormatter()
        reservationDateFormatter.dateStyle = .medium
        currentDate = reservationDateFormatter.string(from: date)
    }
    
    
    
    func configureUI() {
        
        view.backgroundColor = Color.Background.fadeGray
        
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = Color.Background.fadeGray
        collectionView.showsVerticalScrollIndicator = false
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Reservations"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuButton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        showSearchBar(shouldShow: false)
    }
    

    func handleEmptyStateResult(for snapshot: DataSnapshot) {
        if !snapshot.exists() {
            dismissLoadingView()
            
            DispatchQueue.main.async {
                self.showEmptyStateView(with: Label.noReservation, in: self.view)
                self.collectionView.refreshControl?.endRefreshing()
                return
            }
        } else {
       
            fetchCurrentDayReservations(limit: fetchLimit, start: startDataFetchingPoint)
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    
    func handleFetchedReservationResults(for reservation: Reservation) {
        let reservationID = reservation.reservationId
        
        if let existingIndex = self.reservations.firstIndex(where: { $0.reservationId == reservationID }) {
            self.reservations[existingIndex] = reservation
        } else {
            self.reservations.append(reservation)
        }
        
        reservations.sort { (waiver1, waiver2) -> Bool in
            return waiver1.fullNameReversed.lowercased() < waiver2.fullNameReversed.lowercased()
        }
        dismissEmptyStateView()
        collectionView.reloadData()
    }
    
    
    func grabNextLetterToFetch() -> String{
        currentReservationCount += 100
        
        let startPoint = reservations.last
        var result: String!
        
        if let letters = startPoint?.fullNameReversed {
            result = String(letters.prefix(12))
        }
        return result
    }
    
    
    func removeAtIndex(for reservation: DataSnapshot){
        let reservationID = reservation.key
        
        if let existingIndex = self.reservations.firstIndex(where: { $0.reservationId == reservationID }) {
            
            if reservations.count >= 1 { self.reservations.remove(at: existingIndex) }
            self.checkEmptyState()
        }
    }
    
    
    //    MARK: - API
    
    @objc func fetchCurrentDayReservations(limit value: Int, start startPoint: String) {
       formatReservationDate()
        
        NetworkManager.shared.fetchReservations(for: currentDate, fetch: value, starting: startPoint) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            self.collectionView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let reservation):
                self.handleFetchedReservationResults(for: reservation)
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
   
    @objc func checkEmptyState() {
        formatReservationDate()
        collectionView.reloadData()
        showLoadingView()
        
        NetworkManager.shared.checkReservationsEmptyState(for: currentDate) { [weak self] result in
            guard let self = self else { return }
            self.dismissEmptyStateView()
            self.collectionView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let snapshot):
                self.handleEmptyStateResult(for: snapshot)
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func handleDeletedReservation() {
        NetworkManager.shared.observeReservationDeleted(for: currentDate) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let snapshot):
                self.removeAtIndex(for: snapshot)
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func searchReservation(for name: String) {
        
        if !searchedReservationResult.isEmpty {
            self.handleSearchResult(for: name, in: nil, fetchData: false)
            return
        } else {
            showLoadingView()
            
            NetworkManager.shared.searchCurrentReservations(forDate: currentDate) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                
                switch result{
                case .success(let reservations):
                    self.handleSearchResult(for: name, in: reservations, fetchData: true)
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
}


extension HomeVC: UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        searchReservation(for: text.lowercased())
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            collectionView.reloadData()
        } else {
            inSearchMode = true
            filteredReservations = reservations.filter({ (reservation) -> Bool in
                return reservation.fullName.localizedCaseInsensitiveContains(searchText)
            })
            collectionView.reloadData()
        }
    }
}



