//
//  YFLogin.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/11.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFLogin : NSObject

/**
 验证用户名和密码
 */
+(void)isValidUser:(NSString *)name andPwd:(NSString *)pwd withCallback:(void(^)(BOOL))callback;

@end

