//
//  YFNavigationController.m
//  YFTabbarController
//
//  Created by yangfan on 2018/3/13.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "YFNavigationController.h"

@interface YFNavigationController ()

@end

@implementation YFNavigationController

//重写navC的pushVC方法，以便统一设置push进来的vc的左侧“返回”按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        //方案二 如果需要进一步定制 可以改为leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
        //设置颜色
        self.navigationBar.tintColor = [UIColor blackColor];
        
        //这句会立即调用被push的VC的viewDidLoad方法，必须放在最后面，否则上面的代码会对viewDidLoad中代码造成覆盖，导致viewDidLoad设置无效。
        [super pushViewController:viewController animated:animated];//animated换为NO，所有VC没有动画
        
        
    }
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}


@end
