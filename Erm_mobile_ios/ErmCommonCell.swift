//
//  ErmCommonCell.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/18/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

class ErmCommonCell: UITableViewCell {
    var numberOfSections:NSInteger!
    let bgView = UIImageView()
    let selectedBgView = UIImageView()
    var subcells:[ErmCommonCell]?
    var subcellShow:Bool?
    var tableView:UITableView!
    
    
    
    var rightSwitch:UISwitch!{
        get{
            return UISwitch()
        }
    }
    
    
    var indexPath:NSIndexPath!{
        didSet{
            
            
            if numberOfSections == 1 {
                bgView.image = UIImage.resizeImage("common_card_background")
                selectedBgView.image = UIImage.resizeImage("common_card_background_highlighted")
            }else if indexPath.row == 0 {
                bgView.image = UIImage.resizeImage("common_card_top_background")
                selectedBgView.image = UIImage.resizeImage("common_card_top_background_highlighted")
            }else if indexPath.row == numberOfSections - 1 {
                bgView.image = UIImage.resizeImage("common_card_bottom_background")
                selectedBgView.image = UIImage.resizeImage("common_card_bottom_background_highlighted")
            }else{
                bgView.image = UIImage.resizeImage("common_card_middle_background")
                selectedBgView.image = UIImage.resizeImage("common_card_middle_background_highlighted")
                
            }
            
            
            
            self.backgroundView = bgView
            self.selectedBackgroundView = selectedBgView
        }
    }
    
    
    var item:ErmCommonItem!{
        didSet{
            if item.icon != nil {
                self.imageView?.image = UIImage(named: item.icon!)
            }
            self.textLabel?.text = item.title
            self.detailTextLabel?.text = item.subtitle
            
            if item.badgeValue != nil {
                let badgeView =  ErmBadgeView()
                badgeView.badgeValue = item.badgeValue
                self.accessoryView = badgeView
            }else if item.isKindOfClass(ErmCommonArrowItem){
                
                let arrowItem = item as! ErmCommonArrowItem
                let arrowImageView = UIImageView(image: UIImage(named: "common_icon_arrow"))
                if arrowItem.arrowText == nil{
                self.accessoryView = arrowImageView

                }else{
                    
                    
                    let label = UILabel()
                    label.font = UIFont.systemFontOfSize(10)
                    label.textColor = UIColor.grayColor()
                    label.text = arrowItem.arrowText
                    var attr = [String:AnyObject]()
                    attr[NSFontAttributeName] = UIFont.systemFontOfSize(10)
                    label.size = (arrowItem.arrowText! as NSString).sizeWithAttributes(attr)
                    
                    arrowImageView.x = label.width + 10
                    
                    let view = UIView()
                    view.width = arrowImageView.width + label.width + 10
                    view.height = label.height > arrowImageView.height ? label.height : arrowImageView.height
                    view.addSubview(label)
                    view.addSubview(arrowImageView)
                    self.accessoryView = view

                    
                }
                
                
            }else if item.isKindOfClass(ErmCommonSwitchItem){
                self.accessoryView = self.rightSwitch
            }else if item.isKindOfClass(ErmCommonLabelItem){
                
                let label = UILabel()
                label.font = UIFont.systemFontOfSize(10)
                let labelItem = item as! ErmCommonLabelItem
                label.text = labelItem.text
                var attr = [String:AnyObject]()
                attr[NSFontAttributeName] = UIFont.systemFontOfSize(10)
                label.size = (labelItem.text! as NSString).sizeWithAttributes(attr)

                self.accessoryView = label
                
            }else if item.isKindOfClass(ErmCommonSubItem){
                
                let arrowImageView = UIImageView(image: UIImage(named: "common_icon_arrow_left"))
                self.accessoryView = arrowImageView
                
                
                self.subcells = [ErmCommonCell]()
                let subItem = item as! ErmCommonSubItem
                for subitem in subItem.subItems {
                    
                    let cell = ErmCommonCell.cellWithTableView(tableView)
                    cell.autoresizingMask = UIViewAutoresizing.None
                    cell.width = 50
                    cell.item = subitem
                    cell.textLabel?.x = 50

                    self.subcells?.append(cell)
                    
                    
                    
                }
                
                
            }else{
                
                self.accessoryView = nil
            
            }
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = UIFont.boldSystemFontOfSize(15)
        self.detailTextLabel?.font = UIFont.systemFontOfSize(12)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func cellWithTableView(tableView:UITableView) -> ErmCommonCell{
        let ID = "common"
        var cell: ErmCommonCell? = tableView.dequeueReusableCellWithIdentifier(ID) as? ErmCommonCell
        if cell == nil {
            cell = ErmCommonCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
        }
        cell?.tableView = tableView
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.detailTextLabel?.x = CGRectGetMaxX(self.textLabel!.frame) + 10;
        
    }
    
    
    
}
