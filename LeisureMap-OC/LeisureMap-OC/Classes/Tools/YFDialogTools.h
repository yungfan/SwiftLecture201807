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

@interface YFDialogTools : NSObject

/**
 工具类的单例
 */
+ (instancetype)sharedTool;

/**
 显示普通信息
 */
- (void)showWithInfo :(NSString *) message;

/**
 显示错误信息
 */
- (void)showWithError :(NSString *) message;

/**
 显示错误信息
 */
- (void)dissmissHub;


@end

NS_ASSUME_NONNULL_END
