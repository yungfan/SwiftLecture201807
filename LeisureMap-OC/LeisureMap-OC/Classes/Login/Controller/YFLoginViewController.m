//
//  YFLoginViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/10.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFLoginViewController.h"
#import "YFLogin.h"
#import "YFFileTools.h"
#import "YFNetTools.h"
#import "YFDialogTools.h"

@interface YFLoginViewController ()

//用户名
@property (weak, nonatomic) IBOutlet UITextField *txtUname;
//密码
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

//登录按钮
- (IBAction)login:(id)sender;

//取消按钮
- (IBAction)cancel:(id)sender;
@end

@implementation YFLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getUnameAndPwd];

}

#pragma mark - NSUserDefault读取用户信息并填充
-(void)getUnameAndPwd{
    
    NSString *username = [[YFFileTools sharedTool] readUserDataWithKey:@"username"];
    
    NSString *password = [[YFFileTools sharedTool] readUserDataWithKey:@"password"];
    
    self.txtUname.text = username;
    
    self.txtPwd.text = password;
    
    
}

- (IBAction)login:(id)sender {
    
    //验证有没有网络
    NSInteger status = [[[YFFileTools sharedTool] readUserDataWithKey:@"AFNetworkReachabilityStatus"] integerValue];
    
    if (status == NotReachable) {
        
        
  
        [[YFDialogTools sharedTool]showDialogWithType:StyleError message:NSLocalizedString(@"no network", @"no network")];
        return;
    }
    
    else{
        
        //1. 判断用户的输入是否合法
        if([_txtUname.text isEqualToString:@""] || [_txtPwd.text isEqualToString:@""]){

            [[YFDialogTools sharedTool]showDialogWithType:StyleError message:NSLocalizedString(@"Username or password cannot be empty", @"Username or password cannot be empty")];
            
            return;
        }
        
        
        
        [[YFDialogTools sharedTool]showDialogWithType:StyleInfo message:NSLocalizedString(@"logining", @"logining")];
        
        //2.发送网络请求进行验证
        [YFLogin isValidUser:_txtUname.text andPwd:_txtPwd.text withCallback:^(BOOL isValid) {
            
            if (isValid) {
                
                [[YFDialogTools sharedTool]dissmissHub];
                
                //3.保存用户名和密码
                [[YFFileTools sharedTool] writeUserDataWithValue:self.txtUname.text forKey:@"username"];
                
                [[YFFileTools sharedTool] writeUserDataWithValue:self.txtPwd.text forKey:@"password"];
                
                //4.发出通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Login" object:nil];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                
            
                [[YFDialogTools sharedTool]showDialogWithType:StyleError message:NSLocalizedString(@"Username or password is incorrect", @"Username or password is incorrect")];
                
            }
            
        }];
        
    }
   
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 退键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];

}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
}

@end
