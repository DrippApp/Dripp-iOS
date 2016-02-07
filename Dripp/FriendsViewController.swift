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
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
        let params = ["fields": "name, id, friends"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let friends = result.valueForKey("friends")
                let data : NSArray = friends!.objectForKey("data") as! NSArray
                
                for i in 0 ..< data.count
                {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    self.friends.append(Dripper(uid: id, firstName: name, lastName: "", email: "", photo: "https://graph.facebook.com/\(id)/picture?type=large&return_ssl_resources=1", accountType: "", lowestShowerLength: "", savedWater: ""))
                    print("the id value is \(id)")
                }
                self.table.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                
            }
        })

    }
    
//    func loadFriends() {
//        Alamofire.request(.GET, "http://api.dripp.xyz/user/16/connections",
//            parameters: ["api": true])
//            .responseJSON { response in
//                if response.result.isSuccess {
//                    if let data: AnyObject = response.result.value! {
//                        let json = JSON(data)
//                        let array = json["data"].arrayValue
//                        self.friends = array.map {
//                            Dripper(json: $0)
//                        }
//                        self.table.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
//                    }
//                }
//        }
//    }
    
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
            
            let friend = self.friends[indexPath.row]
            
            let alert = UIAlertController(title: "Quick Challenge", message: "Challenge \(friend.firstName) to take a shower using your recommended playlist.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            self.tableView.setEditing(false, animated: true)
            
        }
        challenge.backgroundColor = UIColor.blueHeader
        
        
        return [challenge]
    }
}