//
//  AchievementsViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/31/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class AchievementViewController: UICollectionViewController {
    
    var albums = [String]()
    var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albums = ["a.png",  "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "i.png", "j.png", "k.png", "l.png", "m.png"]
        names = ["a.png",  "b.png", "c.png", "d.png", "e.png", "f.png", "g.png", "h.png", "i.png", "j.png", "k.png", "l.png", "m.png"]
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Achievement", forIndexPath: indexPath) as! AchievementCell
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame.png")) as UIView
        cell.image?.image = UIImage(named: albums[indexPath.row])
        cell.name?.text = names[indexPath.row]
        return cell
    }
    
}

