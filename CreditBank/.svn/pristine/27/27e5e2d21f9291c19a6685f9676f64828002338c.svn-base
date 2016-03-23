//
//  ShareSaveApi.h
//  CreditBank
//
//  Created by 王德康 on 15/5/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

typedef void(^shareSuccess)(id shareType);
#import <Foundation/Foundation.h>

@class UIView;
@interface ShareSaveApi : NSObject

@property (nonatomic, copy) void (^callBack)(id content);

/**
 *  调用分享控件
 *
 *  @param content       分享内容
 *  @param defaultConent 默认分享内容
 *  @param imageUrl      图片URL
 *  @param title         分享的标题
 *  @param url           分享的URL
 *  @param desc          分享的副标题
 *  @param view          分享弹出框在哪个View上显示
 *  @param shareSucc     分享成功回调
 */
+ (void)shareContent:(NSString *)content
       defaultConent:(NSString *)defaultConent
            imageUrl:(NSString *)imageUrl
               title:(NSString *)title
                 url:(NSString *)url
                desc:(NSString *)desc
                view:(UIView *)view
              shareSucc:(shareSuccess)success;



/**
 *  用户分享完成后，保存到每日分享
 *
 *  @param resName 分享的类型
 *  @param userId  用户ID
 */
+ (void)saveUserShare:(NSString *)resName userId:(NSString *)userId;


/**
 *  用户分享封装
 *
 *  @param responseData 分享的数据来源
 *  @param view  在哪个view弹出
 *  @param token 当前用户的token
 */
+ (void)shareContentFromDictionary:(NSDictionary *)responseData showView:(UIView *)view token:(NSString *)token shareSucc:(shareSuccess)success;

@end
