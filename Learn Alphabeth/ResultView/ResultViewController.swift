//
//  ResultViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 17.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var wrongView: UIImageView!
    @IBOutlet weak var correctView: UIImageView!
    @IBOutlet weak var bottomHeader: UILabel!
    @IBOutlet weak var collectionBottom: UICollectionView!
    @IBOutlet weak var collectionTop: UICollectionView!
    var cellIds : [Alphabeth] = Utils.cellIds
    var correctAnswer : [Alphabeth] = []
    var wrongAnswer : [Alphabeth] = []

    var selectedItemNumber = 0
    var isSmall : Bool = false
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
    let spacing = CGSize(width: 5, height: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTop.delegate = self
        collectionTop.dataSource = self
        collectionBottom.delegate = self
        collectionBottom.dataSource = self
        setupConstraits()
        // Do any additional setup after loading the view.
    }
    func setupConstraits(){
        headerLabel.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.22, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.12)
        correctView.anchor(top: headerLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.04)
       
        collectionTop.anchor(top: correctView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.15)
        wrongView.anchor(top: collectionTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.04)
        doneButton.anchor(top: collectionBottom.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.03, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: 0, height: view.frame.height*0.04)
        collectionBottom.anchor(top: wrongView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.01, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: view.frame.height*0.07)
        
        doneButton.isUserInteractionEnabled = true
        doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneTapped)))
    }
    @objc func doneTapped(){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
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
extension ResultViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionBottom {
            return wrongAnswer.count // Replace with count of your data for collectionViewA
           }

        return correctAnswer.count // Replace with count of your data for collectionViewB
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionTop {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCollectionViewCell
            if isSmall == false{
                cell.resultLabel.text = String(correctAnswer[indexPath.row].letterImage.prefix(1))
                
            }else{
                cell.resultLabel.text = String(correctAnswer[indexPath.row].letterImage.suffix(1))
                
            }

                // Set up cell
                return cell
            }

            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultTwoCell", for: indexPath) as! ResultTwoCollectionViewCell
                if isSmall == false{
                    cell.labelTwo.text = String(wrongAnswer[indexPath.row].letterImage.prefix(1))
                    
                }else{
                    cell.labelTwo.text = String(wrongAnswer[indexPath.row].letterImage.suffix(1))
                    
                }


                return cell
            }
     
       
        
        
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
            
            
            let numberOfVisibleCellHorizontal: CGFloat = 4
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            print(width)
            print(collectionView.bounds.width )
            return CGSize(width: 40, height: 40)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            
            let numberOfVisibleCellHorizontal: CGFloat = 4
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

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.subtracting(otherSet))
    }
}
