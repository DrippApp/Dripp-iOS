//
//  FeedViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Haneke
import SwiftGifOrigin

class FeedViewController: UITableViewController {
    
    var feed = [FeedItem]()
    
    let notificationButton = UIButton(type: .Custom)
    let showerImage = UIImage(named:"showerhead")
    let showerWaterImage = UIImage(named:"showerheadwater")
    
    var refreshLoadingView : UIView!
    var refreshColorView : UIView!
    var compass_background : UIImageView!
    var drops : UIImageView!
    
    var isRefreshIconsOverlap = false
    var isRefreshAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
        loadFeed()
        //set image for button
        notificationButton.setImage(showerWaterImage, forState: .Normal)
        //add function for button
        notificationButton.addTarget(self, action: "notificationsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        notificationButton.frame = CGRectMake(0, 0, 35, 35)
        let barButton = UIBarButtonItem(customView: notificationButton)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        //register table cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.setupRefreshControl()
    }
    
    func loadFeed() {
        
        Alamofire.request(.GET, "http://api.dripp.xyz/user/16/notifications",
            parameters: ["api": true])
            .responseJSON { response in
                if response.result.isSuccess {
                    if let data: AnyObject = response.result.value! {
                        let json = JSON(data)
                        let array = json["data"].arrayValue
                        self.feed = array.map {
                            FeedItem(json: $0)
                        }
                        print(self.feed)
                        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                    }
                }
        }

        
    }
    
    func notificationsButtonPressed() {
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("challenges") as! ChallengesViewController
        self.navigationController!.pushViewController(VC1, animated: true)
        notificationButton.setImage(showerImage, forState: .Normal)
    }
    
    func setupRefreshControl() {
        
        // Programmatically inserting a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        
        // Setup the loading view, which will hold the moving graphics
        self.refreshLoadingView = UIView(frame: self.refreshControl!.bounds)
        self.refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        // Setup the color view, which will display the rainbowed background
        self.refreshColorView = UIView(frame: self.refreshControl!.bounds)
        self.refreshColorView.backgroundColor = UIColor.clearColor()
        self.refreshColorView.alpha = 0.30
        
        // Create the graphic image views
        compass_background = UIImageView(image: UIImage.gifWithName("drops"))
        
        // Add the graphics to the loading view
        self.refreshLoadingView.addSubview(self.compass_background)
        
        // Clip so the graphics don't stick out
        self.refreshLoadingView.clipsToBounds = true;
        
        // Hide the original spinner icon
        self.refreshControl!.tintColor = UIColor.clearColor()
        
        // Add the loading and colors views to our refresh control
        self.refreshControl!.addSubview(self.refreshColorView)
        self.refreshControl!.addSubview(self.refreshLoadingView)
        
        // Initalize flags
        self.isRefreshIconsOverlap = false;
        self.isRefreshAnimating = false;
        
        // When activated, invoke our refresh function
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(){
        
        //contact API
        loadFeed()
        
        let delayInSeconds = 3.0;
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            // When done requesting/reloading/processing invoke endRefreshing, to close the control
            self.refreshControl!.endRefreshing()
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Get the current size of the refresh controller
        let refreshBounds = self.refreshControl!.bounds;
//
//        // Distance the table has been pulled >= 0
//        let pullDistance = max(0.0, -self.refreshControl!.frame.origin.y);
//        
//        // Half the width of the table
//        let midX = self.tableView.frame.size.width / 2.0;
//        
//        // Calculate the width and height of our graphics
//        let compassHeight = self.compass_background.bounds.size.height;
//        let compassHeightHalf = compassHeight / 2.0;
//        
//        let compassWidth = self.compass_background.bounds.size.width;
//        let compassWidthHalf = compassWidth / 2.0;
//        
//        // Calculate the pull ratio, between 0.0-1.0
//        let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0;
//        
//        // Set the Y coord of the graphics, based on pull distance
//        let compassY = pullDistance / 2.0 - compassHeightHalf;
//        
//        // Calculate the X coord of the graphics, adjust based on pull ratio
//        var compassX = (midX + compassWidthHalf) - (compassWidth * pullRatio);
//        
//        // If the graphics have overlapped or we are refreshing, keep them together
//        if (self.isRefreshIconsOverlap || self.refreshControl!.refreshing) {
//            compassX = midX - compassWidthHalf;
//        }
//        
//        // Set the graphic's frames
//        var compassFrame = self.compass_background.frame;
//        compassFrame.origin.x = compassX;
//        compassFrame.origin.y = compassY;
//        
//        self.compass_background.frame = compassFrame;
//        
//        // Set the encompassing view's frames
//        refreshBounds.size.height = pullDistance;
        
        self.refreshColorView.frame = refreshBounds;
        self.refreshLoadingView.frame = refreshBounds;
        
        // If we're refreshing and the animation is not playing, then play the animation
        if (self.refreshControl!.refreshing && !self.isRefreshAnimating) {
            self.animateRefreshView()
        }
    }
    
    func animateRefreshView() {
        
        // Background color to loop through for our color view
        
        var colorArray = [UIColor.blue1, UIColor.blue2, UIColor.blue3, UIColor.blue4, UIColor.blue5, UIColor.blue6]
        
        // In Swift, static variables must be members of a struct or class
        struct ColorIndex {
            static var colorIndex = 0
        }
        
        // Flag that we are animating
        self.isRefreshAnimating = true;
        
        UIView.animateWithDuration(
            Double(0.3),
            delay: Double(0.0),
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                // Change the background color
                self.refreshColorView!.backgroundColor = colorArray[ColorIndex.colorIndex]
                ColorIndex.colorIndex = (ColorIndex.colorIndex + 1) % colorArray.count
            },
            completion: { finished in
                // If still refreshing, keep spinning, else reset
                if (self.refreshControl!.refreshing) {
                    self.animateRefreshView()
                }else {
                    self.resetAnimation()
                }
            }
        )
    }
    
    func resetAnimation() {
        
        // Reset our flags and }background color
        self.isRefreshAnimating = false;
        self.isRefreshIconsOverlap = false;
        self.refreshColorView.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return feed.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "FeedCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! FeedCell
        cell.info.text = ""
        cell.photo.image = UIImage(named: "placeholder")
        
        let feed = self.feed[indexPath.row]
        
        cell.photo.hnk_setImageFromURL(NSURL(string: feed.photo)!)
        cell.info.text = feed.data
        cell.name.text = "\(feed.firstName) \(feed.lastName)"
        cell.timestamp.text = feed.date
        cell.backgroundColor = UIColor(hexString: "#f1f1f1")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}