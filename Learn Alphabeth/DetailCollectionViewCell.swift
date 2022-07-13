//
//  DetailCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalLabel: UILabel!
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var animalImg: UIImageView!
    @IBOutlet weak var inimalLatter: UIImageView!
    
    var contentWight = UIScreen.main.bounds.size.width
    var contentHeight = UIScreen.main.bounds.size.height*0.55

   
    override func awakeFromNib() {
        super.awakeFromNib()
        print(UIScreen.main.bounds.size.height)
        print(contentView.frame.height)
        inimalLatter.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 30, paddingRight: 0, width: contentHeight*0.3-30, height: contentHeight*0.17)
        print(contentWight)
        print(contentHeight)
        animalImg.anchor(top: inimalLatter.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: contentHeight*0.4)
        animalLabel.anchor(top: animalImg.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop:30, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: contentHeight*0.06)
        line.anchor(top: animalLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: 2)
        

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
