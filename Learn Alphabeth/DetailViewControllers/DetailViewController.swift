//
//  DetailViewController.swift
//  Learn Alphabeth
//
//  Created by Rashit on 03/07/2022.
//

import UIKit
import AVFAudio
import StoreKit
import GoogleMobileAds
import Lottie

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
    var isautoPlay : Bool = false
    var firstScrollİndex : Int?
    var isFirstOpen : Bool = true
    var adCounter = 0
    var isinAd = false
    let animationView = AnimationView()

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var homeView: UIImageView!
    
    @IBOutlet weak var removeView: UIImageView!
    @IBOutlet weak var collectionAnimal: UICollectionView!
    @IBOutlet weak var animalLetter: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var animalLabel: UILabel!
    
    
    @IBOutlet weak var removeAdsBtn: UIButton!
    
    @IBOutlet weak var prevView: UIImageView!
    
    @IBOutlet weak var playView: UIImageView!
    @IBOutlet weak var autonextView: UIImageView!
    
    @IBOutlet weak var nextView: UIImageView!
    
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var autoNextBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.temporary.id"
    }
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupUi()
        setupConstraints()
        collectionAnimal.delegate = self
        collectionAnimal.dataSource = self
        print(selectedItemNumber)
        collectionAnimal.contentInset
        //        removeBtn.layer.cornerRadius = (view.frame.height*0.045)/2
        //
        //        autoNextBtn.layer.cornerRadius = (view.frame.height*0.09)/2
        //        prevBtn.layer.cornerRadius = (view.frame.height*0.08)/2
        //        nextBtn.layer.cornerRadius = (view.frame.height*0.08)/2
        //        playBtn.layer.cornerRadius = (view.frame.height*0.09)/2
        //        self.collectionAnimal.backgroundColor = UIColor(red: 194/255, green: 213/255, blue: 236/255, alpha: 1)
        
        collectionAnimal.contentInset = UIEdgeInsets(top: 0, left: view.frame.width*0.05, bottom: 0, right: view.frame.width*0.05)
        createAdd()
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if isinAd==true{
            isinAd=false
            playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
            
        }
        
    }
    func homeAnimation (name:String) {
        animationView.animation = Animation.named(name)
        animationView.frame = CGRect(x: view.frame.width*0.3, y: 0, width: view.bounds.height*0.22, height: view.bounds.height*0.22)
        
        //        animationView.center = view.center
        animationView.loopMode = .loop
        self.animationView.isHidden = false
        
        animationView.play()
        
        view.addSubview(animationView)
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    @IBAction func homeBtnTap(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        removeBtn.zoomIn()
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.removeAds.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
        
        
        
        
    }
    
    
    //
    //
    
    
    
    
    func setupConstraints (){
        
        topView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.12)
        collectionAnimal.anchor(top: topView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.66)
        print(view.bounds.height)
        print(view.frame.height*0.3)
        bottomView.anchor(top: collectionAnimal.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height:  view.frame.height*0.22)
        autoNextBtn.anchor(top: nil, bottom: bottomView.bottomAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.7, height: view.frame.height*0.07)
        autonextView.anchor(top: nil, bottom: bottomView.bottomAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.5, height: view.frame.height*0.07)
        playBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.02, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.2, height: view.frame.height*0.09)
        playView.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.02, paddingLeft: 0, paddingRight: 0, width: view.frame.width*0.2, height: view.frame.height*0.09)
        nextBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: playBtn.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.025, paddingLeft: bottomView.frame.width*0.06, paddingRight: 0, width: view.frame.width*0.16, height: view.frame.height*0.075)
        nextView.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: playBtn.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.025, paddingLeft: bottomView.frame.width*0.06, paddingRight: 0, width: view.frame.width*0.16, height: view.frame.height*0.075)
        prevBtn.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: playBtn.leadingAnchor, paddingTop: 0, paddingBottom: -view.frame.height*0.025, paddingLeft: 0, paddingRight: -bottomView.frame.width*0.06, width: view.frame.width*0.16, height: view.frame.height*0.075)
        prevView.anchor(top: nil, bottom: autoNextBtn.topAnchor, leading: nil, trailing: playBtn.leadingAnchor, paddingTop: 0, paddingBottom: -view.frame.height*0.025, paddingLeft: 0, paddingRight: -bottomView.frame.width*0.06, width: view.frame.width*0.16, height: view.frame.height*0.075)
        removeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -view.frame.width*0.05, width: view.frame.width*0.11, height: view.frame.height*0.05)
        
        homeBtn.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        removeBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -view.frame.width*0.05, width: view.frame.width*0.11, height: view.frame.height*0.05)
        
        homeView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: view.frame.width*0.05, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        
        //        animalImage.anchor(top: collectionAnimal.topAnchor, bottom: collectionAnimal.bottomAnchor, leading: nil, trailing: nil, paddingTop: view.frame.height*0.165, paddingBottom: view.frame.height*0.165, paddingLeft: 0, paddingRight: 0, width: view.frame.height*0.22, height: view.frame.height*0.22)
        
    }
    
    
    
    @IBAction func autoPlaySwitchPressed(_ sender: UISwitch) {
        print(sender.isOn)
        if sender.isOn {
            isautoPlay = true
        }else{
            isautoPlay = false
        }
        collectionAnimal.reloadData()
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        
        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        print(isautoPlay)
        
    }
    public func playMusic (name:String,type:String){
        
        if let player = player, player.isPlaying{
            player.stop()
            playView.image = UIImage(named: "playBtn")
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
                playView.image = UIImage(named: "pauseBtn")
                
            }
            catch{
                print("not work")
            }
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")//It is working now! printed "finished"!
        playView.image = UIImage(named: "playBtn")
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
        autonextView.zoomIn()
        player?.stop()
        if isAuto == false{
            autonextView.image = UIImage(named: "autoNextActive")
            
            playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
            isAuto = true
        }else{
            isAuto = false
            autonextView.image = UIImage(named: "autoNextPassive")
            playView.image = UIImage(named: "playBtn")
            
        }
        //        setupUi()
    }
    @IBAction func beforePressed(_ sender: UIButton) {
        prevView.zoomIn()
        player?.stop()
        if selectedItemNumber > 0{
            selectedItemNumber -= 1
            
        }else{
            selectedItemNumber = cellIds.count-1
        }
        self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
        if isAuto == false{
            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
            
        }else{
            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        }
        //
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        nextView.zoomIn()
        player?.stop()
        if selectedItemNumber < cellIds.count-1{
            selectedItemNumber += 1
            if isautoPlay == true {
                playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
            }else{
                playView.image = UIImage(named: "playBtn")
                
            }
            
        }else{
            selectedItemNumber = 0
        }
        self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
        //        if isautoPlay == true {
        //            playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        //        }
        
        //        if isAuto == false{
        //            playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        //
        //        }
        //        setupUi()
        print(cellIds[selectedItemNumber].letterSound)
        //        playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
        
    }
    
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
        if isFirstOpen != true{
            selectedItemNumber = visibleIndexPath?.row
        }else{
            isFirstOpen = false
        }
        print(selectedItemNumber)
        player?.stop()
        if let number = selectedItemNumber  {
            if isautoPlay == true || isAuto == true{
                playMusic(name: cellIds[number].letterSound, type: "mp3")
                
            }
        }
        homeAnimation(name: "detail\(1)")
        adCounter+=1
        if isAuto == true{
            if adCounter >= 8{
                if interstitial != nil {
                    interstitial?.present(fromRootViewController: self)
                    adCounter = 0
                    player?.stop()
                    isinAd = true
                } else {
                    print("Ad wasn't ready")
                }
            }
        }else{
            if adCounter >= 4{
                if interstitial != nil {
                    interstitial?.present(fromRootViewController: self)
                    adCounter = 0
                    player?.stop()
                    isinAd = true
                } else {
                    print("Ad wasn't ready")
                }
            }
        }
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
    }
    
    
    
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        targetContentOffset.pointee = scrollView.contentOffset
    //        var indexes = self.collectionAnimal.indexPathsForVisibleItems
    //        indexes.sort()
    //        var index = indexes.first!
    //        let cell = self.collectionAnimal.cellForItem(at: index)!
    //        let position = self.collectionAnimal.contentOffset.x - cell.frame.origin.x
    //        if position > cell.frame.size.width/2{
    //           index.row = index.row+2
    //            print(index)
    //        }
    //        self.collectionAnimal.scrollToItem(at: index, at: .left, animated: true )
    //    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionAnimal.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DetailCollectionViewCell
        cell.animalImg.image = UIImage(named:  cellIds[indexPath.row].animalImage)
        cell.animalLabel.text = cellIds[indexPath.row].animalName
        cell.switch.setOn(isautoPlay, animated: true)
        cell.inimalLatter.text = cellIds[indexPath.row].letterImage
        cell.inimalLatter.font = cell.inimalLatter.font.withSize(view.frame.height*0.09)
        cell.animalLabel.font = cell.animalLabel.font.withSize(view.frame.height*0.04)

        //        cell.animalImg.anchor(top: collectionAnimal.topAnchor, bottom: collectionAnimal.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: collectionAnimal.frame.height*0.22, paddingBottom: -collectionAnimal.frame.height*0.22, paddingLeft: collectionAnimal.frame.width*0.25, paddingRight: collectionAnimal.frame.width*0.25, width: 0, height: collectionAnimal.frame.height*0.6)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width*0.9, height: view.frame.size.height*0.6-50)
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return view.frame.width*0.05
    //    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(selectedItemNumber)
        let indexToScrollTo = IndexPath(item: selectedItemNumber, section: 0)
        collectionAnimal.scrollToItem(at: indexToScrollTo, at: .right, animated: false)
        
        
    }
    
    
    
}
extension DetailViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
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
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("restore")
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
extension DetailViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
