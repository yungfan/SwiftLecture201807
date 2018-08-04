//
//  StoreTableViewCell.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class StoreCellView: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    func updateContent(store: Store) -> Void {
        
        self.lbName.text = store.name
        
        let imagePath = URL(string: store.imagePath!)
        
        let bgPlaceholder = UIImage(named: "bgPlaceholder")
        
        self.bgImageView.sd_setImage(with: imagePath, placeholderImage: bgPlaceholder)
    }
    

    override var frame: CGRect{
        
            didSet {
                var newFrame = frame
                
                newFrame.origin.x += 5
                
                newFrame.size.width -= newFrame.origin.x * 2
                
                newFrame.origin.y += newFrame.origin.x
                
                newFrame.size.height -= newFrame.origin.x * 2
                
                super.frame = newFrame
            }
    }


}
