//
//  YFService.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFService.h"
#import "YFNetTools.h"
#import "YFFileTools.h"
#import "YFModelTools.h"

@implementation YFService

+(void)getServiceFromServer:(void (^)(NSArray *))callback {

    //请求的url
    NSString *url = [NSString stringWithFormat:@"http://localhost:8080/LeisureMapAPI/service.json"];
    
    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
        callback([[YFModelTools sharedTool] object:YFService.class withArraykeyValues:responseObject]);
        
        [[YFFileTools sharedTool] writeToFile:responseObject FileName:@"services.json" CompletionHandler:^{
            
            NSLog(@"services写入成功");
        }];
 
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

+(void)getServiceFromLocal:(void (^)(NSArray *))callback {
    
    [[YFFileTools sharedTool] readFromFile:@"services.json" FileType:Array CompletionHandler:^(id  _Nonnull content){
        
       callback([[YFModelTools sharedTool] object:YFService.class withArraykeyValues:content]);
        
    }];
}

@end
