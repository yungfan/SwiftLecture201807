//
//  YFAnnotation.h
//  LeisureMap-OC
//
//  Created by student on 2018/9/17.
//  Copyright © 2018年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

//大头针模型
@interface YFAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, copy, nullable) NSString *subtitle;


@end

NS_ASSUME_NONNULL_END
