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
        // because you have these session things below they have to have try before them, 
        // when you have try you must wrap them all in a do-catch thingy
        do {
            //Create an audio session
            let session = AVAudioSession.sharedInstance()
            // you have to put 'try' in front of these and then wrap the entire thing in a 'do {} catch {}' thingy
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file
            // how to get ot the app's sandboxed documents directory
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            // print out the url of where we are storing the audio recording
            print("###############")
            print(audioURL)
            print("###############")
            
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
        if audioRecorder!.isRecording {
            // stop the recording
            audioRecorder?.stop()
            // chenge the button title to record
            recordButton.setTitle("Record", for: .normal)
        } else {
            // start the recording
            audioRecorder?.record()
            // change the button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
}
