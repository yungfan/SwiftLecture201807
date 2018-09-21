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

//菜单图片
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//菜单文字
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation YFServiceCollectionViewCell

-(void)setService:(YFService *)service{
    
    _service = service;
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", BaseURL, service.imagePath];
    
    [[YFImageTools sharedTool]imageWithTarget:self.imgView URL:imagePath placeHolder:@"food"];
    
    self.lbName.text = service.name;
    
}

@end
