//
//  YFService.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFService : NSObject


@property (nonatomic , assign) NSInteger index;//索引

@property (nonatomic , copy) NSString * name;//名称

@property (nonatomic , copy) NSString  * imagePath;//图片


+(void)getServiceFromServer:(void (^)(NSArray *))callback;//服务器获取数据

+(void)getServiceFromLocal:(void (^)(NSArray *))callback;//本地获取数据

@end

