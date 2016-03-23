//
//  SetPasswordViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/1.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "SetPasswordViewController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"


@interface SetPasswordViewController()
@property(nonatomic, weak) UITextField *passwdTextField;
@property(nonatomic, weak) UITextField *newpasswdTextField;
@end

@interface SetPasswordViewController ()

@end

@implementation SetPasswordViewController

- (void)dealloc {
    // 释放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户密码";
    self.view.backgroundColor = DEFALT_BG;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePassword:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.passwdTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.newpasswdTextField];

}

/**
 *  保存按钮的状态
 */
- (void)changeText {
    self.navigationItem.rightBarButtonItem.enabled = (self.newpasswdTextField.text.length && self.passwdTextField.text.length);
}

/**
 *  修改密码
 */
- (void)savePassword:(UIBarButtonItem *)btn {
   
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.token, self.passwdTextField.text, self.newpasswdTextField.text, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                self.passwdTextField.text, @"old_pwd",
                                self.newpasswdTextField.text, @"new_pwd",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/user/save_password";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

/**
 *  弹出提示框
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
    [self.passwdTextField becomeFirstResponder];
}


#pragma mark -- TableView Mehod
- (void)setUpData {
    [self setUpGroup1];
}


- (void)setUpGroup1 {
    settingGroup *group           = [[settingGroup alloc] init];
    
    // 原密码框
    SettingItem *passwdItem       = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *passwdTextField  = [[UITextField alloc] init];
    passwdTextField.placeholder   = @"请输入原密码";
    [passwdTextField setSecureTextEntry:YES];

    CGFloat passwdTextFieldX      = 20;
    CGFloat passwdTextFieldY      = 0;
    CGFloat passwdTextFieldH      = 44;
    CGFloat passwdTextFieldW      = self.view.frame.size.width;
    passwdTextField.frame = CGRectMake(passwdTextFieldX, passwdTextFieldY, passwdTextFieldW, passwdTextFieldH);
    
    self.passwdTextField   = passwdTextField;
    passwdItem.customView  = self.passwdTextField;
    
    
    // 新密码
    SettingItem *newPasswdItem       = [SettingItem itemWithIcon:nil title:nil];
    UITextField *newPasswdTextField  = [[UITextField alloc] init];
    newPasswdTextField.placeholder   = @"请输入新密码";
    [newPasswdTextField setSecureTextEntry:YES];
    
    newPasswdTextField.frame = CGRectMake(passwdTextFieldX, passwdTextFieldY, passwdTextFieldW, passwdTextFieldH);
    self.newpasswdTextField  = newPasswdTextField;
    newPasswdItem.customView = self.newpasswdTextField;
    
    
    group.items = @[passwdItem, newPasswdItem];
    [self.data addObject:group];
    
}
@end
