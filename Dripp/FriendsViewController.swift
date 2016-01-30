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
import Haneke

class FriendsViewController: UITableViewController {
    
    var friends = [Dripper]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadFriends()
    }
    
    func loadFriends() {
        Alamofire.request(.GET, "http://api.dripp.xyz/user/16/connections",
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
        let CellIdentifier = "FriendCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! FriendCell
        cell.name.text = ""
        cell.photo.image = UIImage(named: "placeholder")
        
        let friend = self.friends[indexPath.row]
        
        cell.photo.hnk_setImageFromURL(NSURL(string: friend.photo)!)
        cell.name.text = "\(friend.firstName) \(friend.lastName)"
        cell.backgroundColor = UIColor(hexString: "#f1f1f1")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let challenge = UITableViewRowAction(style: .Normal, title: "Challenge") { action, index in
            print("challenge button tapped")
        }
        challenge.backgroundColor = UIColor.blueHeader
        
        
        return [challenge]
    }
}