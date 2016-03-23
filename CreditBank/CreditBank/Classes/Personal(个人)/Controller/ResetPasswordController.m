//
//  ResetPasswordController.m
//  CreditBank
//
//  Created by Eric on 15/4/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ResetPasswordController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingItem.h"
#import "BlueButtonView.h"


@interface ResetPasswordController () <BlueButtonViewDelegate>

@property(nonatomic, weak) UITextField *phoneTextField;
@property(nonatomic, weak) UITextField *passwdTextField;
@property(nonatomic, weak) UITextField *verificationCodeTextField;
@property(nonatomic, weak) UILabel *timeLabel;



@end

@implementation ResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFALT_BG;
    
    
}

#pragma mark -- TableView Mehod
- (void)setUpData {
    [self setUpGroup];
}


- (void)setUpGroup {
    settingGroup *group = [[settingGroup alloc] init];
    
    // 手机号码
    SettingItem *phoneItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"电话号码";
    phoneTextField.text = self.phoneNumber;
    CGFloat PasswdTextFieldX = 20;
    CGFloat PasswdTextFieldY = 0;
    CGFloat PasswdTextFieldH = 44;
    CGFloat PasswdTextFieldW = self.view.frame.size.width;
    phoneTextField.frame = CGRectMake(PasswdTextFieldX, PasswdTextFieldY, PasswdTextFieldW, PasswdTextFieldH);
    
    self.phoneTextField = phoneTextField;
    phoneItem.customView = self.phoneTextField;
    
    //剩余时间
    CGFloat timeLabelW = 135;
    CGFloat timeLabelX = WIDTH - timeLabelW - 11;
    CGFloat timeLabelY = 0;
    CGFloat timeLabelH = 15;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.center = CGPointMake(timeLabel.center.x, phoneTextField.center.y);
    [phoneTextField addSubview:timeLabel];
    timeLabel.textColor = HDColor(161, 203, 73);
    self.timeLabel = timeLabel;
    [self setTimeOut:60];
    
    
    // 验证码
    SettingItem *verificationCode = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.placeholder = @"输入6位短信验证码";
    
    verificationCodeTextField.frame = CGRectMake(PasswdTextFieldX, PasswdTextFieldY, PasswdTextFieldW, PasswdTextFieldH);
    self.verificationCodeTextField  = verificationCodeTextField;
    [self.verificationCodeTextField becomeFirstResponder];
    verificationCode.customView = self.verificationCodeTextField;
    
    // 密码
    SettingItem *makeSurePasswordItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *passwdTextField = [[UITextField alloc] init];
    passwdTextField.placeholder = @"设置大于6位的登录密码";
    passwdTextField.secureTextEntry = YES;
    passwdTextField.frame = CGRectMake(PasswdTextFieldX, PasswdTextFieldY, PasswdTextFieldW, PasswdTextFieldH);
    self.passwdTextField = passwdTextField;
    makeSurePasswordItem.customView = self.passwdTextField;
    
    
    group.items = @[phoneItem, verificationCode, makeSurePasswordItem];
    [self.data addObject:group];
    
    
    // 登录按钮
    BlueButtonView *loginBtn = [[BlueButtonView alloc] initWithBtnTitle:@"提交"];
    loginBtn.delegate = self;
    
    CGFloat loginBtnY = 250;
    CGFloat loginBtnW = WIDTH;
    CGFloat loginBtnH = 48;
    CGFloat loginBtnX = 0;
    
    loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    self.tableView.tableFooterView = loginBtn;
    
}

- (void)btnClick:(id)view btn:(UIButton *)btn
{
    [self postLoginInformation];
}

/**
 *  提交登陆信息
 */
- (void)postLoginInformation
{
 
    if ([self.title isEqualToString:Registered]) {
        
        ANLog(@"注册提交  (也就是要登陆啦) (功能已实现)");
        [self postRestPassWordAndpostRegistInfomation:@"?anu=api/1/user/dispose_register" connect:nil];
        
    } else if ([self.title isEqualToString:ResetaYourPassword]) {
        
        ANLog(@"重置密码 提交 (不可以登陆啦) (功能已实现)");
        [self postRestPassWordAndpostRegistInfomation:@"?anu=api/1/user/reset_password" connect:nil];
        
    } else if ([self.title isEqualToString:SetThePassword]) {
        
        ANLog(@"快捷登陆里面的设置登陆密码 提交 (也可以登陆啦) (功能已实现)");
        [self postRestPassWordAndpostRegistInfomation:@"?anu=api/1/user/dispose_register" connect:self.connectId];
    }
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

- (void)setTimeOut:(int)longTime
{
    __block int timeout = longTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            //dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timeLabel.text = @"验证码已发送 (0)";
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"验证码已发送 (%d)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timeLabel.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/**
 *  提交重置密码信息 && 提交注册信息 && 提交注册绑定手机号信息
 */
- (void)postRestPassWordAndpostRegistInfomation:(NSString *)netString connect:(NSString *)conntect
{
    NSString *phoneNumber = self.phoneTextField.text;
    NSString *password = self.passwdTextField.text;
    NSString *verificatCode = self.verificationCodeTextField.text;
    NSString *time = [NSDate getTime];

    NSArray *arr = @[phoneNumber, password, verificatCode, time];
    NSString *md5 = [Common paramsSign:arr];

    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 phoneNumber, @"mobile",
                                 password, @"password",
                                 verificatCode, @"code",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id",
                                 conntect, @"connect_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netString params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ANLog(@"++++suresponseObjectccess: %@", responseObject);
        if ([Common isKeyDictionary:@"token" dict:responseObject]) {
            if (![responseObject[@"token"] isEqualToString:@""]) {
                [Common userLoginSaveInfo:responseObject[@"token"] remeberMe:responseObject[@"remember_me"]];
            }
        }
    
        // 注册完要去哪？
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
}

@end
