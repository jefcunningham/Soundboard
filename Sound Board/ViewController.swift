//
//  ViewController.swift
//  Sound Board
//
//  Created by Jef Cunningham on 6/2/17.
//  Copyright © 2017 Jef Cunningham. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    // create an array to hold the sounds and initialise it to empty
    var sounds : [Sound] = []
    // set up audio player
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // preload all the sounds form the core data
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // the context.fetch thingy need to be wrapped in a do-catch and try thingy
        do {
            try sounds = context.fetch(Sound.fetchRequest())
            // once we've fetched all the sounds we need to redraw the list
            tableView.reloadData()
        } catch {}
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name
        
        return cell
    }
    // code for selecting a row in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        
        do {
            try audioPlayer = AVAudioPlayer(data: sound.audio! as Data)
            audioPlayer!.play()
        } catch {}
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // the commit editingstyle function gives us the indexpath so we know the sound to delete
            let sound = sounds[indexPath.row]
            // get the context again
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            // tell it to delete this sound
            context.delete(sound)
            // save the context
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            // now we need to re-grab the new core data object and redraw the table
            do {
                try sounds = context.fetch(Sound.fetchRequest())
                // once we've fetched all the sounds we need to redraw the list
                tableView.reloadData()
            } catch {}
        }
    }
}

