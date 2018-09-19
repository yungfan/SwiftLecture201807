//
//  YFDialogTools.m
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFDialogTools.h"

@implementation YFDialogTools


+(instancetype)sharedTool{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        
        [SVProgressHUD setBackgroundColor:YFRandomColor];
        
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 40)];
        
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        
    });
    
    return instance;

}


- (void)showWithInfo :(NSString *) message {
    
     [SVProgressHUD showWithStatus:message];
    
}




- (void)showWithError :(NSString *) message {
    
    [SVProgressHUD showErrorWithStatus:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        
    });
}

- (void)dissmissHub{
    
    [SVProgressHUD dismiss];
}


@end
