//
//  YFFileTools.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/18.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface YFFileTools : NSObject

//文件类型
typedef NS_ENUM (NSInteger, FileType) {
    Array = 0,
    Dictionary = 1,
    String = 2
};

//文件写入成功回调block
typedef void (^filewWriteCompleted)(void);

//文件读取失败回调block
typedef void (^filewReadCompleted)(id content);


/**
 工具类的单例
 */
+ (instancetype)sharedTool;

/**
 写入文件
 */
-(void)writeToFile:(id)content FileName:(NSString *)fileName CompletionHandler:(filewWriteCompleted)completionHandler;

/**
 读取文件
 */
-(void)readFromFile:(id)fileName FileType:(FileType)fileType CompletionHandler:(filewReadCompleted)completionHandler;

/**
 写入NSUserDefaults
 */
-(void)writeUserDataWithValue:(id)data forKey:(NSString*)key;

/**
 读取NSUserDefaults
 */
- (id)readUserDataWithKey:(NSString*)key;

/**
 删除NSUserDefaults
 */
- (void)removeUserDataWithkey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
