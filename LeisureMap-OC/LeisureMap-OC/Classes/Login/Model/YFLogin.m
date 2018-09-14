//
//  YFLogin.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFLogin.h"
#import <AFNetworking.h>

@implementation YFLogin


+(void)isValidUser:(NSString *)name andPwd:(NSString *)pwd withCallback:(void(^)(BOOL))callback{
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"https://score.azurewebsites.net/api/login/%@/%@", name, pwd];
    
    //AFNetworking 发送get请求获取数据
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callback(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callback(NO);
        
    }];
    
}

@end
