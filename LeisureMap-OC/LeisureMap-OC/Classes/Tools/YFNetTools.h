//
//  YFNetTools.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/15.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

//请求成功回调block
typedef void (^requestSuccess)(id  _Nullable responseObject);

//请求失败回调block
typedef void (^requestFailure)(NSError * _Nonnull error);

typedef NS_ENUM (NSInteger, HTTPMethod) {
    GET = 0,
    POST = 1,
//    PUT = 2,
//    DELETE = 3,
//    HEAD = 4
};

@interface YFNetTools : AFHTTPSessionManager

/**
工具类的单例
 */
+ (instancetype)sharedTool;

/**
具体的请求方法
 */
- (void)requestWithURLString: (NSString * _Nonnull)URLString
                  parameters: (NSDictionary * _Nullable )parameters
                      method: (HTTPMethod)method
                    success:(requestSuccess _Nonnull)success
                     failure:(requestFailure _Nonnull)failure;

NS_ASSUME_NONNULL_END


@end
