//
//  ShareSaveApi.m
//  CreditBank
//
//  Created by 王德康 on 15/5/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ShareSaveApi.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+MJ.h"
#import <ShareSDK/ShareSDK.h>
#import "ImpotSuccessController.h"

@implementation ShareSaveApi

+(void)shareContent:(NSString *)content defaultConent:(NSString *)defaultConent imageUrl:(NSString *)imageUrl title:(NSString *)title url:(NSString *)url desc:(NSString *)desc view:(UIView *)view shareSucc:(shareSuccess)success {
    
    //     [ShareSDK imageWithUrl:imageUrl]
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:defaultConent
                                                image:[ShareSDK imageWithData:data fileName:@"test.jpg" mimeType:@"image/jpeg"]
                                                title:title
                                                  url:url
                                          description:desc
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess){
                                    
                                    ANLog(@"type : %d", type);
                                    
                                    // 新浪微博
                                    if (type == ShareTypeSinaWeibo) {
                                        [ShareSaveApi saveUserShare:@"share_weibo" userId:nil];
                                        success(@"share_weibo");
                                        
                                    } else if(type == ShareTypeWeixiSession || type == ShareTypeWeixiTimeline) {
                                        // 朋友圈
                                        [ShareSaveApi saveUserShare:@"share_circle" userId:nil];
                                        success(@"share_circle");
                                    }
                                    
                                } else if (state == SSResponseStateFail){
                                    
                                    [MBProgressHUD showError:@"分享失败"];
                                    ANLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}


/**
 *  用户分享完成后，保存到每日分享
 *
 *  @param resName 分享的类型
 *  @param userId  用户ID
 */
+ (void)saveUserShare:(NSString *)resName userId:(NSString *)userId {
    
    AnRequest *request = [[AnRequest alloc] init];
    NSString  *url     = @"?anu=api/1/credit_earn/earn_credit";
    
    NSString *token = [Common token];
    if (!token) {
        [MBProgressHUD showSuccess:@"请登录后分享!"];
        return;
    }
    
    // 请求参数
    NSString *time    = [NSDate getTime];
    NSString *appId   = PLATFORMID;
    
    // 加密串
    NSString *sign = [Common paramsSign:@[token,resName, time]];
    
    // 构造参数
    NSDictionary *parameters = @{@"app_id"   : appId,
                                 @"token"    : token,
                                 @"res_name" : resName,
                                 @"time"     : time,
                                 @"sign"     : sign};
    
    [request post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"分享成功"];
        ANLog(@"分享成功:%@", responseObject);
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"每日任务保存失败"];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"每日任务保存失败"];
    }];
}


/**
 *  用户分享封装
 *
 *  @param responseData 分享的数据来源
 *  @param view  在哪个view弹出
 *  @param token 当前用户的token
 */
+ (void)shareContentFromDictionary:(NSDictionary *)responseData showView:(UIView *)view token:(NSString *)token shareSucc:(shareSuccess)success {
    if (![Common isKeyDictionary:@"defaultConent" dict:responseData]) {
        return;
    }
    
    if (![Common isKeyDictionary:@"desc" dict:responseData]) {
        return;
    }
    
    if (![Common isKeyDictionary:@"imageUrl" dict:responseData]) {
        return;
    }
    
    if (![Common isKeyDictionary:@"shareContent" dict:responseData]) {
        return;
    }
    
    if (![Common isKeyDictionary:@"title" dict:responseData]) {
        return;
    }
    
    if (![Common isKeyDictionary:@"url" dict:responseData]) {
        return;
    }
    
    [ShareSaveApi shareContent:responseData[@"shareContent"]
                 defaultConent:responseData[@"defaultConent"]
                      imageUrl:responseData[@"imageUrl"]
                         title:responseData[@"title"]
                           url:responseData[@"url"]
                          desc:responseData[@"desc"]
                          view:view
                        shareSucc:success];
}


//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
//
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
//                                       defaultContent:@"测试一下"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.mob.com"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    //创建弹出菜单容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
//
//    //弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//
//                                if (state == SSResponseStateSuccess){
//
//                                    // 新浪微博
//                                    if (type == ShareTypeSinaWeibo) {
//                                        [ShareSaveApi saveUserShare:@"share_weibo" userId:userId];
//                                    } else if(type == ShareTypeWeixiTimeline) {
//                                        // 朋友圈
//                                        [ShareSaveApi saveUserShare:@"share_circle" userId:userId];
//                                    }
//                                }
//                                else if (state == SSResponseStateFail){
//
//                                    [MBProgressHUD showError:@"分享失败"];
//                                    ANLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
//                                }
//                            }];
@end
