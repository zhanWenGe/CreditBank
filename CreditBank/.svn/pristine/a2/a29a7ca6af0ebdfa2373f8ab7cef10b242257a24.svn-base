//
//  JavaScriptWebViewController.h
//  CreditBank
//
//  Created by 王德康 on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
// webview 与 js交互中 回调通知
typedef void (^responseCallback)(id responseData);

@interface JavaScriptWebViewController : UIViewController <UIWebViewDelegate>
/**
 *  通过其他控制传递的URL
 */
@property(nonatomic, strong) NSString *strUrl;
/**
 *  加载网络请求的短地址
 */
@property(nonatomic, copy) NSString *url;
/**
 *  加载网络请求
 */
- (void)loadRequest;

- (void)registerHandler:(NSString *)handlerName respconseCallBack:(responseCallback) callback;
- (void) registerHandlerAll;
/**
 *  调用JS函数
 *
 *  @param handlerName 函数名
 *  @param dic         传递的参数
 */
- (void)callHandler:(NSString *)handlerName params:(NSDictionary *)dic;
- (void)callHandler:(NSString *)handlerName params:(NSDictionary *)dic callBackHandler:(responseCallback)callback;
@end
