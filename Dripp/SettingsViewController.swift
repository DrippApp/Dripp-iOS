//
//  SettingsViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

enum SettingsTableSection: Int {
    case AccountSettings
    case Other
    case ContactUs
}

class SettingsViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _ = tableView.indexPathForSelectedRow?.row
        if let section = SettingsTableSection(rawValue: indexPath.section) {
            switch section {
            case .AccountSettings:
                AuthenticationManager.sharedManager.logout()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
                self.presentViewController(vc, animated: true, completion: nil)
                print("log out")
            case .ContactUs:
                let email = "dripp@csh.rit.edu"
                let url = NSURL(string: "mailto:\(email)")
                UIApplication.sharedApplication().openURL(url!)
            default: break
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
