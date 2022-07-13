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
    var isPlay : Bool = false
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var collectionAnimal: UICollectionView!
    @IBOutlet weak var animalLetter: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var animalLabel: UILabel!
    
    
    @IBOutlet weak var removeAdsBtn: UIButton!
 
    

    
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var autoNextBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUi()
        setupConstraints()
        collectionAnimal.delegate = self
        collectionAnimal.dataSource = self
        removeBtn.layer.cornerRadius = (view.frame.height*0.045)/2
       
        autoNextBtn.layer.cornerRadius = (view.frame.height*0.09)/2
        prevBtn.layer.cornerRadius = (view.frame.height*0.08)/2
        nextBtn.layer.cornerRadius = (view.frame.height*0.08)/2
        playBtn.layer.cornerRadius = (view.frame.height*0.09)/2
        self.collectionAnimal.backgroundColor = UIColor(named: "clear")
       
    }
    override func viewWillAppear(_ animated: Bool) {
   
       
    }
   
    
    @IBAction func homeBtnTap(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    
    
//
//
    
    
    
    
    func setupConstraints (){
       
        topView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.15)
        collectionAnimal.anchor(top: topView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.55)
        print(view.bounds.height)
        print(view.frame.height*0.3)
        bottomView.anchor(top: collectionAnimal.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height:  view.frame.height*0.3)
        autoNextBtn.anchor(top: nil, bottom: bottomView.bottomAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.5, height: view.frame.height*0.09)
        playBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -bottomView.frame.height*0.2, paddingLeft: 0, paddingRight: 0, width: view.frame.height*0.09, height: view.frame.height*0.09)
        nextBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: playBtn.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -bottomView.frame.height*0.225, paddingLeft: bottomView.frame.width*0.06, paddingRight: 0, width: view.frame.height*0.08, height: view.frame.height*0.08)
        prevBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: playBtn.leadingAnchor, paddingTop: 0, paddingBottom: -bottomView.frame.height*0.225, paddingLeft: 0, paddingRight: -bottomView.frame.width*0.06, width: view.frame.height*0.08, height: view.frame.height*0.08)
        homeBtn.anchor(top: topView.topAnchor, bottom: topView.bottomAnchor, leading: topView.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.045, paddingBottom: -view.frame.height*0.045, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.055, height: view.frame.height*0.045)
        removeBtn.anchor(top: topView.topAnchor, bottom: topView.bottomAnchor, leading: nil, trailing: topView.trailingAnchor, paddingTop: view.frame.height*0.050, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -10, width: view.frame.width*0.3, height: view.frame.height*0.035)
//        animalImage.anchor(top: collectionAnimal.topAnchor, bottom: collectionAnimal.bottomAnchor, leading: nil, trailing: nil, paddingTop: view.frame.height*0.165, paddingBottom: view.frame.height*0.165, paddingLeft: 0, paddingRight: 0, width: view.frame.height*0.22, height: view.frame.height*0.22)

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
//                setupUi()
                playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
                self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
            }
        }else{
            isAuto = false
        }
       
        }
  
    
    @IBAction func autoNextPressed(_ sender: UIButton) {
        player?.stop()
        if isAuto == false{
        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        isAuto = true
        }else{
            isAuto = false
            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)

        }
//        setupUi()
    }
    @IBAction func beforePressed(_ sender: UIButton) {
        player?.stop()
        if selectedItemNumber > 0{
            selectedItemNumber -= 1
            
        }else{
            selectedItemNumber = cellIds.count-1
        }
        self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
        if isAuto == false{
            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)

        }
//        setupUi()
//        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")

    }
    @IBAction func nextPressed(_ sender: UIButton) {
        player?.stop()
        if selectedItemNumber < cellIds.count-1{
            selectedItemNumber += 1
            
        }else{
            selectedItemNumber = 0
        }
        self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
//        if isAuto == false{
//            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
//
//        }
//        setupUi()
        print(cellIds[selectedItemNumber].letterSound)
//        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        
    }
//    func setupUi () {
//        animalImage.image = UIImage(named:  cellIds[selectedItemNumber].animalImage)
//        letterImage.image = UIImage(named: cellIds[selectedItemNumber].letterImage)
//        animalName.text = cellIds[selectedItemNumber].animalName
//
//    }
    
}



protocol DetailViewControllerDelegate: AnyObject{
    
    func diddismis()
    
}

extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIds.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var visibleRect = CGRect()
        visibleRect.origin = collectionAnimal.contentOffset
        visibleRect.size = collectionAnimal.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = collectionAnimal.indexPathForItem(at: visiblePoint)
        selectedItemNumber = visibleIndexPath?.row
        player?.stop()
        
       playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
    }
    
   
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.collectionAnimal.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.collectionAnimal.cellForItem(at: index)!
        let position = self.collectionAnimal.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width/2{
           index.row = index.row+1
        }
        self.collectionAnimal.scrollToItem(at: index, at: .left, animated: true )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionAnimal.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DetailCollectionViewCell
        cell.animalImg.image = UIImage(named:  cellIds[indexPath.row].animalImage)
        cell.inimalLatter.image = UIImage(named: cellIds[indexPath.row].letterImage)
        cell.animalLabel.text = cellIds[indexPath.row].animalName
        
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 1
//        cell.animalImg.anchor(top: collectionAnimal.topAnchor, bottom: collectionAnimal.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: collectionAnimal.frame.height*0.22, paddingBottom: -collectionAnimal.frame.height*0.22, paddingLeft: collectionAnimal.frame.width*0.25, paddingRight: collectionAnimal.frame.width*0.25, width: 0, height: collectionAnimal.frame.height*0.6)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width-20, height: collectionAnimal.frame.size.height-40)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
          let indexToScrollTo = IndexPath(item: selectedItemNumber, section: 0)
          self.collectionAnimal.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
         
      }
    
    
    
}
