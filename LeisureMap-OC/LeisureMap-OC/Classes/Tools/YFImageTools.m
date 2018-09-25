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

- (UIImage *)downloadImageWithURL:(NSString *) url{
    
    __block UIImage *img = nil;
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    
    [downloader downloadImageWithURL:[NSURL URLWithString:url]  options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        if (!error) {
            
            img = image;
        }
        
    }];
    
    return img;
}


- (UIImage*)imageWithColor: (UIColor *) color {

    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
