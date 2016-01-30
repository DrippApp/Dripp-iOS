//
//  ChallengesViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/30/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

//
//  FriendsViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ChallengesViewController: UITableViewController {
    
    var friends = [Dripper]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadFriends()
    }
    
    func loadFriends() {
        Alamofire.request(.GET, "http://api.dripp.xyz/users",
            parameters: ["api": true])
            .responseJSON { response in
                if response.result.isSuccess {
                    if let data: AnyObject = response.result.value! {
                        let json = JSON(data)
                        let array = json["data"].arrayValue
                        self.friends = array.map {
                            Dripper(json: $0)
                        }
                        self.table.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                    }
                }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Friends";
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        
        let dripper = friends[indexPath.row]
        
        cell.textLabel?.text = "\(dripper.firstName) \(dripper.lastName)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}