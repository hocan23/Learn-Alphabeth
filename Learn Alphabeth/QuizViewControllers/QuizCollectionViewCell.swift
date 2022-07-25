//
//  QuizCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 14.07.2022.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    var timer = Timer()

    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var animalImg: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    var contentWight = UIScreen.main.bounds.size.width
    var contentHeight = UIScreen.main.bounds.size.height*0.6
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        print(UIScreen.main.bounds.size.height)
        print(contentView.frame.height)
        if UIDevice.current.userInterfaceIdiom == .pad  {
            animalImg.anchor(top: playImage.bottomAnchor, bottom: progressBar.topAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: -20, paddingLeft: 40, paddingRight: -40, width: contentWight*0.5, height: 0)
        }else{
            animalImg.anchor(top: playImage.bottomAnchor, bottom: progressBar.topAnchor, leading: nil, trailing: nil, paddingTop: 20, paddingBottom: -20, paddingLeft: 0, paddingRight: 0, width: contentWight*0.7, height: 0)
        }

       
      
           
        playButton.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 40, height: 40)
        playImage.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 30, height: 30)
       
        progressBar.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: progressLabel.leadingAnchor, paddingTop: 0, paddingBottom: -30, paddingLeft: 10, paddingRight: 0, width:contentWight*0.6, height: 15)
        progressLabel.anchor(top: nil, bottom: cardView.bottomAnchor, leading: progressBar.trailingAnchor, trailing: cardView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 0, paddingRight: -10, width:60, height: 15)
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        cardView.layer.shadowOffset = CGSize(width: -3, height: 4)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 1
        cardView.backgroundColor = UIColor.white
        cardView.layer.masksToBounds = false
        progressLabel.textColor = UIColor(red: 38/255, green: 51/255, blue: 117/255, alpha: 1)
//        switchLabel.font = switchLabel.font.withSize(UIScreen.main.bounds.size.height*0.24)
        progressBar.layer.cornerRadius = 7
        progressBar.clipsToBounds = true
     

        // Set the rounded edge for the inner bar
        progressBar.layer.sublayers![1].cornerRadius = 7
        progressBar.subviews[1].clipsToBounds = true
        timer.invalidate()

        animalImg.bounce()
        
        
    }
   
}
