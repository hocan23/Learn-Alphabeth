//
//  PracriceViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit

class PracriceViewController: UIViewController {
    
    @IBOutlet weak var homeView: UIImageView!
    @IBOutlet weak var labelSwitch: UILabel!
    @IBOutlet weak var switchLetter: UISwitch!
    @IBOutlet weak var removeView: UIImageView!
    @IBOutlet weak var collectionLetter: UICollectionView!
    var cellIds : [Alphabeth] = Utils.cellIds
    var selectedItemNumber = 0
    var isSmall : Bool = false
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
    let spacing = CGSize(width: 5, height: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionLetter.delegate = self
        collectionLetter.dataSource = self
        setupConstraints()
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitTapped)))
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //        if isSmall == false{
        //            leftButton.setTitle(String(buttonOptions[0].prefix(1)), for: .normal)
        //            midButton.setTitle(String(buttonOptions[1].prefix(1)), for: .normal)
        //            rightButton.setTitle(String(buttonOptions[2].prefix(1)), for: .normal)
        //
        //        }else{
        //            leftButton.setTitle(String(buttonOptions[0].suffix(1)), for: .normal)
        //        midButton.setTitle(String(buttonOptions[1].suffix(1)), for: .normal)
        //        rightButton.setTitle(String(buttonOptions[2].suffix(1)), for: .normal)
        //        }
    }
    
    func setupConstraints (){
        removeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.05, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -15, width: view.frame.width*0.35, height: view.frame.height*0.05)
        switchLetter.anchor(top: removeView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: view.frame.height*0.043, paddingBottom: 0, paddingLeft: 0, paddingRight: -30, width: 40, height: 40)
        labelSwitch.anchor(top: nil, bottom: nil, leading: nil, trailing: switchLetter.leadingAnchor, paddingTop:0, paddingBottom: 0, paddingLeft: 0, paddingRight: -5, width:180, height: 40)
        collectionLetter.anchor(top: switchLetter.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:  view.frame.height*0.043, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        homeView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.045, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
       
        
    }
    @objc func exitTapped (){
        self.dismiss(animated: true)
    }
    @IBAction func switchPositionChanged(_ sender: UISwitch) {
        if sender.isOn {
            isSmall = true
        }else{
            isSmall = false
        }
        collectionLetter.reloadData()
        
    }
}



extension PracriceViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == collectionView) {
            
            return cellIds.count
            
        }
        
        return cellIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCell", for: indexPath) as! PracticeCollectionViewCell
        if isSmall == false{
            cell.letterLabel.text = String(cellIds[indexPath.row].letterImage.prefix(1))
            
        }else{
            cell.letterLabel.text = String(cellIds[indexPath.row].letterImage.suffix(1))
            
        }
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        cell.layer.shadowOffset = CGSize(width: -3, height: 4)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 1
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        
        //        vc.delegate = self
        vc.isSmall = isSmall
        vc.selectedItemNumber = indexPath.row
        vc.providesPresentationContextTransitionStyle = true;
        
        vc.definesPresentationContext = true;
        
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        self.present(vc, animated: false, completion: nil)
        
        
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
            return CGSize(width: width, height: width)
            
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

