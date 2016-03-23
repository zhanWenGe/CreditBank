//
//  BaseWebViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/28.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseWebViewController.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+MJ.h"



@interface BaseWebViewController ()<UIWebViewDelegate>
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DEFALT_BG;
    self.url = @"/news/detail?id=287";


}


- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

/**
 *  加载网页
 */
- (void)loadRequest {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&src=iOS", HOSTURL, self.url]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate   = self;
    [webView loadRequest:request];
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    
}


#pragma mark --- webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}


@end
