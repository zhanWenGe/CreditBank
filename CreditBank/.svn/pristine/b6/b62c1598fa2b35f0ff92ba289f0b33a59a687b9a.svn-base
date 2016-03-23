//
//  NickNameController.m
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NickNameController.h"
#import "PrefixHeader.pch"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"

@interface NickNameController ()
@property(nonatomic, weak) UITextField *nickTextField;
@end

@implementation NickNameController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DEFALT_BG;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickName:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.nickTextField];
}

/**
 *  保存按钮的状态
 */
- (void)changeText {
    // 昵称不相同，并且不为空
    self.navigationItem.rightBarButtonItem.enabled = !([self.nickName isEqualToString:self.nickTextField.text]) && self.nickTextField.text.length;
}

/**
 *  保存昵称
 *
 *  @param btn <#btn description#>
 */
- (void)saveNickName:(UIBarButtonItem *)btn {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.nickTextField.text forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.token, self.nickTextField.text, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                self.nickTextField.text, @"nick_name",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/user/save_nick_name";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
    
//        ANLog(@"保存昵称 : %@", responseObject);
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

- (void)dealloc {
    
    // 释放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidAppear:(BOOL)animated {
    [self.nickTextField becomeFirstResponder];
}

#pragma mark -- TableView Mehod
- (void)setUpData {
    [self setUpGroup1];
}


- (void)setUpGroup1 {
    settingGroup *group         = [[settingGroup alloc] init];
    SettingItem *nickName       = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *NickTextField  = [[UITextField alloc] init];
    CGFloat NickTextFieldX      = 20;
    CGFloat NickTextFieldY      = 0;
    CGFloat NickTextFieldH      = 44;
    CGFloat NickTextFieldW      = self.view.frame.size.width;
    
    NickTextField.frame = CGRectMake(NickTextFieldX, NickTextFieldY, NickTextFieldW, NickTextFieldH);
    NickTextField.text = self.nickName;
    
    self.NickTextField = NickTextField;
    nickName.customView  = self.nickTextField;
    
    
    group.items = @[nickName];
    [self.data addObject:group];
    
}
@end
