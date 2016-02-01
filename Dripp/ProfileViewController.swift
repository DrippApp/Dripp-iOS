//
//  ProfileViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ProfileViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var achievements: UIImageView!
    var albums = [String]()
    var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePicture.image = UIImage(named: "henry")
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = UIColor.lightGrayColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.layer.masksToBounds = false
        profilePicture.clipsToBounds = true
        self.navigationItem.title = "Henry Saniuk"
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