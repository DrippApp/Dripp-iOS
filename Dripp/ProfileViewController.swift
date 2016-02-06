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
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var achievements: UIImageView!
    var albums = [String]()
    var names = [String]()
    
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
        let params = ["fields": "name, id"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let id = result.valueForKey("id") as! NSString as String
                self.profilePicture.hnk_setImageFromURL(NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large&return_ssl_resources=1")!)
                self.navigationItem.title = result.valueForKey("name") as! NSString as String
            }
        })
        self.progressBar.progressColor = UIColor.blueHeader
        self.progressBar.progressStrokeColor = UIColor.blueHeader
        albums = ["a.png",  "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "i.png", "j.png", "k.png", "l.png", "m.png"]
        names = ["a.png",  "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "i.png", "j.png", "k.png", "l.png", "m.png"]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        achievements.userInteractionEnabled = true
        achievements.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(img: AnyObject)
    {
        let alert = UIAlertController(title: "Power Shower", message: "You took a shower in less than 10 minutes!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Sweet", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.progressBar.setValue(85, animateWithDuration: 1.5)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Achievement", forIndexPath: indexPath) as! AchievementCell
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame.png")) as UIView
        cell.image?.image = UIImage(named: albums[indexPath.row])
        cell.name?.text = names[indexPath.row]
        return cell
    }

    
    
}