//
//  YFFileTools.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/18.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFFileTools.h"

@implementation YFFileTools

+(instancetype)sharedTool{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
    
}

-(void)writeToFile:(id)content FileName:(NSString *)fileName CompletionHandler:(filewWriteCompleted)completionHandler {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSError *error;
    
    if ([content isKindOfClass:NSString.class]) {
        
         [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    else {
        
        [content writeToFile:filePath atomically:YES];
        
    }
    
    if (!error) {
        
        completionHandler();
        
    }
    
}

-(void)readFromFile:(id)fileName FileType:(FileType)fileType CompletionHandler:(filewReadCompleted)completionHandler {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSError *error;
    
    if (fileType == String) {
        
         NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
        if (!error) {
            
            completionHandler(content);
            
        }
    }
    
    else if (fileType == Array){
        
        NSArray *content = [NSArray arrayWithContentsOfFile:filePath];
        
        completionHandler(content);
        
    }
    
    else if (fileType == Dictionary){
        
        NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        completionHandler(content);
        
    }
    
}



// 存储用户偏好设置到NSUserDefults
-(void)writeUserDataWithValue:(id)data forKey:(NSString*)key{
    
    if (data == nil){
        
        return;
    }
    
    else {

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//读取用户偏好设置
- (id)readUserDataWithKey:(NSString*)key{
    
    id temp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if(temp != nil) {
        
        return temp;
    }
    
    return nil;
}

//删除用户偏好设置
- (void)removeUserDataWithkey:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];

}
@end
