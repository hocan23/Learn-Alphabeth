//
//  DetailViewController.swift
//  Learn Alphabeth
//
//  Created by Rashit on 03/07/2022.
//

import UIKit
import AVFAudio
class DetailViewController: UIViewController ,AVAudioPlayerDelegate{
    var name : String = ""
    var type : String = ""
    var cellIds : [Alphabeth]!
    var player : AVAudioPlayer?
    var selectedItem : Alphabeth!
    var selectedItemNumber : Int!
    weak var delegate : DetailViewControllerDelegate?
    var isAuto : Bool = false
    
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var removeAdsBtn: UIButton!
    
    @IBOutlet weak var letterImage: UIImageView!
    var letterImageName = ""
    
    @IBOutlet weak var animalImage: UIImageView!
    var animalImageName = ""
    
    @IBOutlet weak var animalName: UILabel!
    var animalNameText = ""
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var autoNextBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
      


      
    }
   
    
    @IBAction func homeBtnTap(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
    }
    public func playMusic (name:String,type:String){
        
        if let player = player, player.isPlaying{
            player.stop()
            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        }else{
            
            let urlString = Bundle.main.path(forResource: name, ofType: type)
            
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self

                guard let player = player else{
                    return
                }
                player.play()
                playBtn.setImage(UIImage(named: "pauseBtn"), for: .normal)

            }
            catch{
                print("not work")
            }
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            print("finished")//It is working now! printed "finished"!
        playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        if selectedItemNumber < cellIds.count-1{
            if isAuto == true{
                selectedItemNumber += 1
                setupUi()
                playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")

            }
        }else{
            isAuto = false
        }
       
        }
    func playAuto (){
        player?.stop()
        selectedItemNumber = 0

        if selectedItemNumber < cellIds.count-1{
            playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
            setupUi()
        }else{
            selectedItemNumber = 0
            player?.stop()
            setupUi()
        }

    }
    
    @IBAction func autoNextPressed(_ sender: UIButton) {
        selectedItemNumber = 0
        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        isAuto = true
    }
    @IBAction func beforePressed(_ sender: UIButton) {
        player?.stop()
        if selectedItemNumber > 0{
            selectedItemNumber += 1
        }else{
            selectedItemNumber = cellIds.count-1
        }
        setupUi()
//        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")

    }
    @IBAction func nextPressed(_ sender: UIButton) {
        player?.stop()
        if selectedItemNumber < cellIds.count-1{
            selectedItemNumber += 1
        }else{
            selectedItemNumber = 0
        }
        setupUi()
        print(cellIds[selectedItemNumber].letterSound)
//        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        
    }
    func setupUi () {
        animalImage.image = UIImage(named:  cellIds[selectedItemNumber].animalImage)
        letterImage.image = UIImage(named: cellIds[selectedItemNumber].letterImage)
        animalName.text = cellIds[selectedItemNumber].animalName
        
    }
    
}



protocol DetailViewControllerDelegate: AnyObject{
    
    func diddismis()
    
}
