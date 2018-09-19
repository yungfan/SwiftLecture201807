//
//  YFServiceCollectionViewCell.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFServiceCollectionViewCell.h"
#import "YFImageTools.h"

@interface YFServiceCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation YFServiceCollectionViewCell

-(void)setService:(YFService *)service{
    
    _service = service;
    
    [[YFImageTools sharedTool]imageWithTarget:self.imgView URL:service.imagePath placeHolder:@"food"];
    
    self.lbName.text = service.name;
    
}

@end
