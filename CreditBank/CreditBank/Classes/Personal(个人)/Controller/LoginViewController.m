//
//  LoginViewController.m
//  CreditBank
//  登录控制器
//  Created by Eric on 15/4/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "LoginViewController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"
#import "BlueButtonView.h"
#import "ForgotPasswordViewController.h"
#import "Push.h"
#import "SSKeychain.h"

bool check = YES;

@interface LoginViewController() <BlueButtonViewDelegate, UITextFieldDelegate>
@property(nonatomic, weak) UITextField *phoneTextField;
@property(nonatomic, weak) UITextField *passwdTextField;
@property(nonatomic, weak) UIButton *remberBtn;

@end

@interface LoginViewController ()

@end

@implementation LoginViewController


#pragma mark -- LoginViewController Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFALT_BG;
    self.title = @"登录";
    
    // 初始化子控件
    [self setUp];
}

- (void)setUp {
    
    UIColor *btnColor = [UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1.0];
    UIFont  *btnFont  = [UIFont systemFontOfSize:12.0];
    
    UIView *bgView = [[UIView alloc] init];
    
    // 记住密码按钮
    UIButton *rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rememberBtn addTarget:self action:@selector(rememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [rememberBtn setImage:[UIImage imageNamed:@"remberme"] forState:UIControlStateNormal];
    [rememberBtn setImage:[UIImage imageNamed:@"rembermeSelected"] forState:UIControlStateSelected];
    [rememberBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    
    [rememberBtn setTitleColor:btnColor forState:UIControlStateNormal];
    rememberBtn.titleLabel.font = btnFont;
    
    CGFloat rememberBtnX = 10;
    CGFloat rememberBtnY = 10;
    CGFloat rememberBtnW = 80;
    CGFloat rememberBtnH = 13;
    rememberBtn.frame = CGRectMake(rememberBtnX, rememberBtnY, rememberBtnW, rememberBtnH);
    rememberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    [bgView addSubview:rememberBtn];
    self.remberBtn = rememberBtn;
    
    // 忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:btnColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = btnFont;
    
    
    CGFloat forgetBtnW = 80;
    CGFloat forgetBtnH = 13;
    CGFloat forgetBtnX = self.view.frame.size.width - forgetBtnW;
    CGFloat forgetBtnY = rememberBtnY;
    forgetBtn.frame = CGRectMake(forgetBtnX, forgetBtnY, forgetBtnW, forgetBtnH);
    [bgView addSubview:forgetBtn];
    
    // 登录按钮
    BlueButtonView *loginBtn = [[BlueButtonView alloc] initWithBtnTitle:@"登录"];
    loginBtn.delegate        = self;
    
    CGFloat loginBtnY = CGRectGetMaxY(forgetBtn.frame) + 20;
    CGFloat loginBtnW = self.view.frame.size.width;
    CGFloat loginBtnH = 48;
    CGFloat loginBtnX = 0;
    loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    [bgView addSubview:loginBtn];
    
    CGFloat bgViewX = 0;
    CGFloat bgViewY = 0;
    CGFloat bgViewW = self.view.frame.size.width;
    CGFloat bgViewH = CGRectGetMaxY(loginBtn.frame);
    bgView.frame = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);
    self.tableView.tableFooterView = bgView;

}

/**
 *  忘记密码事件
 */
- (void)forgetBtnClick {
    ANLog(@"忘记密码了 需要 通过手机重置密码");
    
    ForgotPasswordViewController *forgotPasswordVC = [[ForgotPasswordViewController alloc] init];
    forgotPasswordVC.title = ThroughTheMobilePhoneToResetThePassword;
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];

}

/**
 *  记住密码事件
 */
- (void)rememberBtnClick:(UIButton *)button {
    button.selected = (!button.selected);
    
    if (button.selected) {
        [self savePhoneNumeberPassword];
    } else {
        [self removePhoneNumeberPassword];
    }
}

#pragma mark -- BlueButtonViewDelegate

/**
 *  登录按钮事件
 */
- (void)btnClick:(id)view btn:(UIButton *)btn {
    if ([self.contentId isEqualToString:nil]) {
        // 自主登录
        [self postLoginInformation:nil];
    } else {
        // 授权绑定已有账号
        [self postLoginInformation:self.contentId];
    }
    ANLog(@"提交登陆信息");
}

/**
 *  提交登陆信息
 */
- (void)postLoginInformation:(NSString *)contentId
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.phoneTextField.text, self.passwdTextField.text, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSString *regId = [Push GetRegistrationID];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.phoneTextField.text, @"mobile",
                                 self.passwdTextField.text, @"password",
                                 regId, @"reg_id",
                                 @"ios", @"platform",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id",
                                self.contentId, @"connect_id", nil];
    NSString *netStr = @"?anu=api/1/user/dispose_login";
    
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 记住密码
        if ([@"selected" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"remberState"]]) {
            [self savePhoneNumeberPassword];
        }
        
        // 处理用户登录后的操作
        [Common userLoginSaveInfo:responseObject[@"token"] remeberMe:responseObject[@"remember_me"]];
    
     [self dismissViewControllerAnimated:YES completion:nil];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
       //  [self setAlertViewWithMessage:(NSString *)error];
    }];
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.phoneTextField becomeFirstResponder];
}

#pragma mark -- TableView Methed
- (void)setUpData {
    [self setUpGroup];
}

- (void)setUpGroup {
    settingGroup *group = [[settingGroup alloc] init];
    
    // 电话号码框
    SettingItem *phoneItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.delegate = self;
    phoneTextField.placeholder = @"手机号";
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    CGFloat PasswdTextFieldX = 20;
    CGFloat PasswdTextFieldY = 0;
    CGFloat PasswdTextFieldH = 44;
    CGFloat PasswdTextFieldW = self.view.frame.size.width;
    phoneTextField.frame = CGRectMake(PasswdTextFieldX, PasswdTextFieldY, PasswdTextFieldW, PasswdTextFieldH);
    
    self.phoneTextField = phoneTextField;
    phoneItem.customView = self.phoneTextField;
    
    // 密码
    SettingItem *passwdItem = [SettingItem itemWithIcon:nil title:nil];
    UITextField *passwdTextField  = [[UITextField alloc] init];
    passwdTextField.delegate = self;
    passwdTextField.placeholder = @"密码";
    passwdTextField.keyboardType = UIKeyboardTypeAlphabet;
    passwdTextField.secureTextEntry = YES;
    passwdTextField.frame = CGRectMake(PasswdTextFieldX, PasswdTextFieldY, PasswdTextFieldW, PasswdTextFieldH);
    self.passwdTextField  = passwdTextField;
    passwdItem.customView = self.passwdTextField;
    
    //填写账号和密码
    phoneTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (phoneTextField.text.length != 0) {
        passwdTextField.text = [SSKeychain passwordForService:SSKEYAPPID account:@"password"];
    }

    if ([@"selected" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"remberState"]]) {
        self.remberBtn.selected = YES;
    }
    
    group.items = @[phoneItem, passwdItem];
    [self.data addObject:group];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark -- UITextFieldDelegate

/**
 *  账号密码保存
 */
- (void)savePhoneNumeberPassword
{
    
    [SSKeychain setPassword:self.passwdTextField.text forService:SSKEYAPPID account:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] setObject:@"selected" forKey:@"remberState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  账号密码移除
 */
- (void)removePhoneNumeberPassword
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [SSKeychain deletePasswordForService:SSKEYAPPID account:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"remberState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
