//
//  ServiceCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class ServiceCellView: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    func updateContent(service: ServiceCategory) -> Void {
        
        self.lbName.text = service.Name
        
        let imagePath = URL(string: service.ImagePath!)
        
        let placeholder = UIImage(named: "placeholder")
        
        self.bgImageView.kf.setImage(with: imagePath, placeholder: placeholder)
        

    }
    
}
