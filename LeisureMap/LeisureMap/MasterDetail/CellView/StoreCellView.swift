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
        
        self.lbName.text = store.Name
        
        let url = URL(string: store.ImagePath!)
        
        self.bgImageView.kf.setImage(with: url)
    }
    


}
