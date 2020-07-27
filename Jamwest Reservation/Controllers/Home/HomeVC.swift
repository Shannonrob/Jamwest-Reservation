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
    var inSearchMode = false
    let searchBar = JWSearchBar.init(placeHolder: "Search group")
    
    //notification key
    let dateChanged = Notification.Name(rawValue: Listener.dateChangedKey)
    
    // remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
 //    MARK: - Init
     
     override func viewDidLoad() {
         super.viewDidLoad()
        self.collectionView!.register(ReservationCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
        configureUI()
        observeDateChanged()
        configureRefreshControl()
        fetchCurrentDayReservations()
        handleDeletedReservation()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        inSearchMode = false
        showSearchBar(shouldShow: false)
        collectionView.reloadData()
        checkEmptyState()
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
        collectionView.reloadData()
    }
    
   
    @objc func handleRefresh() {
        
        DispatchQueue.main.async {
            self.reservations.removeAll(keepingCapacity: false)
            self.fetchCurrentDayReservations()
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
            self.dismissLoadingView()
            self.dismissEmptyStateView()
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    
    func handleReservationData(for reservation: Reservation) {
        let reservationID = reservation.reservationId
        
        if let existingReservation = self.reservations.firstIndex(where: { $0.reservationId == reservationID }) {
            self.reservations[existingReservation] = reservation
        } else {
            self.reservations.append(reservation)
        }
        
        self.reservations.sort { (reservation1, reservation2) -> Bool in
            return reservation1.lastName < reservation2.lastName
        }
        collectionView.reloadData()
    }
    
//    MARK: - API
    
    @objc func fetchCurrentDayReservations() {
        
        showLoadingView()
        reservations = []
        formatReservationDate()
        
        NetworkManager.shared.fetchReservations(for: currentDate) { [weak self] (result) in
            guard let self = self else { return }
            self.checkEmptyState()
            self.collectionView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let reservation):
                self.handleReservationData(for: reservation)
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
        
    
    func checkEmptyState() {
        dismissEmptyStateView()
        NetworkManager.shared.checkReservationsEmptyState(for: currentDate) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
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
            self.checkEmptyState()
            self.reservations.removeAll(keepingCapacity: false)
            self.fetchCurrentDayReservations()
            self.collectionView.reloadData()
        }
    }
}


extension HomeVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // filters search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            collectionView.reloadData()
        } else {
            inSearchMode = true
            filteredReservations = reservations.filter({ (reservation) -> Bool in
                return reservation.firstName.localizedCaseInsensitiveContains(searchText)
            })
            collectionView.reloadData()
        }
    }
}



