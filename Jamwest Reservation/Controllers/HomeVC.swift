//
//  HomeVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
//import Firebase

private let reuseIdentifier = "Cell"

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
 //    MARK: - Properties
    var delegate: HomeVcDelegate?
    var currentDate = String()
    var reservations = [Reservation]()
 
    //notification key whatever
    let dateChanged = Notification.Name(rawValue: date_Changed_key)
    
    // remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    var toursDictionary = [:] as [String: Any] delete if not used
       
    
 //    MARK: - Init
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        // register cell classes
        self.collectionView!.register(ReservationCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
        configureUI()
        observeDateChanged()
        fetchCurrentReservations()
    
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
        return reservations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReservationCell
        
        cell.reservation = reservations[indexPath.item]
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = Constants.Design.Color.Primary.MarkerColor.cgColor
        
        // cell shadow
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let participantInfoVC = ParticipantInfoVC()
        participantInfoVC.reservation = reservations[indexPath.row]
        navigationController?.pushViewController(participantInfoVC, animated: true)
    }
    
    //    MARK: - Handlers
    
    @objc func handleMenuToggle() {
        
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    
//    MARK: - Helper functions
    
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
        
        view.backgroundColor = Constants.Design.Color.Background.FadeGray
        collectionView.backgroundColor = Constants.Design.Color.Background.FadeGray
        collectionView.showsVerticalScrollIndicator = false
       
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.Primary.HeavyGreen
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Reservations"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuButton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
//    MARK: - API
    
    @objc func fetchCurrentReservations() {

        reservations = []
        formatReservationDate()
        
        RESERVATION_DATE_REF.child(currentDate).observe(.childAdded) { (snapshot) in
    
             let reservationIds = snapshot.key
            
            RESERVATION_REF.child(reservationIds).observeSingleEvent(of: .value) { (reservationSnapshot) in
                
                guard let dictionary = reservationSnapshot.value as? Dictionary<String, AnyObject> else { return }
                
                let reservation = Reservation(reservationId: reservationIds, dictionary: dictionary)
                
                self.reservations.append(reservation)
                
                // sort results in alphabetical order
                self.reservations.sort { (reservation1, reservation2) -> Bool in
                    return reservation1.group < reservation2.group
                }
                self.collectionView.reloadData()
            }
        }
    }
}




