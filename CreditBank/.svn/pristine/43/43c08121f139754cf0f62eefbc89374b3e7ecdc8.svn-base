//
//  QuickLoginController.m
//  CreditBank
//
//  Created by Eric on 15/4/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "QuickLoginController.h"
#import "BlueButtonView.h"
#import "PrefixHeader.pch"
#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"


#define startHight 84

@interface QuickLoginController () <BlueButtonViewDelegate>

@property (nonatomic, weak) BlueButtonView *loginBtn;
@property (nonatomic, weak) BlueButtonView *registerBtn;

@end

@implementation QuickLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFALT_BG;
    
    // 设置按钮
    [self setupButton];
}



/**
 *  设置同意按钮
 */
- (void)setupButton
{
    // 已有账号按钮
    BlueButtonView *loginBtn = [[BlueButtonView alloc] initWithBtnTitle:@"已有账号"];
    loginBtn.delegate = self;
    
    CGFloat loginBtnY = startHight ;
    CGFloat loginBtnW = WIDTH;
    CGFloat loginBtnH = 48;
    CGFloat loginBtnX = 0;
    
    loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    // 未注册绑定手机号码
    BlueButtonView *registerBtn = [[BlueButtonView alloc] initWithBtnTitle:@"未注册绑定手机号"];
    registerBtn.delegate = self;
    
    CGFloat registerBtnY = CGRectGetMaxY(loginBtn.frame) + 15;
    CGFloat registerBtnW = WIDTH;
    CGFloat registerBtnH = 48;
    CGFloat registerBtnX = 0;
    
    registerBtn.frame = CGRectMake(registerBtnX, registerBtnY, registerBtnW, registerBtnH);
    [self.view addSubview:registerBtn];
    self.registerBtn = registerBtn;
}

- (void)btnClick:(id)view btn:(UIButton *)btn
{
    if ([view isEqual:self.loginBtn]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.contentId = self.contentId;
        loginVC.title = @"登陆";
        [self.navigationController pushViewController:loginVC animated:YES];
    } else if ([view isEqual:self.registerBtn]) {
        ForgotPasswordViewController *forgotPasswordVC = [[ForgotPasswordViewController alloc] init];
        forgotPasswordVC.connectId = self.contentId;
        forgotPasswordVC.title = BindingMobilePhoneNumber;
        [self.navigationController pushViewController:forgotPasswordVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
