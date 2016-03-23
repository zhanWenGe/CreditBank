//
//  LogoutHandler.m
//  CreditBank
//
//  Created by Eric on 15/4/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "LogoutHandler.h"
#import "IndexViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "NavigationController.h"
#import "SetGraphPasswdViewController.h"
#import "SSKeychain.h"
#import "PrefixHeader.pch"

@implementation LogoutHandler

/**
 *  退出登录（删除本地存储用户信息)
 *
 *  @param controller 当前页
 */
+ (void)logoutHandlerFromControllor
{
    // 移除账号密码
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    // 手势密码
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSKYE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:nil];
}

/**
 *  跳转到登陆页
 *
 *  @param controller 当前页
 */
+ (void)logoutHandlerFromControllor:(UIViewController *)from
{
    // 注销新浪微博授权登陆
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    // 注销QQ授权登陆
    [ShareSDK cancelAuthWithType:ShareTypeQQ];

    [LogoutHandler logoutHandlerFromControllor];
    
    // 跳转至登陆页面
    IndexViewController *indexVC = [[IndexViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:indexVC];
    [from.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}

///**
//*  从from调转到to
//*
//*  @param from 当前页
//*  @param to   目的页
//*/
//+ (void)logoutHandlerFromControllor:(UIViewController *)from popToController:(UIViewController *)to
//{
//    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
//    [ShareSDK cancelAuthWithType:ShareTypeQQ];
//    [from.navigationController popViewControllerAnimated:YES];
//}

@end
