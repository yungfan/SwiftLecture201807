//
//  YFMapTools.h
//  LeisureMap-OC
//
//  Created by 杨帆 on 2018/9/19.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMapTools : NSObject

/**
 工具类的单例
 */
+ (instancetype)sharedTool;


/**
 判断是否已经超出中国范围
 */
- (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

/**
 WGS-84转GCJ-02
 */
- (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

@end

NS_ASSUME_NONNULL_END
