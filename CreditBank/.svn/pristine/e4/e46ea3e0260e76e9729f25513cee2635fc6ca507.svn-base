//
//  NavigationController.m
//  CreditBank
//
//  Created by Eric on 15/4/1.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NavigationController.h"
#import "PrefixHeader.pch"
#import "ShopIndexViewController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 恢复自定义失去的手势功能
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}


/**
 *  使用类的情况下才会调用
 */
+ (void)initialize {
    [super initialize];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor =[UIColor blackColor];

}

/**
 *  设置导航栏为黑色
 *
 *  @param Controller 当前要设置的控制器
 */
+ (void)setNavigationBarBlack:(UIViewController *)Controller {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor =[UIColor whiteColor];
    
    Controller.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    Controller.navigationController.navigationBar.barTintColor = HDColor(36, 39, 54);
    
    
}

/**
 *  设置导航栏为白色
 *
 *  @param Controller 当前要设置的控制器
 */
+ (void)setNavigationBarDefault:(UIViewController *)Controller {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor =[UIColor blackColor];
    
    Controller.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    Controller.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 隐藏TarBar
    if (self.viewControllers.count > 0) {
        // 子控制器 Tarbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 子控制器 自定义leftBarButton
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBarButtonItem"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemClick)];
        viewController.navigationItem.leftBarButtonItem = leftBarButton;
    }

    [super pushViewController:viewController animated:animated];
}


- (void)leftBarButtonItemClick {
    [self popViewControllerAnimated:YES];
}

@end
