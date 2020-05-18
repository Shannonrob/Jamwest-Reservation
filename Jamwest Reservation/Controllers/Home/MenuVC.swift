//
//  MenuVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
 
//    MARK: - Properties
    
    var tableView: UITableView!
    var delegate: HomeVcDelegate?
    private let reuseIdentifier = "MenuOptionCell"
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.Primary.heavyGreen
        
        configureTableView()
    }
    
//    MARK: - Handlers
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = Color.Primary.heavyGreen
        
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

extension MenuVC: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 160))
        headerView.backgroundColor = Color.Primary.heavyGreen

        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        logo.image = UIImage(imageLiteralResourceName: "clearWhite").withRenderingMode(.alwaysOriginal)

        headerView.addSubview(logo)
        logo.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: headerView.frame.height)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuOptionCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.menuLabel.text = menuOption?.description
        cell.iconImage.image = menuOption?.iconImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
}
