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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackTitle.text = "Testing song"
        
        if let audio = self.setupAudioPlayerWithFile("sample", type:"mp3") {
            self.audioPlayer = audio
        }
        
        trackTitle.text = stringFromTimeInterval(audioPlayer!.duration)
        
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
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        } else {
            audioPlayer?.play()
            isPlaying = true
            
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
    
    @IBAction func stopMusic(sender: AnyObject) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
    }
}
