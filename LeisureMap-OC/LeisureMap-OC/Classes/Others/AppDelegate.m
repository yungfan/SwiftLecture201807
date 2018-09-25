//
//  AppDelegate.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/10.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "AppDelegate.h"
#import "YFNetTools.h"
#import "YFFileTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //监听网络
    [[YFNetTools sharedTool] isNetworkAvailable];
    
    //判断版本号
    //判断当前App安装的版本号 与 本地存储的App的版本号 进行比较
    double installVersion =  [AppVersion doubleValue];
    
    double localVersion = [[[YFFileTools sharedTool] readUserDataWithKey:@"localVersion"] doubleValue];
    
    //1.安装的版本号 > 本地存储的版本号 显示新特性界面 保存版本号
    if (installVersion > localVersion) {
        
        NSLog(@"显示新特性界面");
        
        [[YFFileTools sharedTool] writeUserDataWithValue:@(installVersion) forKey:@"localVersion"];
    }
    
    //2.安装的版本号 = 本地存储的版本号 显示主界面
    else{
        
        NSLog(@"显示主界面");
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
