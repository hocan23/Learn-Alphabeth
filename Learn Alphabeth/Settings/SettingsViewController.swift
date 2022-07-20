//
//  SettingsViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController{
    @IBOutlet weak var homeView: UIImageView!
    var headers = ["Share App","Other Apps",  "Rate App",  "Remove Ads - $3.99",  "Restore Purchase"]
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.temporary.id"
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUi()
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
    }
    
    func setupUi(){
        homeView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        tableView.anchor(top: homeView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: 0, height: 250)
        tableView.layer.cornerRadius = 20
    }
    @objc func exitTapped (){
        homeView.zoomIn()
        self.dismiss(animated: true)
        
        //        if interstitial != nil {
        //            interstitial?.present(fromRootViewController: self)
        //            isAd = true
        //        } else {
        //            print("Ad wasn't ready")
        //            self.dismiss(animated: true)
        //        }
        //
    }
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.tableLabel.text = headers[indexPath.row]
        cell.tableLabel.textColor = UIColor(red: 38/255, green: 51/255, blue: 117/255, alpha: 1)

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 :
            if let name = URL(string: "https://apps.apple.com/us/app/islamic-wallpaper-hd-pro/id1632238123"), !name.absoluteString.isEmpty {
                let objectsToShare = [name]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            } else {
                // show alert for not available
            }
        case 1:
            if let url = URL(string: "https://apps.apple.com/tr/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
                UIApplication.shared.open(url)
            }
        case 2:
            if let url = URL(string: "https://apps.apple.com/tr/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
                UIApplication.shared.open(url)
            }
        case 3:
            if SKPaymentQueue.canMakePayments(){
                let set :  Set<String> = [Products.removeAds.rawValue]
                let productRequest = SKProductsRequest(productIdentifiers: set)
                productRequest.delegate = self
                productRequest.start()
            }
        default: break
        }
        
    }
    
    
}
extension SettingsViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
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
