//
//  SingleLogin.m
//  CreditBank
//
//  Created by 王德康 on 15/5/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SingleLogin.h"
#import "PrefixHeader.pch"
#import "SingleLoginM.h"
#import "Push.h"
#import "LogoutHandler.h"

@implementation SingleLogin
/**
 *  当前用户是否允许在在当前设备登录
 */
+ (void)checkSingleDeviceLogin {
    
    NSString *token = [Common token];
    if (token == nil) {
        return;
    }

   
    
    NSString *time   = [NSDate getTime];
    NSString *appId  = PLATFORMID;
    NSString *regId  = [Push GetRegistrationID];
    NSString *sign   = [Common paramsSign:@[token, regId,time]];
    
    NSDictionary *parameters = @{@"app_id" : appId,
                                 @"token"  : token,
                                 @"reg_id" : regId,
                                 @"time"   : time,
                                 @"sign"   : sign};
    
    
    AnRequest *anRequest = [[AnRequest alloc] init];
    NSString  *url       = @"?anu=api/1/user/check_account_exception";
    
    [anRequest post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 判断当前用户在此设备是否可以登录，可以忽略，不可以强制退出
        SingleLoginM *m = [SingleLoginM objectWithKeyValues:responseObject];
        if ([m.error_code isEqualToString:@"-10000"]) {
            // 退出登录
            [LogoutHandler logoutHandlerFromControllor];
        }
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        // token 过期
        if ([Common isKeyDictionary:@"error_code" dict:responseObject]) {
            if ([responseObject[@"error_code"] isEqualToString:@"10000"] ) {
                // 退出登录
                [LogoutHandler logoutHandlerFromControllor];
            }
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"check_account_exception_fail:%@", operation.responseString);
    }];
}
@end
