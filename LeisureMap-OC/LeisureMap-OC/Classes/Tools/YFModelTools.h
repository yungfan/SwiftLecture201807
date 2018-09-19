//
//  YFModelTools.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFModelTools : NSObject

/**
 工具类的单例
 */
+ (instancetype)sharedTool;

/**
JSON数组转模型数组
*/
- (NSMutableArray *)object:(Class) target withArraykeyValues:(id) arrayValue;

@end

NS_ASSUME_NONNULL_END
