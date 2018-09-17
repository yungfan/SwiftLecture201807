//
//  YFMapViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/17.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFMapViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "YFAnnotation.h"


#import "WGS84ConvertToGCJ02ForAMapView.h"

@interface YFMapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property(nonatomic, strong) CLLocationManager *manager;

@end

@implementation YFMapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Map";
    
    if ([CLLocationManager locationServicesEnabled] ) {
        
         [self.manager startUpdatingLocation];
        
        self.map.showsUserLocation = YES;
        
        //用这句话可以自动缩放地图的显示区域
        //self.map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    }
    
}


- (CLLocationManager *)manager{
    
    if (!_manager) {
        
        _manager = [[CLLocationManager alloc]init];
        
        _manager.delegate = self;
        
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [_manager requestWhenInUseAuthorization];
        
    }
    
    return _manager;
    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
   
    CLLocationCoordinate2D coordinate2D = [WGS84ConvertToGCJ02ForAMapView transformFromWGSToGCJ:location.coordinate];
    
    [self centerMapOnLocation:coordinate2D];
    
    [UIView animateWithDuration:2.0f animations:^{
        
        YFAnnotation *annotation = [[YFAnnotation alloc]init];
        
        annotation.title = @"ABC";
        
        annotation.subtitle = @"Apple iOS by OC";
        
        annotation.coordinate = [WGS84ConvertToGCJ02ForAMapView transformFromWGSToGCJ:CLLocationCoordinate2DMake(31.2926511800, 118.3623587000)];
        
        [self.map addAnnotation:annotation];
    } completion:^(BOOL finished) {
        
        [self.manager stopUpdatingLocation];
    }];
    
}



-(void)centerMapOnLocation:(CLLocationCoordinate2D)location{

    CLLocationDistance distance = 1000;

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, distance, distance);

    [self.map setRegion:region animated:YES];
}



/**
 *  每当添加一个大头针 该方法被调用。如果该方法没有实现, 或者返回nil, 那么就会使用系统默认的大头针视图
 *  如果我希望自定义，怎么办？该方法的返回值就是你自定义的的大头针
 *  该方法非常类似 cellForRowAtIndex（返回的是用户定义的一个cell）
 *  参数中的annotation就是自己添加的MyAnnotation对象 自动会传递过来
 *  第一次定位成功以后也会调用一次该方法 显示用户位置 此时传进来的annotation参数是MKUserLocation
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //判断是不是用户的大头针数据模型 让用户位置的大头针和其他的大头针不一样
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    static NSString *Id  = @"ABC";
    
    MKAnnotationView *mkav = [mapView dequeueReusableAnnotationViewWithIdentifier:Id];
    
    if (!mkav) {
        
        mkav = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:Id];
        
    }
    //点击能显示气泡
    mkav.canShowCallout = YES;
    
    mkav.image = [UIImage imageNamed:@"face"];
    
    mkav.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"face"]];
    
    UIButton *detail = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    [detail addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    mkav.rightCalloutAccessoryView = detail;
    
    return mkav;
}

-(void)btnClick:(id)sender{
    
    [self performSegueWithIdentifier:@"MapMoveToWeb" sender:nil];
    
}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
