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
    let loadingVC = LoadingVC()
    let searchBar = JWSearchBar.init(placeHolder: "Search group")
    
    
    //notification key whatever
    let dateChanged = Notification.Name(rawValue: Listener.dateChangedKey)
    
    // remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
 //    MARK: - Init
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        // register cell classes
        self.collectionView!.register(ReservationCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
        configureUI()
        observeDateChanged()
        fetchCurrentReservations()
        handleDeletedReservation()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        inSearchMode = false
        showSearchBar(shouldShow: false)
        collectionView.reloadData()
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
    
    // shows the searchBar
    @objc func handleSearchBar() {
       showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    // whenever the search bar cancel button is tapped
    @objc func handleCancel() {
        showSearchBar(shouldShow: false)
        inSearchMode = false
        collectionView.reloadData()
    }
    
//    MARK: - Helper functions
    
    // switches between searchBar to cancel button
    func showSearchBarButton(shouldShow: Bool) {
        
        if shouldShow {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))]
        } else {
            
            navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))]
        }
    }
    
    func showSearchBar(shouldShow: Bool) {
        // shows searchbar if true
        showSearchBarButton(shouldShow: !shouldShow)
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    // listener for dateDidChange notification
    func observeDateChanged() {
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(HomeVC.fetchCurrentReservations),
        name: dateChanged, object: nil)
    }

    // format reservation date
    func formatReservationDate() {
        
        // gets the current date
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuButton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        showSearchBar(shouldShow: false)
    }
    
//    MARK: - API
    
    @objc func fetchCurrentReservations() {
        
        reservations = []
        formatReservationDate()
      
        // fetch reservation using current date
        RESERVATION_DATE_REF.child(currentDate).observe(.childAdded) { (snapshot) in
            
            self.add(self.loadingVC)
            
            let id = snapshot.key
            
            RESERVATION_REF.child(id).observe(.value) { (reservationSnapshot) in
                
                guard let dictionary = reservationSnapshot.value as? Dictionary<String, AnyObject> else { return }
                
                let reservation = Reservation(reservationId: id, dictionary: dictionary)
                
                // filter array to prevent duplicate
                if let existingIndex = self.reservations.firstIndex(where: { $0.reservationId == id }) {
                    
                    self.reservations[existingIndex] = reservation
                    
                } else {
                    
                    self.reservations.append(reservation)
                }
                
                // sort results in alphabetical order
                self.reservations.sort { (reservation1, reservation2) -> Bool in
                    return reservation1.group < reservation2.group
                }
                
                self.remove(self.loadingVC)
                self.collectionView.reloadData()
            }
        }
    }
    
    // removes reservation from collectionView
    func handleDeletedReservation() {
        
        RESERVATION_DATE_REF.child(currentDate).observe(.childRemoved) { (snapshot) in
            
            self.add(self.loadingVC)
            self.reservations.removeAll(keepingCapacity: false)
            self.fetchCurrentReservations()
            self.remove(self.loadingVC)
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
                return reservation.group.localizedCaseInsensitiveContains(searchText)
            })
            collectionView.reloadData()
        }
    }
}



