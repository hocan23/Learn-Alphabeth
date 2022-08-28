//
//  ResultViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 17.07.2022.
//

import UIKit
import Lottie
import GoogleMobileAds
import StoreKit
class ResultViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var removeView: UIImageView!
    
    @IBOutlet weak var homeView: UIImageView!
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.SIX11.learnABC.removeAds"
    }
    var isFirst = false
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var wrongView: UIImageView!
    @IBOutlet weak var correctView: UIImageView!
    @IBOutlet weak var bottomHeader: UILabel!
    @IBOutlet weak var collectionBottom: UICollectionView!
    @IBOutlet weak var collectionTop: UICollectionView!
    var cellIds : [Alphabeth] = Utils.cellIds
    var correctAnswer : [Alphabeth] = []
    var wrongAnswer : [Alphabeth] = []
    let animationView = AnimationView()
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    var isAd = false
    var selectedItemNumber = 0
    var isSmall : Bool = false
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
    let spacing = CGSize(width: 5, height: 10)
    var isResult = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if Utils.isPremium == "premium"{
            removeView.isHidden = true
        }else{
        createAdd()
        }
        if let data = UserDefaults.standard.value(forKey:"correctAnswers") as? Data {
            correctAnswer = try! PropertyListDecoder().decode(Array<Alphabeth>.self, from: data)
        }
        if let data = UserDefaults.standard.value(forKey:"wrongAnswers") as? Data {
            wrongAnswer = try! PropertyListDecoder().decode(Array<Alphabeth>.self, from: data)
        }
     
        
        collectionTop.delegate = self
        collectionTop.dataSource = self
        collectionBottom.delegate = self
        collectionBottom.dataSource = self
        emptyLabel.isHidden = true
        setupConstraits()
        resultAnimation()
        if isFirst == true{
            isFirstStup()
            
        }
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        removeView.isUserInteractionEnabled = true
        removeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTapped)))
        
      
        // Do any additional setup after loading the view.
    }
   
    func isFirstStup(){
        if correctAnswer.count == 0 && wrongAnswer.count == 0 {
            collectionTop.isHidden = true
            collectionBottom.isHidden = true
            headerLabel.isHidden = true
            wrongView.isHidden = true
            correctView.isHidden = true
            collectionBottom.isHidden = true
            collectionBottom.isHidden = true
            emptyLabel.isHidden = false
            animationView.isHidden = true
            
        }
        headerLabel.text = "Last Solo \nTest Results"

//        animationView.isHidden=true
        doneButton.image = UIImage(named: "startt")
    }
    
    func setupConstraits(){
        headerLabel.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.21, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.12)
        correctView.anchor(top: headerLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.008, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.04)
        if correctAnswer.count<13{
            collectionTop.anchor(top: correctView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.008, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.12)
        }else{
            collectionTop.anchor(top: correctView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.008, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.23)
            
        }
        
        wrongView.anchor(top: collectionTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.02, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.04)
        if UIDevice.current.userInterfaceIdiom == .pad  {
            doneButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.025, paddingBottom: -100, paddingLeft: view.frame.width*0.2, paddingRight: -view.frame.width*0.2, width: 0, height: view.frame.height*0.08)
        }else{
            doneButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.025, paddingBottom: -50, paddingLeft: view.frame.width*0.2, paddingRight: -view.frame.width*0.2, width: 0, height: view.frame.height*0.08)
        }
       
        if wrongAnswer.count<13{
        collectionBottom.anchor(top: wrongView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.008, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.12)
        } else{
                collectionBottom.anchor(top: wrongView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.008, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.23)
            }
        removeView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: 0, paddingRight: -view.frame.height*0.04, width: view.frame.width*0.11, height: view.frame.height*0.05)
        
        homeView.anchor(top:view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.07, paddingBottom: 0, paddingLeft: view.frame.height*0.04, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        
        
        doneButton.isUserInteractionEnabled = true
        doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneTapped)))
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
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
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
            
        }
        
        
    }
    @objc func doneTapped(){
        
        if isFirst==false{
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                isAd = true
            } else {
                print("Ad wasn't ready")
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
                
            }
        }else{
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true{
            isAd=false
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
        if Utils.isPremium == "premium"{
            removeView.isHidden = true
        }else{
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
        if isResult==true{
            homeView.isHidden=true
            headerLabel.text = "Solo Test \nResults"

        }
    }
    func resultAnimation () {
        animationView.animation = Animation.named("result")
        animationView.frame = CGRect(x: view.frame.width*0.34, y: 20, width: view.bounds.height*0.22, height: view.bounds.height*0.22)
        
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
}
extension ResultViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionBottom {
            return wrongAnswer.count // Replace with count of your data for collectionViewA
        }
        
        return correctAnswer.count // Replace with count of your data for collectionViewB
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionTop {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCollectionViewCell
            if isSmall == false{
                cell.resultLabel.text = String(correctAnswer[indexPath.row].letterImage.prefix(1))
                
            }else{
                cell.resultLabel.text = String(correctAnswer[indexPath.row].letterImage.suffix(1))
                
            }
            cell.resultLabel.textColor = UIColor(red: 38/255, green: 51/255, blue: 117/255, alpha: 1)
            cell.layer.cornerRadius = 5
            // Set up cell
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultTwoCell", for: indexPath) as! ResultTwoCollectionViewCell
            if isSmall == false{
                cell.labelTwo.text = String(wrongAnswer[indexPath.row].letterImage.prefix(1))
                
            }else{
                cell.labelTwo.text = String(wrongAnswer[indexPath.row].letterImage.suffix(1))
                
            }
            cell.labelTwo.textColor = UIColor(red: 38/255, green: 51/255, blue: 117/255, alpha: 1)
            cell.layer.cornerRadius = 5
            return cell
        }
        
        
        
        
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
            
            
            let numberOfVisibleCellHorizontal: CGFloat = 7
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            print(width)
            print(collectionView.bounds.width )
            return CGSize(width: width, height: width)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            
            let numberOfVisibleCellHorizontal: CGFloat = 12
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            
            return CGSize(width: width, height: width)
            
        }
        
        let numberOfVisibleCellHorizontal: CGFloat = 2
        let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
        let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
        
        return CGSize(width: width, height: width)
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    
    
    
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.subtracting(otherSet))
    }
}
extension ResultViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
extension ResultViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
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
