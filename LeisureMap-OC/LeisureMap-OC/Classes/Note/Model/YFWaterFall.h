//
//  YFWaterFall.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/21.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFWaterFall : NSObject

@property (nonatomic , assign) NSInteger index;//索引

@property (nonatomic , copy) NSString * name;//名称

@property (nonatomic , copy) NSString  * imagePath;//图片

@property (nonatomic , copy) NSString  * size;//图片大小

+(void)getWaterFall:(void (^)(NSArray *))callback;//服务器获取数据

@end

NS_ASSUME_NONNULL_END
