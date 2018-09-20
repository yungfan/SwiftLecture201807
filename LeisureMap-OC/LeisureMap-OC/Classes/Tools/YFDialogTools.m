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
    
    
    
}


- (void)showDialogWithType:(DialogStyle)style message:(NSString *) message{
    
    if (style == StyleInfo) {
        
        [SVProgressHUD showWithStatus:message];
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:message];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
    }
    
}

- (void)dissmissHub{
    
    [SVProgressHUD dismiss];
}


- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message style:(AlertStyle)style actionTitles:(NSArray *)titles actionStyles:(NSArray *)styles alerAction:(void (^)(NSInteger index))actionHandler{
    
    //判断弹框类型
    if (style == StyleAlert) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:[titles objectAtIndex:i] style:[[styles objectAtIndex:i]integerValue] handler:^(UIAlertAction * _Nonnull action) {
                
                if (actionHandler) {
                    
                    actionHandler(i);
                }
                
            }];
            
            [alert addAction:action];
        }
        
        return alert;
        
    }
    
    else{
        
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:[titles objectAtIndex:i] style:[[styles objectAtIndex:i]integerValue] handler:^(UIAlertAction * _Nonnull action) {
                
                if (actionHandler) {
                    
                    actionHandler(i);
                }
                
            }];
            
            [sheet addAction:action];
        }
        
        return sheet;
    }
}

@end
