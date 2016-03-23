//
//  FeedbackViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/27.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#define UITEXTVIEW_PLACEHOLDER @"请填写您的问题和建议"

#import "FeedbackViewController.h"
#import "SettingArrowItem.h"
#import "settingGroup.h"
#import "BlueButtonView.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+MJ.h"

@interface FeedbackViewController ()<BlueButtonViewDelegate, UITextViewDelegate>

@property(nonatomic, weak) UILabel *promptLabel;
@property(nonatomic, weak) UILabel *placeholderLabel;
@property(nonatomic, weak) UITextView *textView;
@property(nonatomic, weak) BlueButtonView *saveBtn;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控件
    [self setUpSubviews];
    
}


- (void)setUpSubviews {
    
    // 容器
    UIView *boxView = [[UIView alloc] init];
    boxView.frame   = CGRectMake(0, 0, self.view.frame.size.width, 378);
    
    // 1、标题
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.font = [UIFont systemFontOfSize:12.0];
    promptLabel.text = @"问题和建议";
    
    CGFloat promptLabelX = 15;
    CGFloat promptLabelY = 15;
    CGFloat promptLabelW = 80;
    CGFloat promptLabelH = 24;

    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    [boxView addSubview:promptLabel];
    
    // 2、输入框
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate    = self;
    
    CGFloat textViewX = promptLabelX;
    CGFloat textViewY = CGRectGetMaxY(promptLabel.frame) + 5;
    CGFloat textViewW = self.view.frame.size.width - (textViewX * 2);
    CGFloat textViewH = 120;
    
    textView.frame    = CGRectMake(textViewX, textViewY, textViewW, textViewH);
    [boxView addSubview:textView];
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text     = UITEXTVIEW_PLACEHOLDER;
    
    placeholderLabel.font = [UIFont systemFontOfSize:12.0];
    placeholderLabel.textColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    
    placeholderLabel.frame = CGRectMake(5, 0, textViewW, 24);
    self.placeholderLabel  = placeholderLabel;
    
    [textView addSubview:self.placeholderLabel];
    self.textView = textView;
    
    // 3、按钮
    BlueButtonView *saveBtn = [[BlueButtonView alloc] initWithBtnTitle:@"提交"];
    saveBtn.frame = CGRectMake(0, CGRectGetMaxY(textView.frame) + 10, self.view.frame.size.width, 47);
    saveBtn.delegate = self;
    [boxView addSubview:saveBtn];
    
    self.tableView.tableHeaderView = boxView;
    
}

#pragma mark UITextView Deletage
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.text = @"";
}

#pragma mark 
- (void)btnClick:(id)view btn:(UIButton *)btn {
    if (!self.textView.text.length) {
        return;
    }
    
    NSString *token = [Common token];
    NSString *time = [NSDate getTime];
    NSString *appId = PLATFORMID;
    NSString *content = self.textView.text;
    
    NSString *sign = [Common paramsSign:@[token, content ,time]];
    
    NSDictionary *parameters = @{@"app_id"  : appId,
                                 @"token"   : token,
                                 @"content" : content,
                                 @"time"   : time,
                                 @"sign"   : sign};
    
    NSString *url = @"?anu=api/1/suggestion/save";
    
    AnRequest *anRequest = [[AnRequest alloc] init];
    
    
    [anRequest post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"感谢您的意见!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
