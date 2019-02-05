//
//  EditProfileController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 2/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class EditProfileController: UITableViewController {
    
    // Cell Id's
    let cellId = "cellId"
    
    // User
    var user:User?
    func setUser(user:User?) {
        guard let user = user else { return }
        self.user = user
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        navbarConfig()
        registerCell()
    }
    
    // Nav - Configuration
    fileprivate func navbarConfig() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 36, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.Theme.textColor]
        self.title = "Edit Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    }
    
    // Tableview - Configuration
    fileprivate func tableViewConfig() {
        self.tableView.separatorStyle = .none
        self.tableView.keyboardDismissMode = .interactive
    }
    
    // Cell - Registration
    func registerCell() {
        self.tableView.register(EditProfileViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // Cell - Rendering
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .profileImageOnly)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .name)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .username)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .website)
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .bio)
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .email)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileViewCell
                cell.setUser(user: self.user, type: .phone)
                return cell
            default:
                let cell = UITableViewCell()
                cell.selectionStyle = .none
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    // Cell - Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 135
            default:
                return 44
            }
        case 1:
            switch indexPath.row {
            case 0,1:
                return 44
            default:
                return 100
            }
        default:
            return 0
        }
    }
    
    // Number of Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Cell - Count Per Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    // Header - Per Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let label = UILabel()
        label.text = "Private Information"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.Theme.textColor
        header.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15),
            label.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -30)
            ])
        return header
    }
    
    // Header - Height Per Section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 70
        default:
            return 0
        }
    }
    
    
    
    
}
