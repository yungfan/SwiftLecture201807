//
//  ServiceCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit
import SDWebImage

class ServiceCellView: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    func updateContent(service: ServiceCategory) -> Void {
        
        self.lbName.text = service.name
        
        let imagePath = URL(string: service.imagePath)
        
        let placeholder = UIImage(named: "placeholder")
        
        self.bgImageView.sd_setImage(with: imagePath, placeholderImage: placeholder)
        

    }
    
}
