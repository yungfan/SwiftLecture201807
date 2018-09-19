//
//  YFModelTools.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFModelTools.h"
#import <MJExtension.h>

@implementation YFModelTools

+(instancetype)sharedTool{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
    
}

- (NSMutableArray *)object:(Class) target withArraykeyValues:(id) arrayValue;{
    
    return [target mj_objectArrayWithKeyValuesArray:arrayValue];
}

@end
