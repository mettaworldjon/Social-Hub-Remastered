//
//  UserAccountController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 2/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserAccountController: UITableViewController {
    
    // Cell Id's
    let cellId = "cellId"
    
    private var user:User?
    func setUser(user:User?) {
        guard let user = user else { return }
        self.user = user
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView()
    }
    
    fileprivate func registerCells() {
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return TableViewTitleSpace("PROFILE")
        case 1:
            return TableViewTitleSpace("")
        case 2:
            return TableViewTitleSpace("SETTINGS")
        case 3:
            return TableViewTitleSpace("")
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0,2:
            return 56
        case 1,3:
            return 10
        default:
            return 0
        }
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            // Section - 1
        case 0:
            // Header
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
            cell.setCell(user: user, typeOfView: .profile)
            return cell
            
            // Section - 2
        case 1:
            switch indexPath.row {
            case 0:
                // Followers
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "86.1K", title: "Followers")
                return cell
            case 1:
                // Following
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "16", title: "Following")
                return cell
            case 2:
                // Blocked
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "193", title: "Blocked Users")
                return cell
            default:
                return UITableViewCell()
            }
            
            // Section - 3
        case 2:
            switch indexPath.row {
            case 0:
                // Notifications
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "", title: "Notifications")
                return cell
            case 1:
                // Privacy & Security
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "", title: "Privacy & Security")
                return cell
            case 2:
                // Language
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "English", title: "Language")
                return cell
            case 3:
                // Theme
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "Light", title: "Theme")
                return cell
            default:
                return UITableViewCell()
            }
            
            // Section - 4
        case 3:
            switch indexPath.row {
            case 0:
                // Notifications
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTableViewCell
                cell.setCell(user: user, typeOfView: .selection, detail: "", title: "Logout", image: #imageLiteral(resourceName: "logout"))
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    // Cell - Selection Action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let edit = EditProfileController()
            edit.setUser(user: self.user)
            self.navigationController?.pushViewController(edit, animated: true)
        case 3:
            do {
                try Auth.auth().signOut()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchToSignUpViewController()
            } catch let error {
                print(error)
            }
        default: break
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 4
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        default:
            return 44
        }
    }
    
    
    
}
