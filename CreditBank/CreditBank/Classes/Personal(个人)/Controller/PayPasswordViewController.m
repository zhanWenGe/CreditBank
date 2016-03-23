//
//  PayPasswordViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "PayPasswordViewController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"
#import "SecurityVerificationViewController.h"

@interface PayPasswordViewController ()

@end

@implementation PayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付密码";
}

#pragma mark -- TableView Mehod

- (void)setUpData {
    
    [self setUpGroup];
}

- (void)setUpGroup
{
    
    settingGroup *group = [[settingGroup alloc] init];
    SettingItem *resetPayPassword = [SettingArrowItem arrowItemWithTitle:@"重置支付密码" pushController:nil];
    __weak typeof(self) profile = self;
    resetPayPassword.option = ^(SettingItem *item){
        
        [profile getVerificationCode:@"pas_pass"];
        
    };
    group.items = @[resetPayPassword];
    [self.data addObject:group];
    
}

/**
 *  获取验证码
 */
- (void)getVerificationCode:(NSString *)type
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.phoneNumber, type, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.token, @"token",
                                 self.phoneNumber, @"mobile",
                                 type, @"type",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    NSString *netStr = @"?anu=api/1/sms/get_verify_code";

    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"success: %@", responseObject);

        SecurityVerificationViewController *securityVerificatVC = [[SecurityVerificationViewController alloc] init];
        securityVerificatVC.token = self.token;
        securityVerificatVC.phoneNumber = self.phoneNumber;
        [self.navigationController pushViewController:securityVerificatVC animated:YES];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", responseObject);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
        [self setAlertViewWithMessage:@"网络出错了哦...伐开心..."];
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


@end
