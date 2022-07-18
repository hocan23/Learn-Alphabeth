//
//  QuizViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 14.07.2022.
//

import UIKit
import AVFAudio

class QuizViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var removeView: UIImageView!
    @IBOutlet weak var homeView: UIImageView!
    @IBOutlet weak var midButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var bottom1View: UIView!
    @IBOutlet weak var top1View: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var isSmall : Bool = false
    @IBOutlet weak var collectionAnimal1: UICollectionView!
    @IBOutlet weak var removeBtn: UIButton!
    var cellIds : [Alphabeth] = Utils.cellIds
    var selectedItemNumber = 0
    var player : AVAudioPlayer?
    var isFirestAnswer = true
    var correctAnswer : [Alphabeth] = []
    var wrongAnswer : [Alphabeth] = []
    var isStop = false

    override func viewDidLoad() {
        super.viewDidLoad()
        cellIds.shuffle()
        print(cellIds[0].animalName)
        collectionAnimal1.delegate = self
        collectionAnimal1.dataSource = self
        SetupConstraints()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print(correctAnswer)
        print(wrongAnswer)
    }
    @IBAction func playyTapped(_ sender: UIButton) {
        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        
    }
    func SetupConstraints (){
        collectionAnimal1.contentInset = UIEdgeInsets(top: 0, left: view.frame.width*0.05, bottom: 0, right: view.frame.width*0.05)
        
        top1View.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.15)
        collectionAnimal1.anchor(top: removeView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.02, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.6)
        print(view.bounds.height)
        print(view.frame.height*0.3)
        bottom1View.anchor(top: collectionAnimal1.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height:  view.frame.height*0.25)
        
        homeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: top1View.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.045, paddingBottom: -view.frame.height*0.045, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        
        removeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: nil, trailing: top1View.trailingAnchor, paddingTop: view.frame.height*0.050, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -10, width: view.frame.width*0.35, height: view.frame.height*0.05)
        
        leftButton.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.1, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
        midButton.anchor(top: nil, bottom: nil, leading: leftButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
        rightButton.anchor(top: nil, bottom: nil, leading: midButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
        
        removeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -15, width: view.frame.width*0.35, height: view.frame.height*0.05)
        
        homeView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        //        playView.isUserInteractionEnabled = true
        //        playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playTapped)))
        leftButton.layer.cornerRadius = 20
        leftButton.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        leftButton.layer.shadowOffset = CGSize(width: -3, height: 4)
        leftButton.layer.shadowRadius = 10
        leftButton.layer.shadowOpacity = 1
        leftButton.backgroundColor = UIColor.white
        leftButton.layer.masksToBounds = false
        
        midButton.layer.cornerRadius = 20
        midButton.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        midButton.layer.shadowOffset = CGSize(width: -3, height: 4)
        midButton.layer.shadowRadius = 10
        midButton.layer.shadowOpacity = 1
        midButton.backgroundColor = UIColor.white
        midButton.layer.masksToBounds = false
        
        
        rightButton.layer.cornerRadius = 20
        rightButton.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        rightButton.layer.shadowOffset = CGSize(width: -3, height: 4)
        rightButton.layer.shadowRadius = 10
        rightButton.layer.shadowOpacity = 1
        rightButton.backgroundColor = UIColor.white
        rightButton.layer.masksToBounds = false
    }
    @objc func exitTapped (){
        self.dismiss(animated: true)
    }
    //    @objc func playTapped (){
    //        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
    //    }
    public func playMusic (name:String,type:String){
        
        if let player = player, player.isPlaying{
            player.stop()
            isStop = false
            collectionAnimal1.reloadData()
//             pla.image = UIImage(named: "playBtn")
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
                isStop = true
                collectionAnimal1.reloadData()
                player.play()
                //                playView.image = UIImage(named: "pauseBtn")
            }
            catch{
                print("not work")
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func rightButtonTapped(_ sender: Any) {
        print(cellIds[selectedItemNumber].letterImage)
        if cellIds[selectedItemNumber].letterImage.contains((rightButton.titleLabel?.text)!) {
            print("exists")
            if isFirestAnswer == true{
                correctAnswer.append(cellIds[selectedItemNumber])
            }else{
                wrongAnswer.append(cellIds[selectedItemNumber])
            }
            player?.stop()
            isStop = false
            collectionAnimal1.reloadData()
            rightButton.backgroundColor = .green
            if selectedItemNumber > 2{
                goNextView()
                isFirestAnswer == true

            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    
                    self.rightButton.backgroundColor = .white
                    self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                    self.collectionAnimal1.reloadData()
                    
                }
            }
        }else{
            isFirestAnswer = false
            rightButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.rightButton.backgroundColor = .white
                
            }
        }
        
        //        if ((cellIds[selectedItemNumber].letterImage).contains(where: rightButton.titleLabel?.text?)) {
        //
        //        }
    }
    @IBAction func midButtonTapped(_ sender: Any) {
        if cellIds[selectedItemNumber].letterImage.contains((midButton.titleLabel?.text)!) {
            print("exists")
            if isFirestAnswer == true{
                correctAnswer.append(cellIds[selectedItemNumber])
            }else{
                wrongAnswer.append(cellIds[selectedItemNumber])
            }
            isStop = false
            collectionAnimal1.reloadData()
            player?.stop()

            midButton.backgroundColor = .green
            if selectedItemNumber > 2{
                goNextView()
                isFirestAnswer == true

            }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.midButton.backgroundColor = .white
                self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                self.collectionAnimal1.reloadData()
            }
            }
        }else{
            isFirestAnswer = false
            
            midButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.midButton.backgroundColor = .white
                
            }
            
        }
    }
    func goNextView (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.correctAnswer = correctAnswer
        destinationVC.wrongAnswer = wrongAnswer
        destinationVC.isSmall = isSmall
        self.present(destinationVC, animated: true, completion: nil)
    }
    @IBAction func leftButtonTapped(_ sender: Any) {
        if cellIds[selectedItemNumber].letterImage.contains((leftButton.titleLabel?.text)!) {
            print("exists")
            if isFirestAnswer == true{
                correctAnswer.append(cellIds[selectedItemNumber])
            }else{
                wrongAnswer.append(cellIds[selectedItemNumber])
            }
            isStop = false
            collectionAnimal1.reloadData()
            player?.stop()
            leftButton.backgroundColor = .green
            if selectedItemNumber > 2{
                goNextView()
                isFirestAnswer == true
            }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.leftButton.backgroundColor = .white
                self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                self.collectionAnimal1.reloadData()
            }
            }
            
        }else{
            isFirestAnswer = false
            
            leftButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.leftButton.backgroundColor = .white
                
            }
        }
    }
    
    @IBAction func switchPositionChanged(_ sender: UISwitch) {
        if sender.isOn {
            isSmall = true
        }else{
            isSmall = false
        }
        collectionAnimal1.reloadData()
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isStop = false
        collectionAnimal1.reloadData()
       
        }
}



extension QuizViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIds.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        visibleRect.origin = collectionAnimal1.contentOffset
        visibleRect.size = collectionAnimal1.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = collectionAnimal1.indexPathForItem(at: visiblePoint)
        if let number = visibleIndexPath{
            selectedItemNumber = (visibleIndexPath?.row)!
            
            
            let visibleIndexPath = selectedItemNumber
            var firstRandom = Int.random(in: 0..<26)
            var secondRandom = Int.random(in: 0..<26)
            
            if firstRandom != visibleIndexPath && secondRandom != visibleIndexPath && secondRandom != firstRandom {
                var buttonOptions = [(cellIds[visibleIndexPath].letterImage),cellIds[firstRandom].letterImage,cellIds[secondRandom].letterImage]
                buttonOptions.shuffle()
                if isSmall == false{
                    leftButton.setTitle(String(buttonOptions[0].prefix(1)), for: .normal)
                    midButton.setTitle(String(buttonOptions[1].prefix(1)), for: .normal)
                    rightButton.setTitle(String(buttonOptions[2].prefix(1)), for: .normal)
                    
                }else{
                    leftButton.setTitle(String(buttonOptions[0].suffix(1)), for: .normal)
                    midButton.setTitle(String(buttonOptions[1].suffix(1)), for: .normal)
                    rightButton.setTitle(String(buttonOptions[2].suffix(1)), for: .normal)
                }
            }
            
        }
        
       
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionAnimal1.dequeueReusableCell(withReuseIdentifier: "quizcell", for: indexPath) as! QuizCollectionViewCell
        cell.animalImg.image = UIImage(named:  cellIds[indexPath.row].animalImage)
        cell.progressLabel.text = "\(selectedItemNumber)/26"
        cell.progressBar.setProgress(Float(selectedItemNumber)/26, animated: true)
        if isStop == true{
            cell.playImage.image = UIImage(named: "pauseBtn")

        }else{
            cell.playImage.image = UIImage(named: "playBtn")

        }

        print(cellIds[indexPath.row].letterImage)
        //        cell.animalLabel.text = cellIds[indexPath.row].animalName
        //        cell.switch.setOn(isautoPlay, animated: true)
        //        cell.inimalLatter.text = cellIds[indexPath.row].letterImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width*0.9, height: view.frame.size.height*0.6-100)
    }
    //
    //    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //        print(selectedItemNumber)
        let indexToScrollTo = IndexPath(item: selectedItemNumber, section: 0)
        collectionAnimal1.scrollToItem(at: indexToScrollTo, at: .right, animated: false)
        
        
 
    }
    
    
}
