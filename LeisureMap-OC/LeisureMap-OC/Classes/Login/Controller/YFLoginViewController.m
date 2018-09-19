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

@property (weak, nonatomic) IBOutlet UITextField *txtUname;

@property (weak, nonatomic) IBOutlet UITextField *txtPwd;


- (IBAction)login:(id)sender;
@end

@implementation YFLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     [self getUnameAndPwd];
    
    

}

-(void)getUnameAndPwd{
    
    NSString *username = [[YFFileTools sharedTool] readUserDataWithKey:@"username"];
    
    NSString *password = [[YFFileTools sharedTool] readUserDataWithKey:@"password"];
    
    self.txtUname.text = username;
    
    self.txtPwd.text = password;
    
    
}

- (IBAction)login:(id)sender {
    
    
    NSInteger status = [[[YFFileTools sharedTool] readUserDataWithKey:@"AFNetworkReachabilityStatus"] integerValue];
    
    if (status == NotReachable) {
        
        [[YFDialogTools sharedTool] showWithError:@"没有网络"];
        
    }
    
    else{
        
        //1. 判断用户的输入是否合法
        if([_txtUname.text isEqualToString:@""] || [_txtPwd.text isEqualToString:@""]){

             [[YFDialogTools sharedTool] showWithError:@"用户名或密码不能为空"];
            
            return;
        }
        
         [[YFDialogTools sharedTool] showWithInfo:@"正在登录..."];
        
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
      
                [[YFFileTools sharedTool] writeUserDataWithValue:self.txtPwd.text forKey:@"用户名或密码不正确"];
                
            }
            
        }];
        
    }
   
}

#pragma mark - 退键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
}

@end
