//
//  YFSplashViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/10.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFSplashViewController.h"
#import "YFImageTools.h"

@interface YFSplashViewController ()

//显示版本UILabel
@property (weak, nonatomic) IBOutlet UILabel *lbVersion;
//Logo
@property (weak, nonatomic) IBOutlet UIImageView *logo;
//背景
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@end

@implementation YFSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundView.image = [[YFImageTools sharedTool]imageWithColor:YFColorFromHex(0xF0F8FF)];
    
    //获取的版本号对应version
    NSString *version = AppVersion;

    //显示版本号
    self.lbVersion.text = version;
    
    //需要说明：由于不同用户安装的App版本可能不一样，所以有时候需要根据版本号去服务器加载数据
       
    //模拟加载数据 延迟2秒执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
          [self performSegueWithIdentifier:@"SplashMoveToMain" sender:nil];
        
    });
        
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     [self performSegueWithIdentifier:@"SplashMoveToMain" sender:nil];
    
}

@end
