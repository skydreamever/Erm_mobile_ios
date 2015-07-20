//
//  ErmMainViewController.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/17/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit



class ErmMainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,CellMessage {
    
    @IBOutlet weak var ermCollectionView: UICollectionView!
    
    let  collectionCellID = "ermCollectionCell";
    var count = 9;
    var validTag = [Bool](count: 9, repeatedValue: true)
    var waddingCell = [ErmMainCollectionCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "home_touch")?.scaleImage(0.5)
        self.navigationController?.tabBarItem.image = UIImage(named: "home")?.scaleImage(0.5)
        
        self.navigationController?.tabBarController?.title = "我的报销"

        self.title = "我的报销"
    
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupCollectionView()
        let twoPress = UITapGestureRecognizer(target: self, action: "twoPress")
        twoPress.numberOfTapsRequired = 2
        twoPress.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(twoPress)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tabBarController?.tabBar.hidden = false

    }
    
    func setupCollectionView(){
        ermCollectionView.backgroundColor = UIColor.whiteColor()
        ermCollectionView.alwaysBounceVertical = true
        ermCollectionView.delegate = self
        ermCollectionView.dataSource = self
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! ErmMainCollectionCell


        cell.tag = indexPath.row
        cell.setupCotent(UIImage(named: "home_bx")!,str: "审批")
        cell.delegate = self
        
        
        return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)

        
        UIView.animateWithDuration(0.05, animations: { () -> Void in
            cell?.backgroundColor = UIColor.grayColor()
        }) { (finished) -> Void in
            cell?.backgroundColor = UIColor.whiteColor()

            
            
        }
        
        let tag = cell!.tag
        if validTag[tag] && tag == 0 {
            self.performSegueWithIdentifier("collectionCellSelected", sender: self)
        }
        
        
        
    }
    
    
    func stopScrolling(){
        ermCollectionView.alwaysBounceVertical = false

        
    }
    
    
    func twoPress(){
        
        for cell in waddingCell{
            cell.deleteButton.hidden = true
            cell.layer.removeAllAnimations()
            AnimationUtils.endWobble(cell)
            
        }
        
    }
    
    
    func deleteCell(tag: Int) {
        
        validTag[tag] = false
        count--
        var num = 0
        for i in 0...tag {
            
            if validTag[i] {
                num++
            }
            
        }
        
        let indexPath = NSIndexPath(forRow: num, inSection: 0)
        let items = [indexPath]
        ermCollectionView.deleteItemsAtIndexPaths(items)

    }
    
    func addWobbleCell(cell:ErmMainCollectionCell){
        waddingCell.append(cell)
    }
    

}
