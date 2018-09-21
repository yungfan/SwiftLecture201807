//
//  YFWaterFall.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/21.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFWaterFall.h"
#import "YFNetTools.h"
#import "YFFileTools.h"
#import "YFModelTools.h"

@implementation YFWaterFall

+(void)getWaterFall:(void (^)(NSArray *))callback {
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"%@/LeisureMapAPI/waterfall.json", BaseURL];
    
    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
        //转模型
        [[YFFileTools sharedTool] writeToFile:responseObject FileName:@"stores.json" CompletionHandler:^{
            
            NSLog(@"stores写入成功");
        }];
        
        callback([[YFModelTools sharedTool] object:YFWaterFall.class withArraykeyValues:responseObject]);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

@end
