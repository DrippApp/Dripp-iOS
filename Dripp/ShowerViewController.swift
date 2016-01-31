//
//  ShowerViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class ShowerViewController: UITableViewController {
    
    var playlists  = [Playlist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadPlaylists()
        
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
        
    }
    
    func loadPlaylists() {
        playlists.append(Playlist(name: "Drake 1", duration: "2:36", albumArtwork: "shower", recommended: true))
        playlists.append(Playlist(name: "Drake 2", duration: "5:43", albumArtwork: "shower", recommended: false))
        playlists.append(Playlist(name: "Drake 3", duration: "9:08", albumArtwork: "shower", recommended: false))
        playlists.append(Playlist(name: "Drake 4", duration: "15:40", albumArtwork: "shower", recommended: false))
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
        return playlists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "ShowerCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! ShowerCell
        cell.name.text = ""
        cell.photo.image = UIImage(named: "placeholder")
        
        let playlist = self.playlists[indexPath.row]
        
        cell.photo.image = UIImage(named: playlist.albumArtwork)
        cell.name.text = playlist.name
        cell.duration.text = playlist.duration
        
        if playlist.recommended {
            //do something here
        }
        
        cell.backgroundColor = UIColor(hexString: "#f1f1f1")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("openPlayer", sender: self)
    }
    
}