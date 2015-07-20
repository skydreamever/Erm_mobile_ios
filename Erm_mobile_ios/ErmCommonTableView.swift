//
//  ErmCommonTableView.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/20/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

class ErmCommonTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    
    var groups = [ErmCommonGroup]()
    var count = 5
    
//    var theheight = 40
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.setupTableView()
        self.delegate = self
        self.dataSource = self
    }
    
    func setupTableView(){

        //        self.tableView.editing = true
        self.setEditing(true, animated: true)
        
        self.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.sectionFooterHeight = 0
        self.sectionHeaderHeight = 10
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.contentInset = UIEdgeInsetsMake(65, 0, 0, 0)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //        return self.groups.count
        return 1
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.groups[section].items?.count == nil ? 9 : self.groups[section].items!.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        let cell = ErmCommonCell.cellWithTableView(tableView)
        //        let items = self.groups[indexPath.section].items
        //        if items != nil {
        //            cell.item = items![indexPath.row]
        //            cell.numberOfSections = items!.count
        //            cell.indexPath = indexPath
        //        }
        //
        
        
        let cell = ErmCommonCell.cellWithTableView(tableView)
        cell.numberOfSections = 9
        cell.indexPath = indexPath
        if indexPath.row == 0 {
            let item = ErmCommonLabelItem()
            item.title = "日期"
            item.text = "2014-4-5"
            cell.item = item
        }else if indexPath.row == 1{
            let item = ErmCommonArrowItem()
            item.title = "财务组织"
            item.subtitle = "广州调研"
            cell.item = item
        }else if indexPath.row == 2{
            let item = ErmCommonArrowItem()
            item.title = "报销人部门"
            cell.item = item
        }else if indexPath.row == 3{
            let item = ErmCommonArrowItem()
            item.title = "冲借款"
            item.arrowText = "你有两笔借款待充值"
            cell.item = item
        }else if indexPath.row == 4{
            var items = [ErmCommonItem]()
            
            let itemA = ErmCommonArrowItem()
            itemA.title = "冲借款"
            itemA.subtitle = "你有两笔借款待充值"
            items.append(itemA)
            
            let itemB = ErmCommonArrowItem()
            itemB.title = "报销人部门"
            items.append(itemB)
            
            let itemC = ErmCommonSubItem()
            itemC.title = "新cell测试"
            itemC.subItems = items
            cell.item = itemC
            cell.subcellShow = false
            
        }else if indexPath.row == 5{
            let item = ErmCommonArrowItem()
            item.title = "            子cell"
            cell.item = item
        }
        return cell
        
    }
    
    //    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        let group = self.groups[section]
    //        return group.footer
    //    }
    //
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        let group = self.groups[section]
    //        return group.header
    //    }
    //
    //
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return CGFloat(theheight)
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            self.setEditing(false, animated: true)
        }else if indexPath.row == 1{
//            theheight += 40
            tableView.reloadData()
//            tableView.beginUpdates()
//            tableView.endUpdates()
            
        }else if indexPath.row == 4{
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ErmCommonCell


            
            
            if cell.subcellShow != nil{
                
                if !cell.subcellShow! {
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        let imageView = cell.accessoryView as! UIImageView
                        imageView.transform = CGAffineTransformMakeRotation(-90 * CGFloat(M_PI) / 180)
                    })
                    
                    count++
                    let index = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
                    self.insertRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Fade)
                    cell.subcellShow = true

                    
                }else{
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        let imageView = cell.accessoryView as! UIImageView
                        imageView.transform = CGAffineTransformMakeRotation(0)
                    })
                    
                    count--
                    let index = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
                    self.deleteRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Fade)
                    cell.subcellShow = false

                    
                }
                
            }
            

            
            
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {

        
        return ErmEnumUtils.setUITableViewCellEditingStyle()
        
    }
    
    
}
