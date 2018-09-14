//
//  YFStoreTableViewCell.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/13.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFStoreTableViewCell.h"

@implementation YFStoreTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.textLabel.textColor = [UIColor grayColor];
    
    self.textLabel.font = [UIFont systemFontOfSize:16];
   
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    self.imageView.frame =CGRectMake(15, 20, 60, 60);
    
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [self setSeparatorInset:UIEdgeInsetsMake(0, 10, [UIScreen mainScreen].bounds.size.width, 1)];
    
    
}

@end
