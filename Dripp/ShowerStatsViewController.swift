//
//  ShowerStatsViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/31/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class ShowerStatsViewController: UIViewController {
    @IBOutlet weak var tub: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let waterView = WaterView(frame: CGRectMake(0, 0, 350, 700))
        waterView.center = self.view.center
        waterView.backgroundColor = UIColor.clearColor()
        waterView.currentWaterColor = UIColor.blueHeader.colorWithAlphaComponent(0.3)
        waterView.percentum = 0.30
        self.view.insertSubview(waterView, belowSubview: tub)
        
        self.title = "Your Shower Stats"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}