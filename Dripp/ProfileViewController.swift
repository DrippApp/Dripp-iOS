//
//  ProfileViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import EasyAnimation

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var drop: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let anim = CABasicAnimation(keyPath: "position.x")
//        anim.fromValue = 100.0
//        anim.toValue = 200.0
//        anim.duration = 2.0
//        drop.layer.addAnimation(anim, forKey: nil)
        
        
        
        UIView.animateWithDuration(2.0, delay: 0.0,
            usingSpringWithDamping: 0.25,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                self.drop.layer.position.x += 200.0
                self.drop.layer.cornerRadius = 50.0
                self.drop.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
            }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}