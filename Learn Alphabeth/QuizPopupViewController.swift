//
//  QuizPopupViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 22.07.2022.
//

import UIKit

class QuizPopupViewController: UIViewController {
    @IBOutlet weak var dialogView: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var noView: UIImageView!
    @IBOutlet weak var yesView: UIImageView!
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
    @objc func exitTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
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
