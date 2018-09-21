//
//  YFWebViewController.m
//  LeisureMap-OC
//
//  Created by student on 2018/9/17.
//  Copyright © 2018年 abc. All rights reserved.
//

#import "YFWebViewController.h"
#import <WebKit/WebKit.h>

@interface YFWebViewController ()

//WKWebView 不能直接在SB中使用
@property (strong, nonatomic) WKWebView *webView;

//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation YFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Web";
    
    [self setupWebView];
}

-(void)viewWillLayoutSubviews{
    
    self.webView.frame = CGRectMake(0, SafeAreaTopHeight + self.progressView.frame.size.height, ScreenW, ContentHeight);
    
}

-(void)setupWebView{
    
    _webView = [[WKWebView alloc] init];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.abc.edu.cn"]];
    
    [_webView loadRequest:request];
    
    //监听进度条、标题
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:_webView];
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqual:@"title"] && object == self.webView) {
        
         self.title = self.webView.title;
    }
    else if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        
        [self.progressView setAlpha:1.0f];
        
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        
        if (self.webView.estimatedProgress  >= 1.0f) {
            
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                [self.progressView setAlpha:0.0f];
                
            } completion:^(BOOL finished) {
                
                [self.progressView setProgress:0.0f animated:YES];
                
            }];
        }
    }
    else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
    


- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"title"];
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    NSLog(@"%s", __func__);
}

@end
