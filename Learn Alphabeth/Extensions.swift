//
//  Extensions.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 5.07.2022.
//

import Foundation
import AVFAudio


public func playMusic (name:String,type:String){
let urlString = Bundle.main.path(forResource: name, ofType: type)
var player : AVAudioPlayer?
do {
    try AVAudioSession.sharedInstance().setMode(.default)
    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    guard let urlString = urlString else{
        return
    }
    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
    guard let player = player else{
        return
    }
    player.play()
}
catch{
    print("not work")
}
}
