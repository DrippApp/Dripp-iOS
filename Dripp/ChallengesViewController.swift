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
    
    var friends = [FeedItem]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 97.0
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
        self.title = "Pending Challenges"
        loadFriends()
    }
    
    func loadFriends() {
        
        let item = FeedItem(uid: "test", firstName: "Myke", lastName: "Olson", data: "Challenged you to shower with the playlist Wild Country.", photo: "http://www.dripp.xyz/assets/12143122_588256791313408_8609137715597578781_n.jpg", type: "challenge", notificationID: "6", date: "4h")
        item.unread = true
        friends.append(item)
        friends.append(FeedItem(uid: "test", firstName: "Rachel", lastName: "Kurland", data: "Challenged you to shower with the playlist Soapy.", photo: "http://www.dripp.xyz/assets/speakerbug508c7c185c40ea045a8383ae259bd7cb.jpg", type: "challenge", notificationID: "6", date: "4h"))
        friends.append(FeedItem(uid: "test", firstName: "Brandon", lastName: "Hudson", data: "Challenged you to shower with the playlist Metallica.", photo: "http://www.dripp.xyz/assets/10577089_937131712979394_6519832353143327126_n-2.jpg", type: "challenge", notificationID: "6", date: "30m"))
        
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
        
        let CellIdentifier = "ChallengeCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! ChallengeCell
        cell.info.text = ""
        cell.photo.image = UIImage(named: "placeholder")
        cell.dot.image = nil
        
        let person = self.friends[indexPath.row]
        
        if person.unread {
            cell.dot.image = UIImage(named: "dot")
        }
        
        cell.photo.hnk_setImageFromURL(NSURL(string: person.photo)!)
        cell.info.text = person.data
        cell.name.text = "\(person.firstName) \(person.lastName)"
        cell.timestamp.text = person.date
        cell.backgroundColor = UIColor(hexString: "#f1f1f1")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let challenge = UITableViewRowAction(style: .Normal, title: "Ignore") { action, index in
            
            print(self.friends)
            self.friends.removeAtIndex(indexPath.row)
            print(self.friends)
            self.tableView.setEditing(false, animated: true)
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            
        }
        challenge.backgroundColor = UIColor.redColor()
        
        
        return [challenge]
    }
    
}