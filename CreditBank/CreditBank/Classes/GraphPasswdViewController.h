//
//  GraphPasswdViewController.h
//  CreditBank
//
//  Created by Eric on 15/4/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//



#import <UIKit/UIKit.h>
/**
 *  密码验证通过，进行回调处理
 */
typedef void(^checkSuccessBlock)(void);
/**
 *  密码验证5次失败，进行回调处理
 */
typedef void(^checkFailBlock)(void);
/**
 *  忘记密码，进行回调处理
 */
typedef void(^forgetPasswdBlock)(void);

@interface GraphPasswdViewController : UIViewController
/**
 *  自定义返回控制器
 */
@property(nonatomic, weak) UITableViewController *top;
/**
 *  自定义push控制器
 *  当用户输入点击忘记密码和密码次数错误太多
 *  用户需要使用登录界面进行登录，需要用这个控制器进行push
 *
 */
@property(nonatomic, weak) UIViewController *controller;
/**
 *  是否验证重设手势密码
 */
@property(nonatomic, assign, getter=isCheckRsetPasswd) BOOL checkRsetPasswd;

/**
 *  密码验证通过回调这个函数
 */
@property(nonatomic, copy) checkSuccessBlock successBlock;

/**
 *  忘记密码回调这个函数
 */
@property(nonatomic, copy) forgetPasswdBlock forgetPasswBlock;
/**
 *  显示手势密码界面
 *
 *  @param controller controller description
 */
+ (void)showGraphPasswdController:(UIViewController *) controller;
@end
