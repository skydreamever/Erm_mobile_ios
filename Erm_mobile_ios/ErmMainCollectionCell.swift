//
//  ErmMainCollectionCell.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/17/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

protocol CellMessage{
    func stopScrolling()
    func deleteCell(tag:Int)
    func addWobbleCell(cell:ErmMainCollectionCell)
}


class ErmMainCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate:CellMessage!
    var celltag:Int!
    
    
    
    func setupCotent(image:UIImage,str:String){
        
        self.image.image = image
        self.label.text = str
        
        self.deleteButton.addTarget(self, action: "itemDelete:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(longPress)
        
        
    }


    func longPress(gr:UIGestureRecognizer){
        NSLog("long press")
        
        self.deleteButton.hidden = false
        self.beginWobble()
    }
    
    func beginWobble(){
        self.delegate.stopScrolling()
        AnimationUtils.wobble(self)
            
        
        delegate.addWobbleCell(self)
        
    }
    
    func itemDelete(sender:UIButton){
        
        self.delegate.deleteCell(self.tag)
        
    }
    
}
