//
//  DetailCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
 
    
   
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var animalImg: UIImageView!
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var contentWight = UIScreen.main.bounds.size.width
    var contentHeight = UIScreen.main.bounds.size.height*0.6

   
    override func awakeFromNib() {
        super.awakeFromNib()

        print(UIScreen.main.bounds.size.height)
        print(contentView.frame.height)
//        switchLabel.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        `switch`.anchor(top: cardView.topAnchor, bottom: nil, leading: nil, trailing: cardView.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 0, paddingRight: -30, width: 40, height: 40)
        switchLabel.anchor(top: cardView.topAnchor, bottom: nil, leading: nil, trailing: `switch`.leadingAnchor, paddingTop: 17, paddingBottom: 0, paddingLeft: 0, paddingRight: -13, width: 100, height: 40)
        print(contentWight)
        print(contentHeight)
        animalImg.anchor(top: cardView.topAnchor, bottom: cardView.bottomAnchor, leading: nil, trailing: nil, paddingTop: 80, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: 0)
       
       
        print(cardView.frame.height)
        
        animalImg.bounce()
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        cardView.layer.shadowOffset = CGSize(width: -3, height: 4)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 1
        cardView.backgroundColor = UIColor.white
        cardView.layer.masksToBounds = false
        
       
        
//        cell.layer.cornerRadius = 20
//          cell.contentView.layer.cornerRadius = 20
//
//          cell.layer.masksToBounds = false
//          cell.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
//          cell.layer.shadowOffset = CGSize(width: -3, height: 4)
//          cell.layer.shadowRadius = 10
//          cell.layer.shadowOpacity = 1
    }
   
    
    }
    
       
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(inimalLatter)
//        contentView.addSubview(animalImg)
//        contentView.addSubview(animalName)
//        contentView.addSubview(line)
//        contentView.clipsToBounds = true
//    }
    
   


