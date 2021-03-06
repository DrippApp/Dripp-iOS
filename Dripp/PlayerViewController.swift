//
//  PlayerViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import AVFoundation
import UIKit
import SABlurImageView
import SpriteKit
import SwiftGifOrigin
import EasyAnimation
import WatchConnectivity

class PlayerViewController: UIViewController, WCSessionDelegate {
    
    var watchSession : WCSession?
    var audioPlayer : AVAudioPlayer?
    //get size of screen
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var waterView : WaterView!
    var playlist = [Song]()
    var isPlaying = false
    var timer:NSTimer!
    var progress:NSTimer!
    @IBOutlet weak var gifBackground: UIImageView!
    var currentPlayingSong = 0 {
        didSet{
            //when a song is over this will increase
            //Then it will play next song
            if currentPlayingSong < playlist.count {
                playSong(playlist[currentPlayingSong])
            } else {
                currentPlayingSong = 0
            }
        }
    }
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var albumArtwork: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var backgroundImage: SABlurImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create water based on screen size
        waterView = WaterView(frame: CGRectMake(0, 0, screenSize.size.width, screenSize.size.height+15))
        
        if(WCSession.isSupported()){
            watchSession = WCSession.defaultSession()
            watchSession!.delegate = self
            watchSession!.activateSession()
        }
        
        if let message : String = "Shower - Becky G" {
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
        
        //Create playlist
        loadPlaylist()
        //Load water
        waterView.center = self.view.center
        waterView.userInteractionEnabled = true
        waterView.backgroundColor = UIColor.clearColor()
        waterView.currentWaterColor = UIColor.blueHeader.colorWithAlphaComponent(0.3)
        waterView.percentum = 0.0
        //insertSubview:aboveSubview:
        self.view.insertSubview(waterView, aboveSubview: backgroundImage)
        //Play first song
        playSong(playlist[0])
        
        // Put in gif
        //gifBackground.image = UIImage.gifWithName("drops")
        
    }
    
    @IBAction func messageChanged(sender: AnyObject) {
        if let message : String = "testing" {
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
        let message : String = applicationContext["message"] as! String
        if message == "stop" {
            closePlayer()
        } else if message == "play" {
            playPauseMusic()
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
        playPauseMusic()
    }
    
    func playPauseMusic() {
        stopButton.setTitle("Stop", forState: .Normal)
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
            playPauseButton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        } else {
            audioPlayer?.play()
            isPlaying = true
            playPauseButton.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }

    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        closePlayer()
    }
    
    func closePlayer() {
        //close view controller and stop music
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateTime() {
        let currentTime = Float(audioPlayer!.currentTime)
        let duration = Float(audioPlayer!.duration)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        let percentage = Float(currentTime) / Float(duration)
        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        
        if currentTime == duration {
            currentPlayingSong++
        }
        
        progressBar.setProgress(percentage, animated: true)
        let newPercentage = Float(currentTime) / Float(duration+100)
        waterView.percentum = newPercentage
        //waterView.frame = CGRectOffset( waterView.frame, 0, 10 )
    }
    
    func loadPlaylist() {
        playlist.append(Song(name: "Shower", albumArtwork: "shower", id: 1, duration: 32, file: "shower", album: "Becky G"))
    }
    
    func playSong(song: Song) {
        trackTitle.text = song.name
        albumName.text = song.album
        stopButton.setTitle("Cancel", forState: .Normal)
        progressBar.progressTintColor = UIColor(hexString: "#E83939")
        progressBar.setProgress(0, animated: false)
        
        if let audio = self.setupAudioPlayerWithFile(song.file, type:"mp3") {
            self.audioPlayer = audio
        }
        let album = UIImage(named: song.albumArtwork)
        albumArtwork.image = album
        //add blur
        backgroundImage.image = album
        backgroundImage.addBlurEffect(30, times: 20)
        //let colors = album!.getColors()
        //let albumColor = colors.backgroundColor
        let albumColor = UIColor(hexString: "#E83939")
        //let altAlbumColor = albumColor.adjust(0.2, green: 0.2, blue: 0.2, alpha: 0)
        bottomView.backgroundColor = albumColor
        self.view.backgroundColor = albumColor
        
        albumArtwork.layer.borderWidth = 1
        albumArtwork.layer.borderColor = UIColor.clearColor().CGColor
        albumArtwork.layer.cornerRadius = albumArtwork.frame.height/2
        albumArtwork.layer.masksToBounds = false
        albumArtwork.clipsToBounds = true
        
        if albumColor.isLight() {
            playedTime.textColor = UIColor.blackColor()
            stopButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            playedTime.textColor = UIColor.whiteColor()
            stopButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
        if albumColor.isLight() {
            UIApplication.sharedApplication().statusBarStyle = .LightContent
            trackTitle.textColor = UIColor.blackColor()
            albumName.textColor = UIColor.blackColor()
            playPauseButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            trackTitle.textColor = UIColor.whiteColor()
            albumName.textColor = UIColor.whiteColor()
            playPauseButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }

    }
}
