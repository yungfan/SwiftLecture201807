//
//  YFNetTools.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/15.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFNetTools.h"

@implementation YFNetTools

+(instancetype)sharedTool{
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
    });
    
    return instance;
    
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
//        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
//        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithURLString: (NSString *)URLString
                  parameters: (NSDictionary *)parameters
                      method: (HTTPMethod)method
                     success:(requestSuccess)success
                     failure:(requestFailure)failure {
    
    switch (method) {
        case GET: {
            [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                failure(error);
            }];
            
            break;
        }
            
        case POST:{
            [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            
            break;
        }
            
        default:
            break;
    }
}

@end
