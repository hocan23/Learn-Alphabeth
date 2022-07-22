//
//  HomeViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit
import Lottie
import StoreKit
import GoogleMobileAds

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var bottomLeftLABEL: UILabel!
    @IBOutlet weak var bottomRightImage: UIImageView!
    @IBOutlet weak var bottomRightLabel: UILabel!
    
    @IBOutlet weak var removeView: UIImageView!
    let animationView = AnimationView()
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.SIX11.learnABC.removeAds"
    }
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    var isAd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Utils.isPremium = Utils.readLocal(key: "purchase")
        print(Utils.isPremium)
        setupConstraits()
        topLeftView.isUserInteractionEnabled = true
        topLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topLeftTapped)))
        topRightView.isUserInteractionEnabled = true
        topRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightTapped)))
        bottomLeftView.isUserInteractionEnabled = true
        bottomLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomLeftTapped)))
        bottomRightView.isUserInteractionEnabled = true
        bottomRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomRightTapped)))
        removeView.isUserInteractionEnabled = true
        removeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTapped)))
        
        Utils.saveLocal(array: [Utils.cellIds[0]], key: "SavedPerson")
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewWillAppear(_ animated: Bool) {
        //        homeAnimation()
        if Utils.isPremium == "premium"{
            removeView.isHidden = true
        }else{
            createAdd()
            removeView.isHidden = false
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
    }
    
    
    func setupConstraits (){
        print(view.frame.width)
        if UIDevice.current.userInterfaceIdiom == .pad  {
            topLeftView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: view.frame.width*0.1, paddingRight: 0, width: (view.frame.width)*0.35, height: view.frame.height*0.3)
            topRightView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: topLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: view.frame.width*0.1, paddingRight: -(view.frame.width)*0.1, width: (view.frame.width)*0.35, height: view.frame.height*0.3)
            bottomLeftView.anchor(top: topLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop:view.frame.height*0.03, paddingBottom: 0, paddingLeft: view.frame.width*0.1, paddingRight: 40, width:  (view.frame.width)*0.35, height: view.frame.height*0.3)
            bottomRightView.anchor(top: topRightView.bottomAnchor, bottom: nil, leading: bottomLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: view.frame.width*0.1, paddingRight: -view.frame.width*0.1, width: (view.frame.width)*0.35, height: view.frame.height*0.3)
            removeView.anchor(top: bottomLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: -75, paddingLeft: view.frame.width*0.1, paddingRight: -view.frame.width*0.1, width: 0, height: 0)
            headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: view.frame.width*0.124, paddingRight: -view.frame.width*0.124, width: 0, height: view.frame.height*0.08)
        }else{
            if Utils.isPremium == "premium"{
                topLeftView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 40, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: (view.frame.width-60)/2, height: view.frame.height*0.3)
                topRightView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: topLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.3)
                bottomLeftView.anchor(top: topLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop:40, paddingBottom: 0, paddingLeft: 20, paddingRight: 20, width:  (view.frame.width-60)/2, height: view.frame.height*0.3)
                bottomRightView.anchor(top: topRightView.bottomAnchor, bottom: nil, leading: bottomLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.3)
                removeView.anchor(top: bottomLeftView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.026, paddingBottom: -65, paddingLeft: view.frame.width*0.1, paddingRight: -view.frame.width*0.1, width: 0, height: 0)
                headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: view.frame.width*0.124, paddingRight: -view.frame.width*0.124, width: 0, height: view.frame.height*0.08)
            }else{
                topLeftView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: (view.frame.width-60)/2, height: view.frame.height*0.25)
                topRightView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: topLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.25)
                bottomLeftView.anchor(top: topLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop:20, paddingBottom: 0, paddingLeft: 20, paddingRight: 20, width:  (view.frame.width-60)/2, height: view.frame.height*0.25)
                bottomRightView.anchor(top: topRightView.bottomAnchor, bottom: nil, leading: bottomLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.25)
                removeView.anchor(top: bottomLeftView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.026, paddingBottom: -65, paddingLeft: view.frame.width*0.1, paddingRight: -view.frame.width*0.1, width: 0, height: 0)
                headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: view.frame.width*0.124, paddingRight: -view.frame.width*0.124, width: 0, height: view.frame.height*0.08)
            }
            
        }
        
        
        
        topLeftImage.anchor(top: topLeftView.topAnchor, bottom: nil, leading: topLeftView.leadingAnchor, trailing: topLeftView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.1)
        topLeftLabel.anchor(top: topLeftImage.bottomAnchor, bottom: topLeftView.bottomAnchor, leading: topLeftView.leadingAnchor, trailing: topLeftView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: -view.frame.height*0.032, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        topRightImage.anchor(top: topRightView.topAnchor, bottom: nil, leading: topRightView.leadingAnchor, trailing: topRightView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.1)
        topRightLabel.anchor(top: topRightImage.bottomAnchor, bottom: topRightView.bottomAnchor, leading: topRightView.leadingAnchor, trailing: topRightView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: -view.frame.height*0.032, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        bottomRightImage.anchor(top: bottomRightView.topAnchor, bottom: nil, leading: bottomRightView.leadingAnchor, trailing: bottomRightView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.1)
        bottomRightLabel.anchor(top: bottomRightImage.bottomAnchor, bottom: bottomRightView.bottomAnchor, leading: bottomRightView.leadingAnchor, trailing: bottomRightView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: -view.frame.height*0.032, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        bottomLeftImage.anchor(top: bottomLeftView.topAnchor, bottom: nil, leading: bottomLeftView.leadingAnchor, trailing: bottomLeftView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.1)
        bottomLeftLABEL.anchor(top: bottomLeftImage.bottomAnchor, bottom: bottomLeftView.bottomAnchor, leading: bottomLeftView.leadingAnchor, trailing: bottomLeftView.trailingAnchor, paddingTop: view.frame.height*0.04, paddingBottom: -view.frame.height*0.032, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        
        topLeftView.layer.cornerRadius = 20
        topRightView.layer.cornerRadius = 20
        bottomLeftView.layer.cornerRadius = 20
        bottomRightView.layer.cornerRadius = 20
        
        layerSet(view: topLeftView)
        layerSet(view: topRightView)
        layerSet(view: bottomLeftView)
        layerSet(view: bottomRightView)
        
        
    }
    
    
    
    
    @objc func topLeftTapped (){
        topLeftView.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func topRightTapped (){
        topRightView.zoomIn()
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.isFirst = true
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func bottomLeftTapped (){
        bottomLeftView.zoomIn()
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracriceViewController") as! PracriceViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func bottomRightTapped (){
        bottomRightView.zoomIn()
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    @objc func removeTapped (){
        removeView.zoomIn()
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.removeAds.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
        
    }
    func layerSet(view:UIView){
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        view.layer.shadowOffset = CGSize(width: -3, height: 4)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = false
    }
    func homeAnimation () {
        animationView.animation = Animation.named("detail4")
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.view.sendSubviewToBack(animationView)
        
        animationView.center = view.center
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
    
    
}
extension HomeViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products.first)
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
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                Utils.saveLocal(array: "premium", key: "purchase")
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
extension HomeViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
