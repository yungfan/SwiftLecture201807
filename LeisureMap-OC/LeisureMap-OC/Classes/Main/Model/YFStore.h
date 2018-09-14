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

@property (nonatomic , assign) NSInteger   serviceIndex;

@property (nonatomic , copy) NSString   * name;

@property (nonatomic , strong) YFLocation   * location;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , copy) NSString    * imagePath;

+(void)getStore:(void (^)(NSArray *))callback;

@end

