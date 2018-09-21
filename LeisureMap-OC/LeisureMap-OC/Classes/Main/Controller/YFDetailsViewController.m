//
//  YFDetailsViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/17.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface YFDetailsViewController ()

//显示本地网页的WKWebView
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation YFDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.selectedStore.name;
    
    [self setupWebView];
}

-(void)setupWebView{
    
    _webView = [[WKWebView alloc] init];
    
     //去掉进度条
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    //获取bundlePath 路径
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    //获取本地html目录 basePath
    NSString *basePath = [NSString stringWithFormat: @"%@/www", bundlePath];
    
    //获取本地html目录 baseUrl
    NSURL *baseUrl = [NSURL fileURLWithPath: basePath isDirectory: YES];
    
    //html 路径
    NSString *indexPath = [NSString stringWithFormat: @"%@/sample.html", basePath];
    
    //html 文件中内容
    NSString *indexContent = [NSString stringWithContentsOfFile:
                              indexPath encoding: NSUTF8StringEncoding error:nil];
    
    //显示内容
    [_webView loadHTMLString: indexContent baseURL: baseUrl];
     
    [self.view addSubview:_webView];
    
}


-(void)viewWillLayoutSubviews{
    
    self.webView.frame = CGRectMake(0, SafeAreaTopHeight, ScreenW, ContentHeight);
}

-(void)dealloc{
    
    NSLog(@"%s", __func__);
}

@end
