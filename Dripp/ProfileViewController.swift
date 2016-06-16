//
//  ProfileViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Haneke

class ProfileViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var currentLevel: UIImageView!
    @IBOutlet weak var nextLevel: UIImageView!
    @IBOutlet weak var nextLevelText: UILabel!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var currentLevelText: UILabel!
    var achievements = [Achievement]()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePicture.image = UIImage(named: "default")
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = UIColor.lightGrayColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.layer.masksToBounds = false
        profilePicture.clipsToBounds = true
        self.navigationItem.title = ""
        // Level Status
        currentLevelText.text = "1"
        nextLevelText.text = "2"
        
        let params = ["fields": "name, id"]
        let graphPath: String
        if id == "" {
            //get the profile of the current user
            graphPath = "me"
        } else {
            //get the profile of another user
            graphPath = id
        }
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: graphPath, parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let id = result.valueForKey("id") as! NSString as String
                self.profilePicture.hnk_setImageFromURL(NSURL(string: "https://graph.facebook.com/\(id)/picture?width=800&height=800&return_ssl_resources=1")!)
                self.navigationItem.title = result.valueForKey("name") as! NSString as String
            }
        })
        let progressBlue = UIColor(hexString: "#4E8DCB")
        self.progressBar.progressColor = progressBlue
        self.progressBar.progressStrokeColor = progressBlue
        self.achievements.append(Achievement(id: 1, title: "Power Shower", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower2", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower3", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower4", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower5", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower6", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower7", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower8", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower9", description: "You showered in under 10 minutes", image: "lock"))
        self.achievements.append(Achievement(id: 1, title: "Power Shower10", description: "You showered in under 10 minutes", image: "lock"))
    }
    
    override func viewDidAppear(animated: Bool) {
        self.progressBar.setValue(85, animateWithDuration: 1.5)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("achievement", forIndexPath: indexPath) as! AchievementCell
        cell.image?.image = UIImage(named: achievements[indexPath.item].image)
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let achievement = achievements[indexPath.item]
        
        let alert = UIAlertController(title: achievement.title, message: achievement.description, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okey Dokey", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}