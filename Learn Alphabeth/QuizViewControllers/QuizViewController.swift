//
//  QuizViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 14.07.2022.
//

import UIKit
import AVFAudio
import Lottie
import StoreKit
import GoogleMobileAds


class QuizViewController: UIViewController, AVAudioPlayerDelegate {
    var timer = Timer()

    var adCounter = 0
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
    var selectedItemNumber = 0
    var player : AVAudioPlayer?
    var isFirestAnswer = true
    var correctAnswer : [Int] = []
    var wrongAnswer : [Int] = []
    var isStop = false
    let animationView = AnimationView()
    var buttonOption : [Int] = []
    var models = [SKProduct]()
    var bannerView: GADBannerView!
    var isAd = false
    var isinAd = false
    private var interstitial: GADInterstitialAd?
    enum Products : String,CaseIterable{
        case removeAds = "com.SIX11.elifba.remove"
    }
    var animationCount = 0
    var LeftButtonNumber = 0
    var rightButtonNumber = 1
    var MidButtonNumber = 2
    var quizMembers : [Int] = []
    var b = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        for b in 1...28{
            quizMembers.append(b)
            self.b+=1
        }
        print(quizMembers.count)

        quizMembers.shuffle()
        print(quizMembers)
        collectionAnimal1.delegate = self
        collectionAnimal1.dataSource = self
        //        collectionAnimal1.isScrollEnabled = false
        //        collectionAnimal1.isUserInteractionEnabled = false
        self.collectionAnimal1.isScrollEnabled = false
        SetupConstraints()
        if UIDevice.current.userInterfaceIdiom == .pad  {
            collectionAnimal1.contentInset = UIEdgeInsets(top: 0, left:view.frame.width*0.15, bottom: 0, right: view.frame.width*0.15);
        }else{
            collectionAnimal1.contentInset = UIEdgeInsets(top: 0, left:view.frame.width*0.05, bottom: 0, right: view.frame.width*0.05);
        }
     
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            self.dismiss(animated: true)
            
        }
        if isinAd==true{
            isinAd=false
            playMusic(name: "\(quizMembers[selectedItemNumber])s", type: "mp3")

        }
        if Utils.isPremium == "premium"{
            removeView.isHidden = true
        }else{
            createAdd()
            removeView.isHidden = false
            if UIDevice.current.userInterfaceIdiom == .pad  {
                bannerView = GADBannerView(adSize: GADAdSizeLeaderboard)

            }else{
                bannerView = GADBannerView(adSize: GADAdSizeBanner)

            }
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
    }
  
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    @IBAction func playyTapped(_ sender: UIButton) {
        playMusic(name: "\(quizMembers[selectedItemNumber])s", type: "mp3")

    }
    func SetupConstraints (){
        collectionAnimal1.contentInset = UIEdgeInsets(top: 0, left: view.frame.width*0.05, bottom: 0, right: view.frame.width*0.05)
        
        top1View.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.15)
        collectionAnimal1.anchor(top: removeView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.7)
        print(view.bounds.height)
        print(view.frame.height*0.3)
        bottom1View.anchor(top: collectionAnimal1.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height:  view.frame.height*0.15)
        
        homeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: top1View.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.045, paddingBottom: -view.frame.height*0.045, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        
        removeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: nil, trailing: top1View.trailingAnchor, paddingTop: view.frame.height*0.050, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -10, width: view.frame.width*0.35, height: view.frame.height*0.05)
//
//        leftButton.anchor(top: nil, bottom: nil, leading: nil, trailing: midButton.leadingAnchor, paddingTop: bottom1View.frame.height*0.1, paddingBottom: -bottom1View.frame.height*0.1, paddingLeft:  0, paddingRight: -view.frame.width*0.05, width: view.frame.height*0.11, height: view.frame.height*0.11)
//        midButton.anchor(top: nil, bottom: nil, leading: leftButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.11, height: view.frame.height*0.11)
//        rightButton.anchor(top: nil, bottom: nil, leading: midButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.11, height: view.frame.height*0.11)
        
        removeView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: 0, paddingRight: -view.frame.height*0.04, width: view.frame.width*0.11, height: view.frame.height*0.05)
        
        homeView.anchor(top:view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: view.frame.height*0.04, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        
        removeView.isUserInteractionEnabled = true
        removeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeTapped)))
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
        
        
        if UIDevice.current.userInterfaceIdiom == .pad  {

        leftButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: midButton.leadingAnchor, paddingTop: bottom1View.frame.height*0.1, paddingBottom: -100, paddingLeft:  0, paddingRight: -view.frame.width*0.05, width: view.frame.height*0.13, height: view.frame.height*0.12)
        midButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: leftButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -100, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.13, height: view.frame.height*0.12)
        rightButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: midButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -100, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.13, height: view.frame.height*0.12)
        }else{
            leftButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: midButton.leadingAnchor, paddingTop: bottom1View.frame.height*0.1, paddingBottom: -55, paddingLeft:  0, paddingRight: -view.frame.width*0.05, width: view.frame.height*0.11, height: view.frame.height*0.11)
            midButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: leftButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -55, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.11, height: view.frame.height*0.11)
            rightButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: midButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -55, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.11, height: view.frame.height*0.11)
            
        }
        
        
//        leftButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        rightButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        midButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//
   }
    
    
    
    @objc func exitTapped (){
        homeView.zoomIn()
        
        player?.stop()
        if selectedItemNumber < 27{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuizPopupViewController") as! QuizPopupViewController
            vc.providesPresentationContextTransitionStyle = true;
            vc.definesPresentationContext = true;
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            if interstitial != nil {
//                interstitial?.present(fromRootViewController: self)
//                isAd = true
//            } else {
//                print("Ad wasn't ready")
//                self.dismiss(animated: true)
//            }
            self.present(vc, animated: false, completion: nil)
            
        }else{
            player?.stop()
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                isAd = true
            } else {
                print("Ad wasn't ready")
                self.dismiss(animated: true)
            }
        }
        
        
    }
    @objc func homeTapped (){
        removeView.zoomIn()
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.removeAds.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    
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
    
    func successAnimation () {
        animationView.animation = Animation.named("success")
        animationView.frame = CGRect(x: view.frame.width*0.1, y: view.frame.height*0.03, width: view.frame.width*0.8, height: view.frame.height*0.8)
        animationView.loopMode = .playOnce
        self.animationView.isHidden = false
        
        animationView.play()
        
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
            self.animationView.isHidden = true
            
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    func failAnimation () {
        animationView.animation = Animation.named("fail")
        animationView.frame = CGRect(x: view.frame.width*0.3, y: view.frame.height*0.12, width: view.frame.width*0.4, height: view.frame.height*0.6)
        animationView.loopMode = .playOnce
        self.animationView.isHidden = false
        
        animationView.play()
        
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
            self.animationView.isHidden = true
            
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
        rightButton.zoomIn()
        if rightButtonNumber == quizMembers[selectedItemNumber]  {
            print("exists")
            if isFirestAnswer == true{
                correctAnswer.append(rightButtonNumber)
            }else{
                wrongAnswer.append(rightButtonNumber)
            }
            player?.stop()
            isStop = false
            collectionAnimal1.reloadData()
            rightButton.backgroundColor = .green
            adCounter+=1
            playMusic(name: "correctSound", type: "mp3")
            
            successAnimation()
            if selectedItemNumber > 26{
                print(correctAnswer)
                print(wrongAnswer)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(correctAnswer), forKey:"correctAnswers")
                UserDefaults.standard.set(try? PropertyListEncoder().encode(wrongAnswer), forKey:"wrongAnswers")
                goNextView()
                isFirestAnswer == true
                
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
                    
                    self.rightButton.backgroundColor = .white
                    self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                    self.collectionAnimal1.reloadData()
                    
                }
                if adCounter >= 6{
                    if interstitial != nil {
                        interstitial?.present(fromRootViewController: self)
                        adCounter = 0
                        player?.stop()
                        isinAd = true
                    } else {
                        print("Ad wasn't ready")
                        adCounter+=1
                    }
                }
            }
        }else{
            isFirestAnswer = false
            rightButton.backgroundColor = .red
            player?.stop()
            
            playMusic(name: "wrongSound", type: "mp3")
            
            failAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.rightButton.backgroundColor = .white
                
            }
        }
        
        //        if ((cellIds[selectedItemNumber].letterImage).contains(where: rightButton.titleLabel?.text?)) {
        //
        //        }
    }
    @IBAction func midButtonTapped(_ sender: Any) {
        midButton.zoomIn()
        print(selectedItemNumber)
        print(MidButtonNumber)
        if MidButtonNumber == quizMembers[selectedItemNumber]  {
            if isFirestAnswer == true{
                correctAnswer.append(MidButtonNumber)
            }else{
                wrongAnswer.append(MidButtonNumber)
            }
            isStop = false
            collectionAnimal1.reloadData()
            player?.stop()
            
            midButton.backgroundColor = .green
            adCounter+=1
            playMusic(name: "correctSound", type: "mp3")
            successAnimation()
            
            if selectedItemNumber > 26{
                UserDefaults.standard.set(try? PropertyListEncoder().encode(correctAnswer), forKey:"correctAnswers")
                UserDefaults.standard.set(try? PropertyListEncoder().encode(wrongAnswer), forKey:"wrongAnswers")
                goNextView()
                isFirestAnswer == true
                
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
                    self.midButton.backgroundColor = .white
                    self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                    self.collectionAnimal1.reloadData()
                }
                if adCounter >= 6{
                    if interstitial != nil {
                        interstitial?.present(fromRootViewController: self)
                        adCounter = 0
                        player?.stop()
                        isinAd = true
                    } else {
                        print("Ad wasn't ready")
                        adCounter+=1
                    }
                }
            }
        }else{
            isFirestAnswer = false
            
            midButton.backgroundColor = .red
            player?.stop()
            playMusic(name: "wrongSound", type: "mp3")
            
            failAnimation()
            
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
        destinationVC.isResult = true
        self.present(destinationVC, animated: true, completion: nil)
    }
    @IBAction func leftButtonTapped(_ sender: Any) {
        leftButton.zoomIn()
        if LeftButtonNumber == quizMembers[selectedItemNumber] {
            print("exists")
            if isFirestAnswer == true{
                correctAnswer.append(LeftButtonNumber)
            }else{
                wrongAnswer.append(LeftButtonNumber)
            }
            isStop = false
            collectionAnimal1.reloadData()
            player?.stop()
            leftButton.backgroundColor = .green
            adCounter+=1
            playMusic(name: "correctSound", type: "mp3")
            
            successAnimation()
            
            if selectedItemNumber > 26{
                print(selectedItemNumber)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(correctAnswer), forKey:"correctAnswers")
                UserDefaults.standard.set(try? PropertyListEncoder().encode(wrongAnswer), forKey:"wrongAnswers")
                goNextView()
                isFirestAnswer == true
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
                    self.leftButton.backgroundColor = .white
                    self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                    self.collectionAnimal1.reloadData()
                    
                }
                if adCounter >= 6{
                    if interstitial != nil {
                        interstitial?.present(fromRootViewController: self)
                        adCounter = 0
                        player?.stop()
                        isinAd = true
                    } else {
                        print("Ad wasn't ready")
                        adCounter+=1
                    }
                }
            }
            
        }else{
            isFirestAnswer = false
            
            leftButton.backgroundColor = .red
            player?.stop()
            
            playMusic(name: "wrongSound", type: "mp3")
            
            failAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.leftButton.backgroundColor = .white
                
            }
        }
    }
    
  
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isStop = false
        collectionAnimal1.reloadData()
        
    }
}



extension QuizViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        visibleRect.origin = collectionAnimal1.contentOffset
        visibleRect.size = collectionAnimal1.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = collectionAnimal1.indexPathForItem(at: visiblePoint)
        if let number = (visibleIndexPath?.row){
//            selectedItemNumber = quizMembers[visibleIndexPath!.row]
                selectedItemNumber = visibleIndexPath!.row
            var firstRandom = Int.random(in: 1..<14)
            if firstRandom == selectedItemNumber {
                if firstRandom == 13{
                    firstRandom-=1
                }else{
                    firstRandom+=1
                    
                }
            }
            var secondRandom = Int.random(in: 14..<28)
            if secondRandom == selectedItemNumber {
                if secondRandom == 28{
                    secondRandom-=1
                }else{
                    secondRandom+=1
                    
                }
            }
//            if secondRandom == firstRandom {
//                if secondRandom > 22 {
//                    secondRandom-=5
//                }else{
//                    secondRandom+=5
//
//                }
//            }
            
           print(secondRandom)
            print(firstRandom)
            print(visibleIndexPath)
//            selectedItemNumber = visibleIndexPath!.row
            var buttonOptions = [quizMembers[selectedItemNumber],(firstRandom),(secondRandom)]
            if buttonOptions[0]==buttonOptions[1]{
                buttonOptions[1]=buttonOptions[1]+1
            }
            if buttonOptions[0]==buttonOptions[2]{
                buttonOptions[2]=buttonOptions[2]+1
            }
            buttonOptions.shuffle()
            print("butti\(buttonOptions)")
            buttonOption = buttonOptions
            LeftButtonNumber = buttonOptions[0]
            MidButtonNumber = buttonOptions[1]
            rightButtonNumber = buttonOptions[2]
            isFirestAnswer = true
                leftButton.setImage(UIImage(named: "\(buttonOptions[0])"), for: .normal)
            midButton.setImage(UIImage(named: "\(buttonOptions[1])"), for: .normal)
            rightButton.setImage(UIImage(named: "\(buttonOptions[2])"), for: .normal)

          
            if isinAd == false{
                playMusic(name: "\(quizMembers[selectedItemNumber])s", type: "mp3")

            }
            
        }
        
        
        
        
        
        
        
        
        
        
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionAnimal1.dequeueReusableCell(withReuseIdentifier: "quizcell", for: indexPath) as! QuizCollectionViewCell
        
        cell.animalImg.image = UIImage(named:  "\(quizMembers[selectedItemNumber])t")
        cell.progressLabel.text = "\(selectedItemNumber)/28"
        cell.progressBar.setProgress(Float(selectedItemNumber)/28, animated: true)
        if isStop == true{
            cell.playImage.image = UIImage(named: "pauseBtn")
            
        }else{
            cell.playImage.image = UIImage(named: "playBtn")
            
        }
        
        //        cell.animalLabel.text = cellIds[indexPath.row].animalName
        //        cell.switch.setOn(isautoPlay, animated: true)
        //        cell.inimalLatter.text = cellIds[indexPath.row].letterImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad  {
            return view.frame.width*0.15

        }else{
            return view.frame.width*0.05

        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad  {
            return CGSize(width: view.frame.size.width*0.7, height: view.frame.size.height*0.6-50)

        }else{
            return CGSize(width: view.frame.size.width*0.9, height: view.frame.size.height*0.6-10)


        }
    }
    //
    //    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //        print(selectedItemNumber)
        let indexToScrollTo = IndexPath(item: selectedItemNumber, section: 0)
        collectionAnimal1.scrollToItem(at: indexToScrollTo, at: .right, animated: false)
        
    }
    
    
}

extension QuizViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if let oproduct = response.products.first{
            self.purchase(aproduct: oproduct)
        }
    }
    
    func purchase ( aproduct: SKProduct){
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchasing:
                print("pur")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                Utils.saveLocal(array: "premium", key: "purchase")
                Utils.isPremium = "premium"
                removeView.isHidden = true
                bannerView.isHidden = true
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("restore")
                Utils.saveLocal(array: "premium", key: "purchase")
                Utils.isPremium = "premium"
                removeView.isHidden = true
                bannerView.isHidden = true
            case .deferred:
                print("deffered")
            default: break
            }
            
        }
    }
    
    func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
}
extension QuizViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
    func createAdd() {
        let request = GADRequest()
        interstitial?.fullScreenContentDelegate = self
        GADInterstitialAd.load(withAdUnitID:Utils.fullScreenAdId,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
        }
        )
    }
    func interstitialWillDismissScreen(_ ad: GADInterstitialAd) {
        print("interstitialWillDismissScreen")
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Add banner to view and add constraints as above.
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}
