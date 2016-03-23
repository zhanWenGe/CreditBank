//
//  Push.h
//  CreditBank
//
//  Created by Eric on 15/4/10.
//  Copyright (c) 2015年 Eric. All rights reserved.
//  推送事件的封装

#import <Foundation/Foundation.h>
@class UILocalNotification;
@class UIApplication;
@class UIViewController;
@class UITabBarController;
@class PushM;

@interface Push : NSObject
@property(nonatomic, weak) UITabBarController *tabBarController;


/**
 *  JPush 注册通知
 *
 *  @param launchOptions NSDictionary
 */
+ (void)registationAPNSNotification:(NSDictionary *)launchOptions;

/**
 *  上报 deviceToken
 *
 *  @param deviceToken 
 */
+ (void)getDeveToken:(NSData *) deviceToken;

/**
 *  处理收到的推送消息
 */
- (void)apnsNotificationMessage:(NSDictionary *) userInfo callStatus:(BOOL) status;
/**
 *  注册本地通知
 *
 *  @param notification notification description
 */
+ (void)showLocalNotificationAtFront:(UILocalNotification *) notification;

/**
 *  当有未读通知，拉取服务器未读通知
 *
 *  @param notification notification description
 */
+ (void)getServerNotificationMessage:(UIApplication *)application;

+ (NSString *) GetRegistrationID;
@end
