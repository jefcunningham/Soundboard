//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Jef Cunningham on 6/2/17.
//  Copyright © 2017 Jef Cunningham. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
    }

    func setupRecorder() {
        do {
            //Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
        
            // Create URL for the audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
        
            // Create settings for the audio recorder
            
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
        
            // create audiorecorder object
        
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
   }
