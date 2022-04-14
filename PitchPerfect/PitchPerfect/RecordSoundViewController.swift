//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Saad altwaim on 5/22/20.
//  Copyright © 2020 Saad Altwaim. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundViewController : UIViewController, AVAudioRecorderDelegate {
    var audioRecorder : AVAudioRecorder!      // note page 25  #### -1
    @IBOutlet weak var RecordLable: UILabel!
    @IBOutlet weak var recoedButton: UIButton!
    @IBOutlet weak var st_recordingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        st_recordingButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/* func viewWillappear(_ animted : Bool)
    {
    super.viewWillAppear(animated)
     print("viewWillAppear called")
    }
*/
    @IBAction func reCord(_ sender: Any) {
        st_recordingButton.isEnabled = true
        RecordLable.text = "Recording in prograss"
        recoedButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String //note page 25  ####-2
        let recordingName = "recordedVoice.wav" //note page 25  ####3
        let pathArray = [dirPath, recordingName]//note page 25  ####4
        let filePath = URL(string: pathArray.joined(separator: "/")) //###
        
        _ = AVAudioSession.sharedInstance() //note page 25  ####6
        //try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
       // try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeVoiceChat, options: AVAudioSessionCategoryOptions.mixWithOthers)
        
        let audioSession = AVAudioSession.sharedInstance()  //7
        do {

            try! audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayAndRecord failed.")
        }
        
        //knowledge.udacity.com/questions/201081
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]) //note page 25  ####8
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()//note page 25  ####10
        audioRecorder.record() //note page 25  ####11
        
    }
    @IBAction func St_Reord(_ sender: Any) {
    
        st_recordingButton.isEnabled = false
        RecordLable.text = "Stop_Record is pressed"
        recoedButton.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) { //page 26
            if flag
            {3
               performSegue(withIdentifier: "st_RecordSound", sender: audioRecorder.url) // segu name
            }
            else
            {
                print("the record no work")
            }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "st_RecordSound"
        {
            let playSondsVC = segue.destination as! PlaySoundViewController
            let recordAudioURL = sender as! URL
            playSondsVC.recordedAudioURL = recordAudioURL
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
