//
//  RegisterAgreementController.m
//  CreditBank
//
//  Created by Eric on 15/4/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "RegisterAgreementController.h"
#import "BlueButtonView.h"
#import "PrefixHeader.pch"
#import "ForgotPasswordViewController.h"

@interface RegisterAgreementController ()<BlueButtonViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, copy) NSString *webUrl;

@end

@implementation RegisterAgreementController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.webUrl = [NSString stringWithFormat:@"%@?anu=/user/privacy",HOSTURL];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFALT_BG;
    
    // 设置webView
    [self setupWebView];
    
    // 设置同意按钮
    [self setupAgreeButton];
    
    
}

/**
 *  设置webView
 */
- (void)setupWebView
{
    CGFloat webViewX = 0;
    CGFloat webViewY = 0;
    CGFloat webViewW = WIDTH;
    CGFloat webViewH = HIGH - 90;
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH)];
    webView.backgroundColor = DEFALT_BG;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [webView loadRequest:request];
    self.webView = webView;
}

/**
 *  设置同意按钮
 */
- (void)setupAgreeButton
{
    // 同意按钮
    BlueButtonView *agreeBtn = [[BlueButtonView alloc] initWithBtnTitle:@"同意"];
    agreeBtn.delegate = self;
    
    CGFloat agreeBtnY = HIGH - 75;
    CGFloat agreeBtnW = WIDTH;
    CGFloat agreeBtnH = 48;
    CGFloat agreeBtnX = 0;
    
    agreeBtn.frame = CGRectMake(agreeBtnX, agreeBtnY, agreeBtnW, agreeBtnH);
    [self.view addSubview:agreeBtn];
}
- (void)btnClick:(id)view btn:(UIButton *)btn
{
    ForgotPasswordViewController *forgotPasswordVC = [[ForgotPasswordViewController alloc] init];
    forgotPasswordVC.title = Registered;
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];
}

- (void)setWebUrl:(NSString *)webUrl
{
    if (_webUrl != webUrl) {
        _webUrl = webUrl;
        NSURL *url = [NSURL URLWithString:self.webUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
