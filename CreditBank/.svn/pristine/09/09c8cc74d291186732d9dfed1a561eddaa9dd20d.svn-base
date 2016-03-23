//
//  TabBarViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "TabBarViewController.h"
#import "PrefixHeader.pch"
#import "NavigationController.h"

#import "ViewController.h"


@interface TabBarViewController () <HDTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) HDTabBar *customTabBar;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }

}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    HDTabBar *customTabBar = [[HDTabBar alloc] init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}

/**
 *  监听tabbar按钮的状态
 *
 *  @param tabBar 原来选中的控制器
 *  @param from   最新选中的控制器
 */
- (void)tabBar:(HDTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)setupAllChildViewControllers
{
//    ViewController *v = [[ViewController alloc] init];
//    [self setupChildViewController:v title:@"aa" imageName:nil selectedImageName:nil];
    
    // 1.精选
    SelectViewController *select = [[SelectViewController alloc] init];
    [self setupChildViewController:select title:@"发现" imageName:@"tabbar_left" selectedImageName:@"tabbar_left_selected"];
    
    // 2.积分
    IntegralViewController *integral = [[IntegralViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setupChildViewController:integral title:@"积分管家" imageName:@"tabbar_middle" selectedImageName:@"tabbar_middle_selected"];
    
    // 3.个人
    PersonalViewController *personal = [[PersonalViewController alloc] init];    
    [self setupChildViewController:personal title:@"个人中心" imageName:@"tabbar_right" selectedImageName:@"tabbar_right_selected"];

}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    // 1.设置控制器的属性
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置选中图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    
    // 设置选中的图标
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    }
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
