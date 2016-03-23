//
//  SecurityVerificationViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SecurityVerificationViewController.h"
#import "PrefixHeader.pch"
#import "BlueButtonView.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"
#import "ResetPayPaswdViewController.h"

@interface SecurityVerificationViewController ()<BlueButtonViewDelegate>

@property (nonatomic, weak) BlueButtonView *getVerificationCodeBtn;
@property (nonatomic, weak) UITextField *verificationText;


@end

@implementation SecurityVerificationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFALT_BG;
    self.title = @"安全验证";
    
    // 1.设置验证码输入框
    [self setupInputVerificatText];
    
    // 2.设置按钮
    [self setupVerificationButton];
    
}

/**
 *  设置验证码输入框
 */
- (void)setupInputVerificatText
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 85, WIDTH + 1, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CGFloat verificationTextX = 20;
    CGFloat verificationTextY = 60;
    CGFloat verificationTextW = WIDTH - 20;
    CGFloat verificationTextH = 20;
    UITextField *verificationText = [[UITextField alloc] init];
    [self.view addSubview:verificationText];
    
    view.layer.borderColor = [HDColor(214, 214, 214) CGColor];
    view.layer.borderWidth = 0.5f;
    
    verificationText.frame = CGRectMake(verificationTextX, verificationTextY, verificationTextW, verificationTextH);
    verificationText.center = CGPointMake(verificationText.center.x, view.center.y);
    
    verificationText.placeholder = @"已向您的手机发送验证码,请输入您收到的验证码";
    verificationText.font = [UIFont systemFontOfSize:15];
    verificationText.keyboardType = UIKeyboardTypeNumberPad;
    [verificationText becomeFirstResponder];
    self.verificationText = verificationText;
    
}

/**
 *  设置验证按钮
 */
- (void)setupVerificationButton
{
    BlueButtonView *getVerificationCodeBtn = [[BlueButtonView alloc] initWithBtnTitle:@"验证"];
    getVerificationCodeBtn.delegate = self;
    CGFloat getVerificationX = 0;
    CGFloat getVerificationY = CGRectGetMaxY(self.verificationText.frame) + 35;
    CGFloat getVerificationW = WIDTH;
    CGFloat getVerificationH = 46.0;
    getVerificationCodeBtn.frame = CGRectMake(getVerificationX, getVerificationY, getVerificationW, getVerificationH);
    [self.view addSubview:getVerificationCodeBtn];
    self.getVerificationCodeBtn = getVerificationCodeBtn;
}

/**
 *  按钮的代理方法
 */
- (void)btnClick:(id)view btn:(UIButton *)btn
{
    // 检测验证码是否正确
    [self detectionVerificationCode];
    
}

/**
 *  检测验证码是否正确
 */
- (void)detectionVerificationCode
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.phoneNumber, self.verificationText.text, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.phoneNumber, @"mobile",
                                 self.verificationText.text, @"verify",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    NSString *netStr = @"?anu=api/1/sms/verify_is_right";

    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"success: %@", responseObject);
        
        ResetPayPaswdViewController *resetPayPass = [[ResetPayPaswdViewController alloc] init];
        resetPayPass.token = self.token;
        resetPayPass.phoneNumber = self.phoneNumber;
        [self.navigationController pushViewController:resetPayPass animated:YES];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", responseObject);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
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
