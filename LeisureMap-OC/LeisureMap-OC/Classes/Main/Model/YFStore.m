//
//  YFStore.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/13.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFStore.h"
#import "YFNetTools.h"
#import <MJExtension.h>

@implementation YFStore

+(void)getStore:(void (^)(NSArray *))callback {
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"https://score.azurewebsites.net/api/store"];

    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
        callback([YFStore mj_objectArrayWithKeyValuesArray:responseObject]);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

@end
