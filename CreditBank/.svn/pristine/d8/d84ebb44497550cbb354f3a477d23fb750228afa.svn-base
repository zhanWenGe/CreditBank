//
//  IndexViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "RegisterAgreementController.h"
#import "QuickLoginController.h"
#import "PrefixHeader.pch"
#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>

@interface IndexViewController ()<UIAlertViewDelegate>


/** QQ登录 */
- (IBAction)qqAction:(id)sender;
/** 微博登录 */
- (IBAction)weiboAction:(id)sender;
/** 急速注册 */
- (IBAction)rapidlyAction:(id)sender;
/** 登录方法 */
- (IBAction)loginAction:(id)sender;
/** 微博登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
/** QQ登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
/**  急速登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *rapidlyBtn;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/** QQ的access_token */
@property (nonatomic, copy) NSString *qqAccessToken;
/** QQ的openid,也就是userid */
@property (nonatomic, copy) NSString *qqOpenId;
/** QQ的昵称 */
@property (nonatomic, copy) NSString *qqNickName;
/** QQ的头像 */
@property (nonatomic, copy) NSString *qqAvatar;

/** 微博的access_token */
@property (nonatomic, copy) NSString *sinaAccessToken;
/** 微博的openid,也就是userid */
@property (nonatomic, copy) NSString *sinaOpenId;
/** 微博的昵称 */
@property (nonatomic, copy) NSString *sinaNickName;
/** 微博的头像 */
@property (nonatomic, copy) NSString *sinaAvatar;
/** 获取微博的过期时间 */
@property (nonatomic, retain) NSDate *sinaExpires;


@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Registered;
    
    // 子控制器 自定义leftBarButton
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBarButtonItem"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftBarButtonItemClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  QQ登录
 */
- (IBAction)qqAction:(id)sender {
    
    self.qqBtn.userInteractionEnabled = NO;
    // 获取用户信息
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   // 存储用户信息
                                   [self saveUserInfo:userInfo];
                                   // 显示提示框
//                                   [self alertView:@"欢迎回来" tag:1003];
                                   
                                   // 获取授权凭证
                                   id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:ShareTypeQQSpace];
                                   // 获取qq的openid
                                   self.qqOpenId = [credential uid];
                                   // 获取qq的accessTooken
                                   self.qqAccessToken = [credential token];
                                   // 获取qq昵称
                                   self.qqNickName = [userInfo nickname];
                                   // 获取qq头像
                                   self.qqAvatar = [userInfo profileImage];
                                   
                                   [self postQQLoginInformation];
                               } else {
                                   
                                   // 显示提示框
                                   [self alertView:@"您还没有安装QQ,请安装后登陆或者选择其他方式登陆" tag:0];
                               }
                           }];
}
/**
 *  微博登录
 */
- (IBAction)weiboAction:(id)sender {
    
    self.weiboBtn.userInteractionEnabled = NO;
    
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       // 获取授权凭证
                                       id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:ShareTypeSinaWeibo];
                                       // 获取微博的access_token
                                       self.sinaAccessToken = [credential token];
                                       // 获取微博的昵称
                                       self.sinaNickName = [userInfo nickname];
                                       // 获取微博的头像
                                       self.sinaAvatar = [userInfo profileImage];
                                       // 获取微博的user_id
                                       self.sinaOpenId = [userInfo uid];
                                       
                                       if ([objects count] == 0) {
                                           
                                           // 存储用户信息
                                           [self saveUserInfo:userInfo];
                                           // 显示提示框
//                                           [self alertView:@"欢迎注册" tag:1000];
                                           [self postSinaWeiboLoginInformation];
                                       } else {
                                           
                                           // 存储用户信息
                                           [self saveUserInfo:userInfo];
                                           // 显示提示框
//                                           [self alertView:@"欢迎回来" tag:1001];
                                           [self postSinaWeiboLoginInformation];
                                           
                                       }
                                       
                                       
                                   }];
                               } else {
                                   
                                   // 显示提示框
                                   [self alertView:@"授权失败, 请重新授权或者选择其他方式登陆" tag:0];
                                   
                                   ANLog(@"授权失败!error code == %ld, error code == %@", [error errorCode], [error errorDescription]);
                               }
                           }];
    
}

/**
 *  alertView的代理方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag == 1000 || alertView.tag == 1001) {
//        [self postSinaWeiboLoginInformation];
//    } else if (alertView.tag == 1003) {
//        [self postQQLoginInformation];
//    }
//    if (alertView.tag != 0) {
//    }
}

/**
 *  急速注册
 */
- (IBAction)rapidlyAction:(id)sender {
    RegisterAgreementController *registAgreement = [[RegisterAgreementController alloc] init];
    registAgreement.title = @"注册";
    [self.navigationController pushViewController:registAgreement animated:YES];
}
/**
 *  登录
 */
- (IBAction)loginAction:(id)sender {
    
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

/**
 *  存储用户信息
 */
- (void)saveUserInfo:(id)userInfo
{
    PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
    [newUser setObject:[userInfo uid] forKey:@"uid"];
    [newUser setObject:[userInfo nickname] forKey:@"name"];
    [newUser setObject:[userInfo profileImage] forKey:@"icon"];
    [newUser saveInBackground];
}

/**
 *  提示框显示
 *
 *  @param message 信息
 *  @param tag     tag值
 */
- (void)alertView:(NSString *)message tag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    alertView.tag = tag;
    [alertView show];
    self.weiboBtn.userInteractionEnabled = YES;
    self.qqBtn.userInteractionEnabled = YES;
}

/**
 *  提交用户QQ登陆信息
 */
- (void)postQQLoginInformation
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.qqAccessToken, self.qqOpenId, self.qqNickName, self.qqAvatar, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.qqAccessToken, @"access_token",
                                 self.qqOpenId, @"openid",
                                 self.qqNickName, @"nickname",
                                 self.qqAvatar, @"avatar",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    
    NSString *netStr = @"?anu=api/1/openapi/qq/save_qq_info";
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 未绑定站内用户
        if ([responseObject[@"user_id"] isEqualToString:@"0"]) {
            QuickLoginController *quickLogin = [[QuickLoginController alloc] init];
            quickLogin.contentId = responseObject[@"connect_id"];
            quickLogin.title = @"QQ登陆";
            [self.navigationController pushViewController:quickLogin animated:YES];
        } else {
            
            if ([Common isKeyDictionary:@"token" dict:responseObject]) {
                if ([Common isKeyDictionary:@"remember_me" dict:responseObject]) {
                    [Common userLoginSaveInfo:responseObject[@"token"] remeberMe:responseObject[@"remember_me"]];
                }
            }

             // 已绑定站内用户
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
}

/**
 *  提交用户新浪微博的登陆信息
 */
- (void)postSinaWeiboLoginInformation
{
    NSString *time = [NSDate getTime];
    ANLog(@"%@ ,%@, %@, %@", self.sinaAccessToken, self.sinaOpenId, self.sinaNickName, self.sinaAvatar);
    NSArray *arr = @[self.sinaAccessToken, self.sinaOpenId, self.sinaNickName, self.sinaAvatar, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.sinaAccessToken, @"access_token",
                                 self.sinaOpenId, @"connect_user_id",
                                 self.sinaNickName, @"nickname",
                                 self.sinaAvatar, @"avatar",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    
    NSString *netStr = @"?anu=api/1/openapi/sinaweibo/save_weibo_info";
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 未绑定
        if ([responseObject[@"user_id"] isEqual:@"0"]) {
            QuickLoginController *quickLogin = [[QuickLoginController alloc] init];
            quickLogin.contentId = responseObject[@"connect_id"];
            quickLogin.title = @"微博登陆";
            [self.navigationController pushViewController:quickLogin animated:YES];
        } else {
            
            if ([Common isKeyDictionary:@"token" dict:responseObject]) {
                if ([Common isKeyDictionary:@"remember_me" dict:responseObject]) {
                    [Common userLoginSaveInfo:responseObject[@"token"] remeberMe:responseObject[@"remember_me"]];
                }
            }

            // 已绑定
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
}

@end
