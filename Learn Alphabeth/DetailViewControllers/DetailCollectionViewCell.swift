//
//  DetailCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var animalImg: UIImageView!
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var inimalLatter: UILabel!
    var contentWight = UIScreen.main.bounds.size.width
    var contentHeight = UIScreen.main.bounds.size.height*0.6

   
    override func awakeFromNib() {
        super.awakeFromNib()
        print(UIScreen.main.bounds.size.height)
        print(contentView.frame.height)
        inimalLatter.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 0, height: contentHeight*0.17)
        print(contentWight)
        print(contentHeight)
        animalImg.anchor(top: inimalLatter.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: contentHeight*0.35)
        animalLabel.anchor(top: animalImg.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop:20, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: contentHeight*0.06)
        line.anchor(top: animalLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: 2)
        print(cardView.frame.height)
        
        
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        cardView.layer.shadowOffset = CGSize(width: -3, height: 4)
        cardView.layer.shadowRadius = 10
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
   
        
       
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(inimalLatter)
//        contentView.addSubview(animalImg)
//        contentView.addSubview(animalName)
//        contentView.addSubview(line)
//        contentView.clipsToBounds = true
//    }
    
   

}
