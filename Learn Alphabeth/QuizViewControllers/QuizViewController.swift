//
//  QuizViewController.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 14.07.2022.
//

import UIKit

class QuizViewController: UIViewController {
 
    @IBOutlet weak var midButton: UIButton!
    @IBOutlet weak var playView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var bottom1View: UIView!
    @IBOutlet weak var top1View: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var isSmall : Bool = false
    @IBOutlet weak var switchSmall: UISwitch!
    @IBOutlet weak var collectionAnimal1: UICollectionView!
    @IBOutlet weak var removeBtn: UIButton!
    var cellIds : [Alphabeth] = Utils.cellIds
    var selectedItemNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        cellIds.shuffle()
        print(cellIds[0].animalName)
        collectionAnimal1.delegate = self
        collectionAnimal1.dataSource = self
        SetupConstraints()
    }
    func SetupConstraints (){
        collectionAnimal1.contentInset = UIEdgeInsets(top: 0, left: view.frame.width*0.05, bottom: 0, right: view.frame.width*0.05)
        
        top1View.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.15)
        collectionAnimal1.anchor(top: top1View.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.6)
        print(view.bounds.height)
        print(view.frame.height*0.3)
        bottom1View.anchor(top: collectionAnimal1.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -65, paddingLeft: 0, paddingRight: 0, width: 0, height:  view.frame.height*0.25)

        homeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: top1View.leadingAnchor, trailing: nil, paddingTop: view.frame.height*0.045, paddingBottom: -view.frame.height*0.045, paddingLeft: 20, paddingRight: 0, width: view.frame.height*0.05, height: view.frame.height*0.05)
        removeBtn.anchor(top: top1View.topAnchor, bottom: top1View.bottomAnchor, leading: nil, trailing: top1View.trailingAnchor, paddingTop: view.frame.height*0.050, paddingBottom: -view.frame.height*0.050, paddingLeft: 0, paddingRight: -10, width: view.frame.width*0.35, height: view.frame.height*0.05)
        leftButton.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.1, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
        midButton.anchor(top: nil, bottom: nil, leading: leftButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
        rightButton.anchor(top: nil, bottom: nil, leading: midButton.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft:  view.frame.width*0.05, paddingRight: 0, width: view.frame.width*0.237, height: view.frame.height*0.11)
       
        leftButton.layer.cornerRadius = 20
        midButton.layer.cornerRadius = 20
        rightButton.layer.cornerRadius = 20

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func rightButtonTapped(_ sender: Any) {
        print(cellIds[selectedItemNumber].letterImage)
        if cellIds[selectedItemNumber].letterImage.contains((rightButton.titleLabel?.text)!) {
            print("exists")
            rightButton.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.rightButton.backgroundColor = .clear
                self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                self.collectionAnimal1.reloadData()

            }
        }else{
            rightButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.rightButton.backgroundColor = .clear

            }
        }

//        if ((cellIds[selectedItemNumber].letterImage).contains(where: rightButton.titleLabel?.text?)) {
//
//        }
    }
    @IBAction func midButtonTapped(_ sender: Any) {
        if cellIds[selectedItemNumber].letterImage.contains((midButton.titleLabel?.text)!) {
            print("exists")
            midButton.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.midButton.backgroundColor = .clear
                self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                self.collectionAnimal1.reloadData()

            }
        }else{
            midButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.midButton.backgroundColor = .clear

            }

        }
    }
    @IBAction func leftButtonTapped(_ sender: Any) {
        if cellIds[selectedItemNumber].letterImage.contains((leftButton.titleLabel?.text)!) {
            print("exists")
            leftButton.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.leftButton.backgroundColor = .clear
                self.collectionAnimal1.scrollToItem(at:IndexPath(item: self.selectedItemNumber+1, section: 0), at: .right, animated: false)
                self.collectionAnimal1.reloadData()

            }
        }else{
            leftButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.leftButton.backgroundColor = .clear

            }
    }
    }
    @IBAction func playTapped(_ sender: UIButton) {
    }
    @IBAction func switchPositionChanged(_ sender: UISwitch) {
        if sender.isOn {
                isSmall = true
            }else{
               isSmall = false
            }
            collectionAnimal1.reloadData()
            
        }
}

    

extension QuizViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIds.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var visibleRect = CGRect()
        visibleRect.origin = collectionAnimal1.contentOffset
        visibleRect.size = collectionAnimal1.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = collectionAnimal1.indexPathForItem(at: visiblePoint)
        if let number = visibleIndexPath{
            selectedItemNumber = (visibleIndexPath?.row)!

        }

//
//        if let visibleIndexPath = visibleIndexPath {
//            var buttonOptions = [(cellIds[visibleIndexPath.row].letterImage),cellIds[Int.random(in: 0..<26)].letterImage,cellIds[Int.random(in: 0..<26)].letterImage]
//            buttonOptions.shuffle()
//            if isSmall == false{
//                leftButton.setTitle(String(buttonOptions[0].prefix(1)), for: .normal)
//                midButton.setTitle(String(buttonOptions[1].prefix(1)), for: .normal)
//                rightButton.setTitle(String(buttonOptions[2].prefix(1)), for: .normal)
//
//            }else{
//            leftButton.setTitle(buttonOptions[0], for: .normal)
//            midButton.setTitle(buttonOptions[1], for: .normal)
//            rightButton.setTitle(buttonOptions[2], for: .normal)
//            }
//        }
//        leftButton.setTitle(cellIds[visibleIndexPath!.row].letterImage, for: .normal)
//        if isFirstOpen != true{
//        selectedItemNumber = visibleIndexPath?.row
//        }else{
//            isFirstOpen = false
//        }
//        print(selectedItemNumber)
//        player?.stop()
//        if let number = selectedItemNumber  {
//            if isautoPlay == true || isAuto == true{
//                playMusic(name: cellIds[number].letterSound, type: "mp3")
//
//            }
//        }
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
    }
    
   


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionAnimal1.dequeueReusableCell(withReuseIdentifier: "quizcell", for: indexPath) as! QuizCollectionViewCell
        cell.animalImg.image = UIImage(named:  cellIds[indexPath.row].animalImage)
        cell.progressLabel.text = "\(selectedItemNumber)/26"
        cell.progressBar.setProgress(Float(selectedItemNumber)/26, animated: true)
        print(cellIds[indexPath.row].letterImage)
//        cell.animalLabel.text = cellIds[indexPath.row].animalName
//        cell.switch.setOn(isautoPlay, animated: true)
//        cell.inimalLatter.text = cellIds[indexPath.row].letterImage

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width*0.9, height: view.frame.size.height*0.6-40)
    }
//
//    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        print(selectedItemNumber)
        let indexToScrollTo = IndexPath(item: selectedItemNumber, section: 0)
            collectionAnimal1.scrollToItem(at: indexToScrollTo, at: .right, animated: false)

        
        let visibleIndexPath = selectedItemNumber
            var buttonOptions = [(cellIds[visibleIndexPath].letterImage),cellIds[Int.random(in: 0..<26)].letterImage,cellIds[Int.random(in: 0..<26)].letterImage]
            buttonOptions.shuffle()
            if isSmall == false{
                leftButton.setTitle(String(buttonOptions[0].prefix(1)), for: .normal)
                midButton.setTitle(String(buttonOptions[1].prefix(1)), for: .normal)
                rightButton.setTitle(String(buttonOptions[2].prefix(1)), for: .normal)

            }else{
                leftButton.setTitle(String(buttonOptions[0].suffix(1)), for: .normal)
            midButton.setTitle(String(buttonOptions[1].suffix(1)), for: .normal)
            rightButton.setTitle(String(buttonOptions[2].suffix(1)), for: .normal)
            }
      }
    
    
    
}
