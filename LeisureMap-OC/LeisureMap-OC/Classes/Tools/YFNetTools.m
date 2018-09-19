//
//  YFNetTools.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/15.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFNetTools.h"
#import "YFFileTools.h"

@implementation YFNetTools

+(instancetype)sharedTool{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithBaseURL:nil];
    });
    
    return instance;
    
}

-(void)isNetworkAvailable {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
    
            case AFNetworkReachabilityStatusUnknown: {
                
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{
                //无法联网
                NSLog(@"NotReachable");
                
                [[YFFileTools sharedTool] writeUserDataWithValue:@(NotReachable) forKey:@"AFNetworkReachabilityStatus"];
                
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //手机自带网络
                NSLog(@"WWAN");
                [[YFFileTools sharedTool] writeUserDataWithValue:@(WWAN) forKey:@"AFNetworkReachabilityStatus"];
                break;
            }
               
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //WIFI
                NSLog(@"Wifi");
                [[YFFileTools sharedTool] writeUserDataWithValue:@(Wifi) forKey:@"AFNetworkReachabilityStatus"];
                break;
            }
                
        }
    }];
    
    [manager startMonitoring];
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    }
    return self;
}

- (void)requestWithURLString: (NSString *)URLString
                  parameters: (NSDictionary *)parameters
                      method: (HTTPMethod)method
                     success: (requestSuccess)success
                     failure: (requestFailure)failure {
    
    switch (method) {
            
        case GET: {
            [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                success(responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

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
