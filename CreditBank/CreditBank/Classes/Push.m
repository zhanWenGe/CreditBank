//
//  Push.m
//  CreditBank
//  通知类
//  Created by Eric on 15/4/10.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

// 是否已经向服务器推送 JPush ID
#define SAVEREGID @"saveRecordRegId"

#import "Push.h"
#import "APService.h"
#import "NSDictionary+Expand.h"
#import "AppDelegate.h"
#import "PrefixHeader.pch"
#import "PushM.h"
#import "LogoutHandler.h"
#import "ShopIndexViewController.h"
#import "NavigationController.h"

// test 接口  http://credit_bank.alltosun.net/api/1/test/push/send&res_name=news&res_id=13&link=http://www.baidu.com

@interface Push()<UIAlertViewDelegate>
@property(nonatomic, strong) PushM *pushM;
@property(nonatomic, weak) UIAlertView *alertView;
@end

@implementation Push

- (instancetype) init {
    if (self = [super init]) {
        [self initJPush];
    }
    
    return self;
}

/**
 *  获取JPush RegistrationID
 *
 *  @return <#return value description#>
 */
+ (NSString *) GetRegistrationID {
    return [APService registrationID];
}


#pragma mark -- APSN通知方法

+ (void)registationAPNSNotification:(NSDictionary *)launchOptions {
    
    // 关闭log
    [APService setLogOFF];
    
    // [APService setDebugMode];
    
    // 注册极光推送通知
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    
    // 初始化
    [APService setupWithOption:launchOptions];
    
    // 上报 JPush ID 暂时不用
    [self uploadRegistrationID];
}

/**
 *  向服务器传递 JPush ID
 *  JPush ID 只上传一次就够了,上报有哪些应用安装了推送。拉取推送时候用到。
 *  本地缓存开发
 */
+ (void)uploadRegistrationID {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SAVEREGID]) return;
    
    // 请求的URL
    NSString *url = @"?anu=api/1/push/record_reg_id";
    
    // 请求参数
    NSString *regId = [self GetRegistrationID];
    
    NSString *time  = [NSDate getTime];
    NSString *appId = PLATFORMID;
    
    // 加密串
    NSString *sign = [Common paramsSign:@[regId, time]];
    
    // 构造参数
    NSDictionary *parameters = @{@"app_id" : appId,
                                 @"reg_id" : regId,
                                 @"time"   : time,
                                 @"sign"   : sign};
    
    AnRequest *request = [[AnRequest alloc] init];
    
    [request post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"%@", responseObject);
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"%@", responseObject);
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"%@", error);
    }];
    
    // 保存已注册的状态
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:SAVEREGID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  上传 JPushServer deviceToken
 *  @param deviceToken <#deviceToken description#>
 */
+ (void)getDeveToken:(NSData *) deviceToken {
    [APService registerDeviceToken:deviceToken];
}

/**
 *  通知消息回调
 *
 *  @param userInfo 消息体
 *  @param status 调用状态 YES = didFinishLaunchingWithOptions   NO =  didReceiveRemoteNotification
 */
- (void)apnsNotificationMessage:(NSDictionary *) userInfo callStatus:(BOOL) status  {
    
    [APService handleRemoteNotification:userInfo];
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    
    // 推送显示的内容
    NSString *content = [aps valueForKey:@"alert"];
    
//    // badge数量
//    NSInteger badge   = [[aps valueForKey:@"badge"] integerValue];
//    // 播放的声音
//    NSString *sound   = [aps valueForKey:@"sound"];

    
    PushM *pushM = [PushM objectWithKeyValues:userInfo];
    self.pushM = pushM;
    
    // 强制用户下线，有其他用户登录
    if ([pushM.res_name isEqualToString:@"single_login"]) {
        [self enforceLogout:content];
    } else if ([pushM.res_name isEqualToString:@"webview"]) {
        
        // 推送新闻消息
        if (pushM.link.length) {
            
            UIApplication *application = [UIApplication sharedApplication];
            // 当前出于活动前台,弹出提示框
            if (application.applicationState == UIApplicationStateActive && !status) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新的推送消息" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                self.alertView = alert;
                [alert show];
                
            } else if(application.applicationState == UIApplicationStateInactive) {
                // 应用程序在后台
                [self postPushNotificationCenter];
            } else if(application.applicationState == UIApplicationStateActive && status) {
                // 应用程序已经关闭，点通知栏启动
                [self postPushNotificationCenter];
            }
        }
    }
}


/**
 *  投递通知推送消息
 */
- (void)postPushNotificationCenter {
    NSDictionary *params = [NSDictionary dictionaryWithObject:self.pushM.link forKey:@"link"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotificationCenter" object:nil userInfo:params];
}

/**
 *  通知消息推送的具体实现
 */
- (void)apnsNotificationMessage:(NSNotification *) notification{
    
    NSString *link = [[notification userInfo] valueForKey:@"link"];
    ShopIndexViewController *IndexVc = [[ShopIndexViewController alloc] init];
    IndexVc.strUrl = link;
    
    NavigationController *navController = (NavigationController *)self.tabBarController.selectedViewController;
    [navController pushViewController:IndexVc animated:YES];
}


// 强制退出登录，下线
- (void)enforceLogout:(NSString *)content {
    
    // 清空本地token
    [LogoutHandler logoutHandlerFromControllor];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录提醒" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self postPushNotificationCenter];
    }
}

/**
 *  当应用切换到后台并有通知到来，用户并未点击通知栏，直接点击带未读数字的图标启动
 *  这个时候程序不能收到通知的信息，必须得去服务器拉取未读通知
 *  @param application <#application description#>
 */
+ (void)getServerNotificationMessage:(UIApplication *)application {
    
    // 有未读通知
    if (application.applicationIconBadgeNumber > 0) {
//        
//        // 拉取服务器未读通知
//        NSString *url = @"?anu=api/1/push/get_newest_unread_info";
//        
//        // 请求参数
//        NSString *regId = [self GetRegistrationID];
//        ANLog(@"getServerNotificationMessage:%@", regId);
//
//        NSString *time  = [NSDate getTime];
//        NSString *appId = PLATFORMID;
//        
//        // 加密串
//        NSString *sign = [Common paramsSign:@[regId, time]];
//        
//        // 构造参数
//        NSDictionary *parameters = @{@"app_id" : appId,
//                                     @"reg_id" : regId,
//                                     @"time"   : time,
//                                     @"sign"   : sign};
//        
//        AnRequest *request = [[AnRequest alloc] init];
//        
//        [request post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//            ANLog(@"%@", responseObject);
//            
//            SelectPushController *selectPushVc = [[SelectPushController alloc] init];
//            selectPushVc.pushM = [PushM objectWithKeyValues:responseObject];
//
//            ANLog(@"%@", selectPushVc.pushM.res_name);
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"消息拉取" message:selectPushVc.pushM.content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alertView show];
//            
//        } errorBlock:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//            
//        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        }];
    }
    
}

#pragma mark -- 本地通知方法

/**
 * 本地推送在前台推送。默认App在前台运行时不会进行弹窗，在程序接收通知调用此接口可实现指定的推送弹窗。
 * @param notification 本地推送对象
 * @param notificationKey 需要前台显示的本地推送通知的标示符
 */
+ (void) showLocalNotificationAtFront:(UILocalNotification *) notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

/**
 *  初始化本地通知
 */
- (void) initJPush {
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
    
    NSString *appKey = [self getAppKey];
    if (appKey) {
        // NSLog(@"%@", appKey);
    }
    
    // 注册处理消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apnsNotificationMessage:) name:@"PushNotificationCenter" object:nil];
}

/**
 *  获取appKey
 *
 *  @return <#return value description#>
 */
- (NSString *)getAppKey {
    NSURL *urlPushConfig = [[[NSBundle mainBundle] URLForResource:@"PushConfig"
                                                    withExtension:@"plist"] copy];
    NSDictionary *dictPushConfig =
    [NSDictionary dictionaryWithContentsOfURL:urlPushConfig];
    
    if (!dictPushConfig) {
        return nil;
    }
    
    // appKey
    NSString *strApplicationKey = [dictPushConfig valueForKey:(@"APP_KEY")];
    if (!strApplicationKey) {
        return nil;
    }
    
    return [strApplicationKey lowercaseString];
}

- (void)dealloc {
    
    [self unObserveAllNotifications];
    
    // 删除注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 移除注册通知
- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}

// 极光推送，连接成功
- (void)networkDidSetup:(NSNotification *)notification {
    // NSLog(@"已连接");
}

// 极光推送，连接关闭
- (void)networkDidClose:(NSNotification *)notification {
    // NSLog(@"未连接");
}

// 极光推送，注册成功
- (void)networkDidRegister:(NSNotification *)notification {
    // NSLog(@"已注册");
}

// 极光推送，登录成功
- (void)networkDidLogin:(NSNotification *)notification {
    // NSLog(@"已登录");
    if ([APService registrationID]) {
       //   NSLog(@"get RegistrationID%@", [APService registrationID]);
    }
}

- (void)serviceError:(NSNotification *)notification {
    
}
/**
 *  极光推送的自定义消息，自定义消息不推荐使用。暂未处理
 *
 *  @param notification notification description
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentContent = [NSString
                                stringWithFormat:
                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterMediumStyle],
                                title, content, [extra toNSString]];
    
    
    ANLog(@"currentContent :%@", currentContent);
}
@end
