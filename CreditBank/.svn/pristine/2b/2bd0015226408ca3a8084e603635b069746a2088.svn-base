//
//  JavaScriptWebViewController.m
//  CreditBank
//
//  Created by 王德康 on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "JavaScriptWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+MJ.h"
#import "ShopIndexViewController.h"
#import "ErrorView.h"
#import "MJRefresh.h"

#import "HaveOrNotNet.h"


@interface JavaScriptWebViewController ()<ErrorViewDelegate>
/**
 *  JavaScript与OC交互库
 */
@property(nonatomic, strong) WebViewJavascriptBridge *bridge;
@property(nonatomic, weak) UIWebView *webView;
/**
 *  网页加载的进度条
 */
@property(nonatomic, weak) UIProgressView *progressView;
/**
 *  进度条变量
 */
@property(nonatomic, assign) CGFloat  floatProgess;
/**
 *  时间控件
 */
@property(nonatomic, strong) NSTimer  *timer;
/**
 *  错误页面
 */
@property(nonatomic, weak) ErrorView  *errView;
/**
 *  是否新窗口打开
 */
@property(nonatomic, assign,getter=isOpenTarget) BOOL openTarget;


@end

@implementation JavaScriptWebViewController

/**
 *  错误页面懒加载
 *
 */
- (ErrorView *)errView {
    if (_errView == nil) {
        
        ErrorView *errView = [ErrorView errWithView];
        errView.delegate   = self;
        
        errView.frame = self.view.bounds;
        _errView = errView;
    }
    
    return _errView;
}

#pragma mark -- ErrorViewDelegate
/**
 *  重新加载按钮
 */
- (void)errorView:(ErrorView *)view reloadBtn:(UIButton *)btn {
    [self loadRequest];
    [self.errView removeFromSuperview];
}

- (void)dealloc {
    ANLog(@"%@--dealloc", [self class]);
    self.webView      = nil;
    self.bridge       = nil;
    self.progressView = nil;
    self.timer        = nil;
    self.errView      = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 新窗口打开
    self.openTarget = YES;
    
    // 初始化子控件
    [self setUp];
    
    self.url = @"/news/detail?id=287";
    
    // 下拉刷新
    __weak typeof (self) weakSelf = self;
    [self.webView.scrollView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf progressStart];
        [weakSelf.webView reload];
    }];
}

/**
 *  初始化子控件
 */
-(void)setUp {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    webView.backgroundColor  = [UIColor whiteColor];
    webView.scalesPageToFit  = YES ;
    self.webView.delegate   = self;

    
    [self.view addSubview:webView];
    self.webView = webView;

    UIProgressView *progessView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    // 进度条默认高度就是 9，不能更改
    progessView.frame  = CGRectMake(0, 64, self.view.frame.size.width, 9);
    
    // 通过缩放来修改进度条的高度
//    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//    progessView.transform = transform;
    
    // 黑色
    progessView.progressTintColor = [UIColor colorWithRed:53/255.0 green:152/255.0 blue:219/255.0 alpha:1.0];
    
    [self.view addSubview:progessView];
    self.progressView = progessView;
}


/**
 *  加载网页
 */
- (void)loadRequest {
    
    // 自动补全url
    NSURL *url = [Common autoCompleteURL:self.url];
    
    // 设置标题
    NSString *title = [Common getURLTitle:self.url];
    
    // UrlDecode解码
    self.title = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 设置cookie
    [Common setCookie:url];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [self.webView loadRequest:request];
    
    [self progressStart];
}


/**
 *  进度条开始
 */
- (void)progressStart {
    
    // 设置进度条定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressChanged:) userInfo:nil repeats:YES];
    
    self.timer = timer;
    
    // 显示进度条
    self.progressView.hidden = NO;
}

/**
 *  设置进度条的值
 *
 *  @param timer <#timer description#>
 */
- (void)progressChanged:(NSTimer *)timer {
    if (self.floatProgess >= 1.0) {
        
        // 关闭定时器
        [timer invalidate];
        self.timer = nil;
        
        // 隐藏进度条
        self.progressView.hidden = YES;
        // 结束刷新
        [self.webView.scrollView.header endRefreshing];
    }
    
    self.floatProgess += 0.01;
    [self.progressView setProgress:self.floatProgess animated:YES];
}

/**
 *  进度条结束
 */
- (void)progressEnd {
    [self.timer invalidate];
    self.timer = nil;
    
    self.floatProgess = 1.0;
    [self.progressView setProgress:self.floatProgess animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressView.hidden = YES;
        // 结束刷新
        [self.webView.scrollView.header endRefreshing];
    });
    
}

/**
 *  显示错误页面
 */
- (void)loadErrorView {
    [self.view addSubview:self.errView];
}

#pragma mark --- webview delegate

/**
 *  网页加载完毕
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    if (self.title.length == 0) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }

    [self progressEnd];
    
    [self.errView removeFromSuperview];

}

/**
 *  网页加载出现错误
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 断网
    ANLog(@"error_code:%@", error);
    
    NSArray *errorCodeArr = @[@"-1001", @"102", @"-1003", @"-1004", @"-1009"];
    if ([errorCodeArr containsObject:[NSString stringWithFormat:@"%ld", error.code]]) {
        
        // 进度条结束
        [self progressEnd];
        
        // 加载错误信息
        [self loadErrorView];
    }
}


/**
 *  当用户点击WebView中的连接时，增加一个控制器来显示子连接
 *
 *  @param webView        webView description
 *  @param request        <#request description#>
 *  @param navigationType navigationType description
 *
 *  @return <#return value description#>
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    // 用户点击连接
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        // 外链使用新窗口打开
        if (!self.isOpenTarget) return YES;
        
        NSURL *url = request.URL;
        NSString *strUrl = [NSString stringWithFormat:@"%@", [url absoluteString]];
        
        // 外链
        if ([strUrl rangeOfString:HOSTURL].length == 0) {
            self.openTarget = NO;
        }
        
        JavaScriptWebViewController *webViewVC = [[[self class] alloc] init];
        webViewVC.strUrl = strUrl;
        
        [self.navigationController pushViewController:webViewVC animated:YES];
        return NO;
    }
    
    return YES;
}

/**
 *  调用JS函数并传递参数
 *
 *  @param dic <#dic description#>
 */
- (void)callHandler:(NSString *)handlerName params:(NSDictionary *)dic {
    // OC调用JS的函数
    [_bridge callHandler:handlerName data:dic];
}

/**
 *  调用JS函数并传递参数,支持回调
 *
 *  @param dic <#dic description#>
 */
- (void)callHandler:(NSString *)handlerName params:(NSDictionary *)dic callBackHandler:(responseCallback)callback  {
    // OC调用JS的函数
    [_bridge callHandler:handlerName data:dic responseCallback:^(id responseData) {
        callback(responseData);
    }];
}

/**
 *  注册一个OC函数，开放给JS调用
 *  @param handlerName 函数名，唯一性
 *  @param callback    JS函数执行完的回调
 */
- (void)registerHandler:(NSString *)handlerName respconseCallBack:(responseCallback) callback  {

    // 注册一个函数，JS可以调用这个函数
    [self.bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取JS传递的变量对象
        callback(data);

    }];
}

/**
 *  所有的注册函数都必须写在这个方法中,留给父类重构
 */
- (void) registerHandlerAll {
}


//- (void) registerHandlerAll {
//    
//    [self registerHandler:@"testJavascriptHandler" respconseCallBack:^(NSDictionary * responseData) {
//        NSLog(@"testJavascriptHandler:%@", [responseData objectForKey:@"foo"]);
//    }];
//}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initJavaScriptCore];
}

// 注册JavaScriptCore核心变量
- (void)initJavaScriptCore {
    
    // 重用变量
    if (_bridge) { return; }
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        ANLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    
    [self registerHandlerAll];
    
    // 注册全局系统函数
    [self registerHandler:@"ShowLoading" respconseCallBack:^(NSDictionary * responseData) {
        [MBProgressHUD showMessage:@"正在加载"];
        // NSLog(@"testJavascriptHandler:%@", [responseData objectForKey:@"foo"]);
    }];
    
    [self registerHandler:@"HideLoading" respconseCallBack:^(NSDictionary * responseData) {
        // NSLog(@"testJavascriptHandler:%@", [responseData objectForKey:@"foo"]);
        [MBProgressHUD hideHUD];
    }];
    
    //    [self registerHandler:@"testJavascriptHandler" respconseCallBack:^(NSDictionary * responseData) {
    //        NSLog(@"testJavascriptHandler:%@", [responseData objectForKey:@"foo"]);
    //    }];
    
    //    // 向JS发送消息，并处理JS返回的消息,并处理回调
    //    [_bridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
    //        NSLog(@"objc got response! %@", responseData);
    //    }];
    //
    //    // 发送消息，不处理回调
    //    [_bridge send:@"A string sent from ObjC after Webview has loaded."];
    //
    //    // 发送对象,JS解析为JSON
    //    [self.bridge send:[NSDictionary dictionaryWithObject:@"Foo" forKey:@"Bar"]];
    //
    //
    //    // 注册一个函数，JS可以调用这个函数
    //    [_bridge registerHandler:@"testJavascriptHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
    //
    //        // 获取JS传递的变量对象
    //        NSLog(@"testObjcCallback called: %@", data);
    //
    //        // 回调通知JS，接收结果
    //        responseCallback(@"Response from testObjcCallback");
    //    }];
    //
    //    // OC调用JS的函数
    //    [_bridge callHandler:@"testJavascriptHandler"];
    //
    //
    //    //    // 传递参数
    //    [_bridge callHandler:@"testJavascriptHandler" data:[NSDictionary dictionaryWithObject:@"Foo" forKey:@"Bar"]];
    //
    //    // 支持回调通知
    //    [_bridge callHandler:@"testJavascriptHandler" data:nil responseCallback:^(id responseData) {
    //        // JS处理完的通知
    //        NSLog(@"%@", responseData);
    //    }];
    //    //

}

@end
