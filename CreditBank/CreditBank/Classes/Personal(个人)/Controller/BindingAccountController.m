//
//  BindingAccountController.m
//  CreditBank
//
//  Created by Eric on 15/5/14.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BindingAccountController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"
#import "BlueButtonView.h"

@interface BindingAccountController () <BlueButtonViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property(nonatomic, weak) UITextField *phoneTextField;
@property(nonatomic, weak) UITextField *passwdTextField;
@property (nonatomic, weak) UIButton *remberBtn;



@end

@implementation BindingAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ANLog(@"%@", self.shopId);
    
    // 初始化子控件
    [self setUp];
}

- (void)setUp {
    
    UIView *bgView = [[UIView alloc] init];
    
    
    // 登录按钮
    BlueButtonView *loginBtn = [[BlueButtonView alloc] initWithBtnTitle:@"提交绑定"];
    loginBtn.delegate        = self;
    
    CGFloat loginBtnY = 20;
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

#pragma mark -- BlueButtonViewDelegate

/**
 *  登录按钮事件
 */
- (void)btnClick:(id)view btn:(UIButton *)btn {
  
    ANLog(@"提交登陆信息");
    if (self.phoneTextField.text.length == 0 || self.passwdTextField.text.length == 0) {
        [self setAlertViewWithMessage:@"用户名或密码填写不完整" tag:0];
    } else {
        [self postLoginInformation];
    }
}

/**
 *  提交登陆信息
 */
- (void)postLoginInformation
{
    NSString *token = [Common token];
    NSString *time = [NSDate getTime];
    NSArray *arr = @[token, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                token, @"token",
                                self.phoneTextField.text, @"mall_username",
                                self.passwdTextField.text, @"mall_password",
                                self.shopId, @"shop_id",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id",nil];
    NSString *netStr = @"?anu=api/1/connect_mall/save_connect_mall_info";

    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
         ANLog(@"success: %@", responseObject);
        [self setAlertViewWithMessage:@"绑定成功" tag:10000];
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", responseObject[@"error_info"]);
        [self setAlertViewWithMessage:responseObject[@"error_info"] tag:0];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
        [self setAlertViewWithMessage:(NSString *)error tag:0];
    }];
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message tag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
//        self.changeSubTitleBlock(@"已绑定");
        self.changeSubTitleBlock(@"已绑定", HDColor(128, 128, 128));
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)changeSubTitleWithBlock:(ChangeSubTitleBlock)subTitle
{
    self.changeSubTitleBlock = subTitle;
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
    phoneTextField.placeholder = @"账号";
//    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
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
    
    group.items = @[phoneItem, passwdItem];
    [self.data addObject:group];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}



@end
