//
//  YFStore.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/13.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFLocation.h"


@interface YFStore : NSObject

@property (nonatomic , assign) NSInteger index; //索引

@property (nonatomic , assign) NSInteger   serviceIndex;//服务索引

@property (nonatomic , copy) NSString * name;//名称

@property (nonatomic , strong) YFLocation * location;//地理位置

@property (nonatomic , copy) NSString  * imagePath;//图片

+(void)getStoreFromServer:(void (^)(NSArray *))callback;//服务器获取数据

+(void)getStoreFromLocal:(void (^)(NSArray *))callback;//本地获取数据

@end

