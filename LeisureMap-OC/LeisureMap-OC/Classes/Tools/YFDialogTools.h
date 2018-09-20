//
//  YFDialogTools.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN


//普通对话框类型
typedef NS_ENUM (NSInteger, DialogStyle) {
    
    StyleInfo = 0,
    StyleError = 1
};

//UIAlertViewController类型
typedef NS_ENUM (NSInteger, AlertStyle) {
    
    StyleActionSheet = 0,
    StyleAlert = 1
};

@interface YFDialogTools : NSObject

/**
 工具类的单例
 */
+ (instancetype)sharedTool;

/**
 显示普通对话框
 */
- (void)showDialogWithType:(DialogStyle)style message:(NSString *) message;

/**
 关闭对话框
 */
- (void)dissmissHub;

/**
 显示UIAlertViewController
 */
- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message style:(AlertStyle)style actionTitles:(NSArray *)titles actionStyles:(NSArray *)styles alerAction:(void (^)(NSInteger index))actionHandler;


@end

NS_ASSUME_NONNULL_END
