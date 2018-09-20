//
//  YFWaterfallCell.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/20.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFWaterfallCell.h"

@implementation YFWaterfallCell

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_imageView.layer setMasksToBounds:YES];
        
        [self.contentView addSubview:self.imageView];
    }
    
    return _imageView;
}


@end
