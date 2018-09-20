//
//  YFSplashViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/10.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFSplashViewController.h"

@interface YFSplashViewController ()

//显示版本UILabel
@property (weak, nonatomic) IBOutlet UILabel *lbVersion;

@end

@implementation YFSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取的版本号对应version
    NSString *version = AppVersion;

    //显示版本号
    self.lbVersion.text = version;
       
    //延迟2秒执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
          [self performSegueWithIdentifier:@"SplashMoveToMain" sender:nil];
        
    });
        
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     [self performSegueWithIdentifier:@"SplashMoveToMain" sender:nil];
    
}

@end
