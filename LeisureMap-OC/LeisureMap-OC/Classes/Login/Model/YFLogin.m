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
    NSString *url = [NSString stringWithFormat:@"https://score.azurewebsites.net/api/login/%@/%@", name, pwd];
    
    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
        callback(YES);
        
    } failure:^(NSError * _Nonnull error) {
        
        callback(NO);
        
    }];
    
}

@end
