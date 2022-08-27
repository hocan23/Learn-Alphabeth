//
//  PracriceViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit
import StoreKit
import GoogleMobileAds
class PracriceViewController: UIViewController {
    var isAd = false
    var isinAd = false
    var tappedCounter = 0
    @IBOutlet weak var homeView: UIImageView!
    @IBOutlet weak var labelSwitch: UILabel!
    @IBOutlet weak var switchLetter: UISwitch!
    @IBOutlet weak var removeView: UIImageView!
    @IBOutlet weak var collectionLetter: UICollectionView!
    var selectedItemNumber = 0
    var isSmall : Bool = false
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
    let spacing = CGSize(width: 7, height: 10)
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.SIX11.elifba.remove"
    }
    var padLine = [6,5,4,3,2,1,12,11,10,9,8,7,18,17,16,15,14,13,24,23,22,21,20,19,28,27,26,25]
    var phoneLine = [4,3,2,1,8,7,6,5,12,11,10,9,16,15,14,13,20,19,18,17,24,23,22,21,28,27,26,25]
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionLetter.showsVerticalScrollIndicator = false

        collectionLetter.delegate = self
        collectionLetter.dataSource = self
        setupConstraints()
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        removeView.isUserInteractionEnabled = true
        removeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTapped)))
        
       
        // Do any additional setup after loading the view.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewWillAppear(_ animated: Bool) {
        Utils.isPremium = Utils.readLocal(key: "purchase")

        if isAd == true {
            self.dismiss(animated: true)
            
        }
        if isinAd == true{
            isinAd = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
            vc.isSmall = isSmall
            vc.selectedItemNumber = selectedItemNumber
            vc.providesPresentationContextTransitionStyle = true;
            
            vc.definesPresentationContext = true;
            
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
            self.present(vc, animated: false, completion: nil)
        }
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
    
    func setupConstraints (){
        if UIDevice.current.userInterfaceIdiom == .pad  {
            collectionLetter.anchor(top: removeView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:  view.frame.height*0.02, paddingBottom: -65, paddingLeft: 40, paddingRight: -40, width: 0, height: 0)
        }else{
            collectionLetter.anchor(top: removeView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:  view.frame.height*0.02, paddingBottom: -65, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
        }

        
        
        removeView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: 0, paddingRight: -view.frame.height*0.04, width: view.frame.width*0.11, height: view.frame.height*0.05)
        
        homeView.anchor(top:view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: view.frame.height*0.04, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
//        if Utils.isPremium == "premium"{
//            switchLetter.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: 0, paddingRight: -view.frame.height*0.04-(view.frame.width)*0.02, width: 0, height: 0)
//            labelSwitch.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: switchLetter.leadingAnchor, paddingTop: view.frame.height*0.07-5, paddingBottom: 0, paddingLeft: 0, paddingRight: -13, width:180, height: 40)
//
//
//        }else{
//            print(view.frame.width)
//            switchLetter.anchor(top: removeView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: 0, paddingRight: -view.frame.height*0.04-(view.frame.width)*0.02, width: 0, height: 0)
//            labelSwitch.anchor(top: removeView.bottomAnchor, bottom: nil, leading: nil, trailing: switchLetter.leadingAnchor, paddingTop: view.frame.height*0.023, paddingBottom: 0, paddingLeft: 0, paddingRight: -13, width:180, height: 40)
//    }

    
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
    @objc func exitTapped (){
        homeView.zoomIn()
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAd = true
        } else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)
        }
        
    }
    @IBAction func switchPositionChanged(_ sender: UISwitch) {
        if sender.isOn {
            isSmall = true
        }else{
            isSmall = false
        }
        collectionLetter.reloadData()
        
    }
    
}



extension PracriceViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCell", for: indexPath) as! PracticeCollectionViewCell
        print("\(indexPath.row+1)")
        if UIDevice.current.userInterfaceIdiom == .pad  {
            cell.practiceImage.image = UIImage(named: "\(padLine[indexPath.row])")

        }else{
            cell.practiceImage.image = UIImage(named: "\(phoneLine[indexPath.row])")
        }

       
//        if UIDevice.current.userInterfaceIdiom == .pad  {
//            cell.letterLabel.font = cell.letterLabel.font.withSize(60)
//        }
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        cell.layer.shadowOffset = CGSize(width: -3, height: 4)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 1
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = false
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        Utils.practiceAdCounter+=1
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        vc.isSmall = isSmall
        if UIDevice.current.userInterfaceIdiom == .pad  {
            selectedItemNumber =  padLine[indexPath.row]
        }else{
            selectedItemNumber =  phoneLine[indexPath.row]

        }
        vc.interstitial = interstitial
        if Utils.practiceAdCounter >= 5{
            vc.isShowAd = true
            
        }
        
        vc.selectedItemNumber = selectedItemNumber
        vc.providesPresentationContextTransitionStyle = true;
        
        vc.definesPresentationContext = true;
        
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        self.present(vc, animated: false, completion: nil)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing.width
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            
            let numberOfVisibleCellHorizontal: CGFloat = 4
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            print(width)
            print(collectionView.bounds.width )
            return CGSize(width: width, height: width)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            
            let numberOfVisibleCellHorizontal: CGFloat = 6
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            
            return CGSize(width: width, height: width)
            
        }
        
        let numberOfVisibleCellHorizontal: CGFloat = 2
        let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
        let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
        
        return CGSize(width: width, height: width)
        
    }
    
    
    
}

extension PracriceViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
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
extension PracriceViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
