//
//  AudioPlayer.swift
//  Restart
//
//  Created by Shivang Mishra on 10/06/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Cound not play the sound")
        }
    }
}
