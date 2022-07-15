//
//  ViewController.swift
//  Learn Alphabeth
//
//  Created by Rashit on 03/07/2022.
//

import UIKit

class Alphabeth {

    
    var letterImage: String
    var animalImage: String
    var letterSound: String
    var animalName: String
    
    init(letterImage: String, animalImage: String, letterSound: String, animalName: String) {
       
        self.letterImage = letterImage
        self.animalImage = animalImage
        self.letterSound = letterSound
        self.animalName = animalName
        
        
    }
}



let cellIds: [Alphabeth] = [
    
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

private let reuseIdentifier = "Cell"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  

    
    
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
       let spacing = CGSize(width: 5, height: 10)

    @IBOutlet weak var lettersCW: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if (collectionView == lettersCW) {
            
            return cellIds.count
            
        }
        
        return cellIds.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = lettersCW.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.animalImage.image = UIImage(named: cellIds[indexPath.item].animalImage)
        cell.letterImage.image = UIImage(named: String(cellIds[indexPath.item].letterImage.prefix(1)))
        cell.layer.masksToBounds = false
               cell.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
               cell.layer.shadowOffset = CGSize(width: -3, height: 4)
               cell.layer.shadowRadius = 10
               cell.layer.shadowOpacity = 1
        
        return cell

    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        
        destinationVC.delegate = self
        destinationVC.cellIds = cellIds
        destinationVC.selectedItem = cellIds[indexPath.row]
        print(indexPath.row)
        destinationVC.selectedItemNumber = indexPath.row
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.firstScrollİndex = indexPath.row
        self.present(destinationVC, animated: true, completion: nil)
        
        
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
            
            
            let numberOfVisibleCellHorizontal: CGFloat = 2
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            
            return CGSize(width: width, height: width)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            
            let numberOfVisibleCellHorizontal: CGFloat = 3
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

extension ViewController: DetailViewControllerDelegate{
    func diddismis() {
        
    }
    
    
    
    
}
