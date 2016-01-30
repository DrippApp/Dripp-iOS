//
//  PlayerViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    
    var audioPlayer : AVAudioPlayer?
    var isPlaying = false
    var timer:NSTimer!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var albumName: UILabel!
    var playlist = [Song]()
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var albumArtwork: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlaylist()
        trackTitle.text = playlist[0].name
        albumName.text = playlist[0].album
        stopButton.setTitle("Cancel", forState: .Normal)
        
        if let audio = self.setupAudioPlayerWithFile(playlist[0].file, type:"mp3") {
            self.audioPlayer = audio
        }
        let album = UIImage(named: playlist[0].albumArtwork)
        albumArtwork.image = album
        let colors = album!.getColors()
        let albumColor = colors.backgroundColor
        let altAlbumColor = albumColor.adjust(0.2, green: 0.2, blue: 0.2, alpha: 0)
        bottomView.backgroundColor = altAlbumColor
        self.view.backgroundColor = albumColor
        
        if albumColor.isLight() {
            playedTime.textColor = UIColor.blackColor()
            stopButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            playedTime.textColor = UIColor.whiteColor()
            stopButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
        if altAlbumColor.isLight() {
            trackTitle.textColor = UIColor.blackColor()
            albumName.textColor = UIColor.blackColor()
            playPauseButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            trackTitle.textColor = UIColor.whiteColor()
            albumName.textColor = UIColor.whiteColor()
            playPauseButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        var audio:AVAudioPlayer?
        do {
            try audio = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audio
    }
    
    @IBAction func playOrPauseMusic(sender: AnyObject) {
        stopButton.setTitle("Stop", forState: .Normal)
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
            playPauseButton.setTitle("Play", forState: .Normal)
        } else {
            audioPlayer?.play()
            isPlaying = true
            playPauseButton.setTitle("Pause", forState: .Normal)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        //close view controller and stop music
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateTime() {
        let currentTime = Int(audioPlayer!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    func loadPlaylist() {
        playlist.append(Song(name: "Drake's Best Song", albumArtwork: "drake", id: 1, duration: 32, file: "sample", album: "Drake's Great Album"))
    }
}
