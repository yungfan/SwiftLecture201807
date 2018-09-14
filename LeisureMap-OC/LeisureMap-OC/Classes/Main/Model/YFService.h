//
//  YFService.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFService : NSObject

@property (nonatomic , copy) NSString  * imagePath;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , copy) NSString * name;

+(void)getService:(void (^)(NSArray *))callback;

@end

