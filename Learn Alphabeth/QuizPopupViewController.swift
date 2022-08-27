//
//  QuizPopupViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 22.07.2022.
//

import UIKit
import GoogleMobileAds

class QuizPopupViewController: UIViewController {
    @IBOutlet weak var dialogView: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var noView: UIImageView!
    @IBOutlet weak var yesView: UIImageView!
    private var interstitial: GADInterstitialAd?
    var isInAd = false
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.24, paddingBottom: -view.frame.height*0.24, paddingLeft: view.frame.width*0.07, paddingRight: -view.frame.width*0.07, width: 0, height: 0)
        yesView.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -view.frame.height*0.05, paddingLeft: view.frame.width*0.13, paddingRight: 0, width: view.frame.width*0.25, height: view.frame.width*0.12)
        noView.anchor(top: nil, bottom: cardView.bottomAnchor, leading: nil , trailing: cardView.trailingAnchor, paddingTop: 0, paddingBottom: -view.frame.height*0.05, paddingLeft: 0, paddingRight: -view.frame.width*0.13, width: view.frame.width*0.25, height: view.frame.width*0.12)
        dialogView.anchor(top: cardView.topAnchor, bottom: yesView.topAnchor, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor, paddingTop: cardView.frame.height*0.1, paddingBottom: -view.frame.height*0.05, paddingLeft: view.frame.width*0.1, paddingRight: -view.frame.width*0.1, width: 0, height: 0)
        yesView.isUserInteractionEnabled = true
        yesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        noView.isUserInteractionEnabled = true
        noView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notExitTapped)))
        cardView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isInAd {
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
        if Utils.isPremium != "premium"{
            createAdd()

        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    @objc func exitTapped (){
       
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                isInAd = true
            } else {
                print("Ad wasn't ready")
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
                
            }
       
    }

    @objc func notExitTapped(){
        dismiss(animated: true)
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
extension QuizPopupViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
