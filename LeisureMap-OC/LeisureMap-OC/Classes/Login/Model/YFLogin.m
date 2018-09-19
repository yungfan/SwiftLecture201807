//
//  YFLogin.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFLogin.h"
#import "YFNetTools.h"

@implementation YFLogin


+(void)isValidUser:(NSString *)name andPwd:(NSString *)pwd withCallback:(void(^)(BOOL))callback{
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"http://localhost:8080/LeisureMapAPI/login.json"];
    
    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
        if ([name isEqualToString:responseObject[@"username"]] && [pwd isEqualToString:responseObject[@"password"]]) {
           
            callback(YES);
            
        }
        else{
            
            callback(NO);
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        callback(NO);
        
    }];
    
}

@end
