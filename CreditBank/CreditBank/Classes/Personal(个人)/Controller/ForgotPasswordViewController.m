//
//  ForgotPasswordViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "BlueButtonView.h"
#import "PrefixHeader.pch"
#import "ResetPasswordController.h"


#define TYPEREGISTER @"register"
#define TYPEFORGOTPASSWORD @"reset"

@interface ForgotPasswordViewController ()<BlueButtonViewDelegate>

@property (nonatomic, weak) BlueButtonView *getVerificationCodeBtn;
@property (nonatomic, weak) UITextField *phoneNumText;


@end

@implementation ForgotPasswordViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFALT_BG;
    
    
    // 1.设置电话号码输入框
    [self setupPhoneNumberText];
    
    // 2.设置按钮
    [self setupVerificationButton];
    
}

/**
 *  设置电话号码输入框
 */
- (void)setupPhoneNumberText
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 85, WIDTH + 1, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CGFloat phoneNumTextX = 20;
    CGFloat phoneNumTextY = 60;
    CGFloat phoneNumTextW = WIDTH - 20;
    CGFloat phoneNumTextH = 20;
    UITextField *phoneNumText = [[UITextField alloc] init];
    [self.view addSubview:phoneNumText];
    
    view.layer.borderColor = [HDColor(214, 214, 214) CGColor];
    view.layer.borderWidth = 0.5f;
    
    phoneNumText.frame = CGRectMake(phoneNumTextX, phoneNumTextY, phoneNumTextW, phoneNumTextH);
    phoneNumText.center = CGPointMake(phoneNumText.center.x, view.center.y);
    
    phoneNumText.placeholder = @"请输入手机号码";
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumText = phoneNumText;

}

/**
 *  设置获取验证码的按钮
 */
- (void)setupVerificationButton
{
    BlueButtonView *getVerificationCodeBtn = [[BlueButtonView alloc] initWithBtnTitle:@"获取验证码"];
    getVerificationCodeBtn.delegate = self;
    CGFloat getVerificationX = 0;
    CGFloat getVerificationY = CGRectGetMaxY(self.phoneNumText.frame) + 35;
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
    self.getVerificationCodeBtn.userInteractionEnabled = NO;
    if (self.phoneNumText.text.length == 11) {
        
        // 获取短信验证码
        if ([self.title isEqualToString:ThroughTheMobilePhoneToResetThePassword]) {
            [self getVerificationCode:TYPEFORGOTPASSWORD nextControllerTitle:ResetaYourPassword];
//            ANLog(@"通过手机重置密码");
        } else if ([self.title isEqualToString:Registered] ){
            [self getVerificationCode:TYPEREGISTER nextControllerTitle:Registered];
//            ANLog(@"注册");
        } else if ([self.title isEqualToString:BindingMobilePhoneNumber]){
            [self getVerificationCode:TYPEREGISTER nextControllerTitle:SetThePassword];
//            ANLog(@"绑定手机号 也就是 注册");
        }
    }
    else {
        self.getVerificationCodeBtn.userInteractionEnabled = YES;
        [self setAlertViewWithMessage:@"请输入正确的手机号码"];
    }
    
}

/**
 *  获取验证码
 */
- (void)getVerificationCode:(NSString *)type nextControllerTitle:(NSString *)title
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.phoneNumText.text, type, time];
    NSString *md5 = [Common paramsSign:arr];
   
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.phoneNumText.text, @"mobile",
                                 type, @"type",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    NSString *netStr = @"?anu=api/1/sms/get_verify_code";
    ANLog(@"dictionary :%@", dictionary);
    ANLog(@"netstr: %@", netStr);
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"success: %@", responseObject);
    
        ResetPasswordController *resetPass = [[ResetPasswordController alloc] init];
        resetPass.connectId = self.connectId;
        resetPass.title = title;
        resetPass.phoneNumber = self.phoneNumText.text;
        [self.navigationController pushViewController:resetPass animated:YES];
        self.getVerificationCodeBtn.userInteractionEnabled = YES;
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", responseObject);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
        self.getVerificationCodeBtn.userInteractionEnabled = YES;
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
