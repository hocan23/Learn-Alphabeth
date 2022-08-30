//
//  PopupViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit
import AVFAudio
import GoogleMobileAds
class PopupViewController: UIViewController, AVAudioPlayerDelegate {

  
    @IBOutlet weak var letterImage: UIImageView!
    
    @IBOutlet weak var exitView: UIImageView!
    @IBOutlet weak var playView: UIImageView!
    @IBOutlet weak var viewCard: UIView!
    var isSmall : Bool = false
    var cellIds : [Alphabeth] = Utils.cellIds
    var selectedItemNumber : Int = 0
    var player : AVAudioPlayer?
    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd?
    var isShowAd = false
    var isinAd = false
    override func viewDidLoad() {
        super.viewDidLoad()

       setupConstraits()
        playView.isUserInteractionEnabled = true
        playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playTapped)))
        exitView.isUserInteractionEnabled = true
        exitView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        
        
    }
    func setupConstraits (){
        print(view.frame.height)
        if UIDevice.current.userInterfaceIdiom == .pad  {
            viewCard.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.24, paddingBottom: -view.frame.height*0.24, paddingLeft: view.frame.width*0.14, paddingRight: -view.frame.width*0.14, width: 0, height: 0)
            letterImage.anchor(top: viewCard.topAnchor, bottom: playView.topAnchor, leading: viewCard.leadingAnchor, trailing: viewCard.trailingAnchor, paddingTop: 50, paddingBottom: -50, paddingLeft: 50, paddingRight: -50, width: 0, height: 0)
        }else{
            viewCard.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.24, paddingBottom: -view.frame.height*0.24, paddingLeft: view.frame.width*0.07, paddingRight: -view.frame.width*0.07, width: 0, height: 0)
            letterImage.anchor(top: viewCard.topAnchor, bottom: playView.topAnchor, leading: viewCard.leadingAnchor, trailing: viewCard.trailingAnchor, paddingTop: view.frame.width*0.15, paddingBottom: -view.frame.width*0.15, paddingLeft: view.frame.width*0.15, paddingRight: -view.frame.width*0.15, width: 0, height: 0)
        }
      
       
        playView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.29, paddingLeft: view.frame.width*0.31, paddingRight: 0, width: view.frame.height*0.07, height: view.frame.height*0.07)
        exitView.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -view.frame.height*0.29, paddingLeft: 0, paddingRight: -view.frame.width*0.31, width: view.frame.height*0.07, height: view.frame.height*0.07)
       
        viewCard.layer.cornerRadius = 20
        if Utils.isPremium != "premium"{
        createAdd()
        }
//        bannerView = GADBannerView(adSize: GADAdSizeBanner)
//        bannerView.adUnitID = Utils.bannerId
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        bannerView.delegate = self
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.viewCard && touch?.view != self.playView {

                if isShowAd==true{
                if interstitial != nil {
                    interstitial?.present(fromRootViewController: self)
                    Utils.practiceAdCounter = 0
                    Utils.isPopAd = true
                    Utils.ispracticePopUpShowAd = true
                } else {
                    print("Ad wasn't ready")
                    self.dismiss(animated: true)

                }
                }else{
                    self.dismiss(animated: true)

                }            }
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(isinAd)
        if Utils.isPopAd == true {
            Utils.isPopAd = false
            self.dismiss(animated: true)
            
        }else{
        letterImage.image=UIImage(named: "\(selectedItemNumber)")
        print("\(selectedItemNumber+1)p")
        playMusic(name: "\(selectedItemNumber)", type: "mp3")
        }
    }
  
    @objc func playTapped(){
        print(selectedItemNumber)
        playMusic(name: "\(selectedItemNumber)", type: "mp3")

    }
    
    @objc func exitTapped(){
        if isShowAd==true{
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            Utils.practiceAdCounter = 0
            Utils.isPopAd = true
        } else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)

        }
        }else{
            self.dismiss(animated: true)

        }    }
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
            
        playView.image = UIImage(named: "playBtn")

        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PopupViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
//    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//        // Add banner to view and add constraints as above.
//        addBannerViewToView(bannerView)
//    }
//    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.dismiss(animated: true)
        
    }
}
