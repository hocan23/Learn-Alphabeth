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
    
    Alphabeth(letterImage: "A", animalImage: "AA", letterSound: "A", animalName: "ALIGATOR" ),
    Alphabeth(letterImage: "B", animalImage: "BB", letterSound: "B", animalName: "BUTTERFLY" ),
    Alphabeth(letterImage: "C", animalImage: "CC", letterSound: "C", animalName: "COW" ),
    Alphabeth(letterImage: "D", animalImage: "DD", letterSound: "D", animalName: "DOG" ),
    Alphabeth(letterImage: "E", animalImage: "EE", letterSound: "E", animalName: "ELEPHANT" ),
    Alphabeth(letterImage: "F", animalImage: "FF", letterSound: "F", animalName: "FROG" ),
    Alphabeth(letterImage: "G", animalImage: "GG", letterSound: "G", animalName: "GOAT" ),
    Alphabeth(letterImage: "H", animalImage: "HH", letterSound: "H", animalName: "HIPPO" ),
    Alphabeth(letterImage: "I", animalImage: "II", letterSound: "I", animalName: "IGUANA" ),
    Alphabeth(letterImage: "J", animalImage: "JJ", letterSound: "J", animalName: "JELLYFISH" ),
    Alphabeth(letterImage: "K", animalImage: "KK", letterSound: "K", animalName: "KANGAROO" ),
    Alphabeth(letterImage: "L", animalImage: "LL", letterSound: "L", animalName: "LION" ),
    Alphabeth(letterImage: "M", animalImage: "MM", letterSound: "M", animalName: "MONKEY" ),
    Alphabeth(letterImage: "N", animalImage: "NN", letterSound: "N", animalName: "NARWHAL" ),
    Alphabeth(letterImage: "O", animalImage: "OO", letterSound: "O", animalName: "OCTOPUS" ),
    Alphabeth(letterImage: "P", animalImage: "PP", letterSound: "P", animalName: "PANDA" ),
    Alphabeth(letterImage: "Q", animalImage: "QQ", letterSound: "Q", animalName: "QUAKKA" ),
    Alphabeth(letterImage: "R", animalImage: "RR", letterSound: "R", animalName: "RABBIT" ),
    Alphabeth(letterImage: "S", animalImage: "SS", letterSound: "S", animalName: "SNAKE" ),
    Alphabeth(letterImage: "T", animalImage: "TT", letterSound: "T", animalName: "TURTLE" ),
    Alphabeth(letterImage: "U", animalImage: "UU", letterSound: "U", animalName: "UMBRELLABIRD" ),
    Alphabeth(letterImage: "V", animalImage: "VV", letterSound: "V", animalName: "VOLE" ),
    Alphabeth(letterImage: "W", animalImage: "WW", letterSound: "W", animalName: "WOLF" ),
    Alphabeth(letterImage: "X", animalImage: "XX", letterSound: "X", animalName: "X-RAY FISH" ),
    Alphabeth(letterImage: "Y", animalImage: "YY", letterSound: "Y", animalName: "YAK" ),
    Alphabeth(letterImage: "Z", animalImage: "ZZ", letterSound: "Z", animalName: "ZEBRA" ),
    
    
]

private let reuseIdentifier = "Cell"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  

    
    
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 50, right: 15)
    let spacing = CGSize(width: 5, height: 5)

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
        
        cell.cardBG.image = UIImage(named: "Cards")
        cell.animalImage.image = UIImage(named: cellIds[indexPath.item].animalImage)
        cell.letterImage.image = UIImage(named: cellIds[indexPath.item].letterImage)
    
        
        return cell

    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        
        destinationVC.delegate = self
        destinationVC.cellIds = cellIds
        destinationVC.selectedItem = cellIds[indexPath.row]
        destinationVC.selectedItemNumber = indexPath.row
        destinationVC.modalPresentationStyle = .fullScreen
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
