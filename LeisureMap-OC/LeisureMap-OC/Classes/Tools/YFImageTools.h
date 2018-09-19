//
//  YFImageTools.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFImageTools : NSObject

/**
 工具类的单例
 */
+ (instancetype)sharedTool;

/**
UIImageView显示图片
 */
- (void)imageWithTarget:(UIImageView *)target  URL:(NSString *) url placeHolder:(NSString *)placeHolder;

/**
 从缓存读取图片
 */
- (UIImage *)imageFromDiskCacheWithURL:(NSString *) url;

@end

NS_ASSUME_NONNULL_END
