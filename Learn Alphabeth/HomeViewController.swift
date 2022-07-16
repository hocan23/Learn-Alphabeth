//
//  HomeViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupConstraits()
        topLeftView.isUserInteractionEnabled = true
        topLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topLeftTapped)))
        topRightView.isUserInteractionEnabled = true
        topRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightTapped)))
        bottomLeftView.isUserInteractionEnabled = true
        bottomLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomLeftTapped)))
        bottomRightView.isUserInteractionEnabled = true
        bottomRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomRightTapped)))
    }
    
    func setupConstraits (){
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: view.frame.width*0.124, paddingRight: -view.frame.width*0.124, width: 0, height: view.frame.height*0.08)
        topLeftView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: (view.frame.width-60)/2, height: view.frame.height*0.29)
        topRightView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: topLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.29)
        bottomLeftView.anchor(top: topLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop:20, paddingBottom: 0, paddingLeft: 20, paddingRight: 20, width:  (view.frame.width-60)/2, height: view.frame.height*0.29)
        bottomRightView.anchor(top: topRightView.bottomAnchor, bottom: nil, leading: bottomLeftView.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: (view.frame.width-60)/2, height: view.frame.height*0.29)
        topLeftImage.anchor(top: topLeftView.topAnchor, bottom: nil, leading: topLeftView.leadingAnchor, trailing: topLeftView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.12)
        topLeftLabel.anchor(top: topLeftImage.bottomAnchor, bottom: topLeftView.bottomAnchor, leading: topLeftView.leadingAnchor, trailing: topLeftView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: -view.frame.height*0.04, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        topRightImage.anchor(top: topRightView.topAnchor, bottom: nil, leading: topRightView.leadingAnchor, trailing: topRightView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.12)
        topRightLabel.anchor(top: topRightImage.bottomAnchor, bottom: topRightView.bottomAnchor, leading: topRightView.leadingAnchor, trailing: topRightView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: -view.frame.height*0.04, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        bottomRightImage.anchor(top: bottomRightView.topAnchor, bottom: nil, leading: bottomRightView.leadingAnchor, trailing: bottomRightView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.12)
        bottomRightLabel.anchor(top: bottomRightImage.bottomAnchor, bottom: bottomRightView.bottomAnchor, leading: bottomRightView.leadingAnchor, trailing: bottomRightView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: -view.frame.height*0.04, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        bottomLeftImage.anchor(top: bottomLeftView.topAnchor, bottom: nil, leading: bottomLeftView.leadingAnchor, trailing: bottomLeftView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: 0, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: view.frame.height*0.12)
        bottomLeftLABEL.anchor(top: bottomLeftImage.bottomAnchor, bottom: bottomLeftView.bottomAnchor, leading: bottomLeftView.leadingAnchor, trailing: bottomLeftView.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: -view.frame.height*0.04, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        removeView.anchor(top: bottomLeftView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.026, paddingBottom: -view.frame.height*0.04, paddingLeft: view.frame.height*0.02, paddingRight: -view.frame.height*0.02, width: 0, height: 0)
        topLeftView.layer.cornerRadius = 20
        topRightView.layer.cornerRadius = 20
        bottomLeftView.layer.cornerRadius = 20
        bottomRightView.layer.cornerRadius = 20

        
        
    }
    @objc func topLeftTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func topRightTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func bottomLeftTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PracriceViewController") as! PracriceViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    @objc func bottomRightTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }

    

}
