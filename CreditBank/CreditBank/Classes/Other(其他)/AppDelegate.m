//
//  AppDelegate.m
//  CreditBank
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

// ShardSDk App Key:6adf5d5ffcd8  App Secret:eb57c2462cf5faf21f83e18e21fdd328
// Parse  Application ID:dGRng53ZrxYjFYRY6pR7Y45KMxXmom7cOsfmIQaf    Client Key:d0yqN6yJvBbY7f97aNVqtlGy2K7v8bE2HgpI9Ekf
// QQ APP ID:101199524  APP KEY:4dfde2c69100dc19ca5990473d57d6dd
// sinaWeibo App Key:2521012166  AppSecret:7a40883d0e6290ca1a32ead6eca940a8

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "Push.h"
#import "SingleLogin.h"

//ShareSDK (新浪微博登陆)
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

#import "NewfeatureViewController.h"
#import "SDWebImageManager.h"
#import "ChooseControllerTool.h"


@interface AppDelegate ()
// 推送实例
@property(nonatomic, strong) Push *pushApns;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Push *pushApns = [[Push alloc] init];
    self.pushApns = pushApns;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [Push registationAPNSNotification:launchOptions];
    
    application.statusBarHidden = YES;

    // 加载shareSDK
    [self registerShareSdk];
    
    // 当前用户是否可以在当前设备登陆
    [SingleLogin checkSingleDeviceLogin];
    
    [self.window makeKeyAndVisible];
    
    // 新特性
    [ChooseControllerTool chooseRootController];
    
    // 延迟0.5秒，保证后面控制器加载完毕
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            [self.pushApns apnsNotificationMessage:userInfo callStatus:YES];
//
//            NSString *mes =  [NSString stringWithFormat:@"%@", userInfo];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息推送" message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil, nil];
//            [alert show];
        }
    });

    
    // 消除通知图标
    [application setApplicationIconBadgeNumber:0];
    
    return YES;
    
}
 
/**
 *  ShareSDK 初始化
 */
- (void)registerShareSdk {
    
    [ShareSDK registerApp:@"7563e3fdb3e5"];
    
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"4030265795"
                               appSecret:@"71248d335240ef3e054ff7215e364aa4"
                             redirectUri:@"http://www.alltosun.com"
                             weiboSDKCls:[WeiboSDK class]];
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"1104588619"
                           appSecret:@"3Mt8rzhEidDBl5bb"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
//        [ShareSDK connectWeChatWithAppId:@"wx029d78e172c7fa90" wechatCls:[WXApi class]];// 这个方法在微信登陆的时候会报错(所以用下面方法)
    [ShareSDK connectWeChatWithAppId:@"wx029d78e172c7fa90"
                           appSecret:@"f910232d77088ec795980bf09c0970f2"
                           wechatCls:[WXApi class]];
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/

    // QQ好友分享
    [ShareSDK connectQQWithQZoneAppKey:@"1104588619"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [Parse setApplicationId:@"dGRng53ZrxYjFYRY6pR7Y45KMxXmom7cOsfmIQaf" clientKey:@"d0yqN6yJvBbY7f97aNVqtlGy2K7v8bE2HgpI9Ekf"];
}

/**
 *  获取注册设备的 Device Token
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [Push getDeveToken:deviceToken];
}

/**
 *  apple aps 推送通知回调函数
 *  apple 活动在前台 或 用户点击通知栏 系统自动调用通知
 *
 *  @param application       <#application description#>
 *  @param userInfo          <#userInfo description#>
 *  @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    [self.pushApns apnsNotificationMessage:userInfo callStatus:NO];
    completionHandler(UIBackgroundFetchResultNewData);
}

// 本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [Push showLocalNotificationAtFront:notification];
}

/**
 *  切换到后台
 *
 *  @param application <#application description#>
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

/**
 *  应用切换到前台
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 拉取服务器未读通知
    [Push getServerNotificationMessage:application];
    
    // 消除通知图标
    [application setApplicationIconBadgeNumber:0];
    
    // 当前用户是否可以在当前设备登陆
    [SingleLogin checkSingleDeviceLogin];
}

/**
 *  集成分享功能
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
