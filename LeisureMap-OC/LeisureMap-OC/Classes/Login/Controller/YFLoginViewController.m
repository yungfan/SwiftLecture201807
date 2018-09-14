//
//  YFLoginViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/10.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFLoginViewController.h"
#import <SVProgressHUD.h>
#import "YFLogin.h"

@interface YFLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUname;

@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

- (IBAction)login:(id)sender;
@end

@implementation YFLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    
    //1. 判断用户的输入是否合法
    if([_txtUname.text isEqualToString:@""] || [_txtPwd.text isEqualToString:@""]){
        
        [SVProgressHUD showErrorWithStatus:@"用户名或密码不能为空"];
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登录..."];

    //2.发送网络请求进行验证
    [YFLogin isValidUser:_txtUname.text andPwd:_txtPwd.text withCallback:^(BOOL isValid) {
        
        if (isValid) {
            
            [SVProgressHUD dismiss];
            //3.跳转到下个界面
            [self performSegueWithIdentifier:@"LoginMoveToMain" sender:nil];
            
            
        }
        
    }];
}

#pragma mark - 退键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

@end
