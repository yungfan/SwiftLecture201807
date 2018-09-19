//
//  YFImageTools.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFImageTools.h"
#import <SDWebImage.h>

@implementation YFImageTools

+(instancetype)sharedTool{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
    
}

- (void)imageWithTarget:(UIImageView *)target  URL:(NSString *) url placeHolder:(NSString *)placeHolder{
    
    
    [target sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolder]];
    
    
}

- (UIImage *)imageFromDiskCacheWithURL:(NSString *) url{

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:url]];
    
    SDImageCache* cache = [SDImageCache sharedImageCache];
    
    return  [cache imageFromDiskCacheForKey:key];
    
}


@end
