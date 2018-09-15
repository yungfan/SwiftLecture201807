//
//  YFService.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFService.h"
#import "YFNetTools.h"
#import <MJExtension.h>

@implementation YFService

+(void)getService:(void (^)(NSArray *))callback {

    //请求的url
    NSString *url = [NSString stringWithFormat:@"https://score.azurewebsites.net/api/servicecategory"];
    
    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
         callback([YFService mj_objectArrayWithKeyValuesArray:responseObject]);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

@end
