//
//  YFStore.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/13.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFStore.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@implementation YFStore

+(void)getStore:(void (^)(NSArray *))callback {
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"https://score.azurewebsites.net/api/store"];
    
    //AFNetworking 发送get请求获取数据
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callback([YFStore mj_objectArrayWithKeyValuesArray:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

@end
