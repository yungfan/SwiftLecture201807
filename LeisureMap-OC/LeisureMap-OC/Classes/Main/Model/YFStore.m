//
//  YFStore.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/13.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFStore.h"
#import "YFNetTools.h"
#import "YFFileTools.h"
#import "YFModelTools.h"

@implementation YFStore

+(void)getStoreFromServer:(void (^)(NSArray *))callback {
    
    //请求的url
    NSString *url = [NSString stringWithFormat:@"%@/LeisureMapAPI/store.json", BaseURL];

    [[YFNetTools sharedTool]  requestWithURLString:url parameters:nil method:GET success:^(id  _Nullable responseObject) {
        
         //转模型
        [[YFFileTools sharedTool] writeToFile:responseObject FileName:@"stores.json" CompletionHandler:^{
            
            NSLog(@"stores写入成功");
        }];
       
        callback([[YFModelTools sharedTool] object:YFStore.class withArraykeyValues:responseObject]);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}


+(void)getStoreFromLocal:(void (^)(NSArray *))callback{
    
    [[YFFileTools sharedTool] readFromFile:@"stores.json" FileType:Array CompletionHandler:^(id  _Nonnull content){
        
        callback([[YFModelTools sharedTool] object:YFStore.class withArraykeyValues:content]);
        
    }];
    
}

@end
