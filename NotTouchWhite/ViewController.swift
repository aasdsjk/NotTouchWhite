//
//  ViewController.swift
//  NotTouchWhite
//
//  Created by ning on 16/12/7.
//  Copyright © 2016年 songjk. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width
let screenH = UIScreen.main.bounds.size.height
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collection : UICollectionView!
    var index : Int = -1
    var isRandom : Bool = false
    var random : Int = 0
    var timer : Timer!
    var blackArr = [Int]()
    var changeValue : CGFloat = 30.0
    
    var numbersCell : Int = 4
    
    var scoreLable : UILabel!
    
    var scoreNumber : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
    }
    fileprivate func addTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(collectionMove), userInfo: nil, repeats: true)
        }
    }
    
    func removeTimer()  {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    @objc func collectionMove()  {
        let y = self.collection.contentOffset.y
        self.collection.setContentOffset(CGPoint.init(x: 0, y: y+changeValue), animated: true)
    }
    
    fileprivate func createCollectionView(){
        let  layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: (screenW-1)/3, height: (screenH-1)/3)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.contentInset = UIEdgeInsetsMake(screenH/2, 0, 0, 0)
        collection.backgroundColor = UIColor.gray
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        self.view.addSubview(collection)
        
        let lable = UILabel.init(frame: CGRect.init(x: screenW-100, y: 30, width: 100, height: 30))
        lable.textColor = UIColor.red
        lable.font = UIFont.systemFont(ofSize: 14.0)
        scoreLable = lable
        self.view.addSubview(lable)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3*4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        if index != indexPath.row/3 {
            
            if !isRandom {
                random = Int(arc4random())%3+1+indexPath.row
                isRandom = true
            }
            print(random)
            if (indexPath.row+1) == random  {
                isRandom = false
                index = indexPath.row / 3
                cell.tag = indexPath.row
                blackArr.append(indexPath.row)
                self.changeCellWith(cell as! CustomCollectionViewCell)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collection.cellForItem(at: indexPath)
        if indexPath.row == blackArr.first {
            if indexPath.row <= 2 {
                addTimer()
            }
            scoreNumber += 1
            scoreLable.text = String.init(format: "分数:%ld", scoreNumber)
            changeValue += 4
            blackArr.remove(at: 0)
            cell?.backgroundColor = UIColor.gray
        }else{
            removeTimer()
            createAlertView("you have died")
        }
    }
    
    func createAlertView(_ msg : String)  {
        let alert = UIAlertController.init(title: "提示", message: msg, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "取消", style: .default, handler: {(al) in
            self.onceAgain()
        })
        let action2 = UIAlertAction.init(title: "再来一次", style: .default, handler: {(al) in
            self.onceAgain()
        })
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func onceAgain() {
        collection.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        collection.contentInset = UIEdgeInsetsMake(screenH/2, 0, 0, 0)
        collection.reloadData()
        blackArr.removeAll()
        scoreNumber = 0
        scoreLable.text = String.init(format: "分数:%ld", scoreNumber)
        changeValue = 40.0
        isRandom = false
    }
    
    fileprivate func changeCellWith(_ cell:CustomCollectionViewCell){
        cell.backgroundColor = UIColor.black
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

