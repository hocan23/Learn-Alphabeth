//
//  Extensions.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 5.07.2022.
//

import Foundation
import UIKit
extension UIView{
    
    func zoomIn(duration: TimeInterval = 0.4) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }
func anchor(top : NSLayoutYAxisAnchor?,
            bottom : NSLayoutYAxisAnchor?,
            leading : NSLayoutXAxisAnchor?,
            trailing : NSLayoutXAxisAnchor?,
            paddingTop : CGFloat,
            paddingBottom : CGFloat,
            paddingLeft : CGFloat,
            paddingRight : CGFloat,
            width : CGFloat,
            height : CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
        self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    if let bottom = bottom {
        self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
    }
    if let leading = leading {
        self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
    }
    if let trailing = trailing {
        self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
    }
    
    if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}

}

class Utils{
    static let cellIds: [Alphabeth] = [
        
        Alphabeth(letterImage: "Aa", animalImage: "AA", letterSound: "A", animalName: "ALIGATOR" ),
        Alphabeth(letterImage: "Bb", animalImage: "BB", letterSound: "B", animalName: "BUTTERFLY" ),
        Alphabeth(letterImage: "Cc", animalImage: "CC", letterSound: "C", animalName: "COW" ),
        Alphabeth(letterImage: "Dd", animalImage: "DD", letterSound: "D", animalName: "DOG" ),
        Alphabeth(letterImage: "Ee", animalImage: "EE", letterSound: "E", animalName: "ELEPHANT" ),
        Alphabeth(letterImage: "Ff", animalImage: "FF", letterSound: "F", animalName: "FROG" ),
        Alphabeth(letterImage: "Gg", animalImage: "GG", letterSound: "G", animalName: "GOAT" ),
        Alphabeth(letterImage: "Hh", animalImage: "HH", letterSound: "H", animalName: "HIPPO" ),
        Alphabeth(letterImage: "Ii", animalImage: "II", letterSound: "I", animalName: "IGUANA" ),
        Alphabeth(letterImage: "Jj", animalImage: "JJ", letterSound: "J", animalName: "JELLYFISH" ),
        Alphabeth(letterImage: "Kk", animalImage: "KK", letterSound: "K", animalName: "KANGAROO" ),
        Alphabeth(letterImage: "Ll", animalImage: "LL", letterSound: "L", animalName: "LION" ),
        Alphabeth(letterImage: "Mm", animalImage: "MM", letterSound: "M", animalName: "MONKEY" ),
        Alphabeth(letterImage: "Nn", animalImage: "NN", letterSound: "N", animalName: "NARWHAL" ),
        Alphabeth(letterImage: "Oo", animalImage: "OO", letterSound: "O", animalName: "OCTOPUS" ),
        Alphabeth(letterImage: "Pp", animalImage: "PP", letterSound: "P", animalName: "PANDA" ),
        Alphabeth(letterImage: "Qq", animalImage: "QQ", letterSound: "Q", animalName: "QUAKKA" ),
        Alphabeth(letterImage: "Rr", animalImage: "RR", letterSound: "R", animalName: "RABBIT" ),
        Alphabeth(letterImage: "Ss", animalImage: "SS", letterSound: "S", animalName: "SNAKE" ),
        Alphabeth(letterImage: "Tt", animalImage: "TT", letterSound: "T", animalName: "TURTLE" ),
        Alphabeth(letterImage: "Uu", animalImage: "UU", letterSound: "U", animalName: "UMBRELLABIRD" ),
        Alphabeth(letterImage: "Vv", animalImage: "VV", letterSound: "V", animalName: "VOLE" ),
        Alphabeth(letterImage: "Ww", animalImage: "WW", letterSound: "W", animalName: "WOLF" ),
        Alphabeth(letterImage: "Xx", animalImage: "XX", letterSound: "X", animalName: "X-RAY FISH" ),
        Alphabeth(letterImage: "Yy", animalImage: "YY", letterSound: "Y", animalName: "YAK" ),
        Alphabeth(letterImage: "Zz", animalImage: "ZZ", letterSound: "Z", animalName: "ZEBRA" ),
        
        
    ]
    
    

}




