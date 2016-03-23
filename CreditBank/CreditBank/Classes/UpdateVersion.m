//
//  UpdateVersion.m
//  CreditBank
//
//  Created by 王德康 on 15/5/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UpdateVersion.h"
#import "PrefixHeader.pch"
#import "UpdateM.h"

@interface UpdateVersion ()
@property(nonatomic, strong) UpdateM *updateM;
@end

@implementation UpdateVersion
#pragma mark -- Update method

- (void)checkUpdateVersion {
    
    NSString *flag = @"ios";
    NSString *time = [NSDate getTime];
    NSString *appId = PLATFORMID;
    
    NSString *sign = [Common paramsSign:@[flag, time]];
    
    NSDictionary *parameters = @{@"app_id" : appId,
                                 @"flag"   : flag,
                                 @"time"   : time,
                                 @"sign"   : sign};
    
    
    AnRequest *anRequest = [[AnRequest alloc] init];
    NSString  *url       = @"?anu=api/1/version/get_latest_version";
    
    [anRequest post:url params:parameters successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 字典转模型
        self.updateM = [UpdateM objectWithKeyValues:responseObject];
        
        // 调用显示对话框方法
        [self updateVersion:self.updateM];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ANLog(@"error:%@", responseObject);
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        ANLog(@"fail:%@", operation.responseString);
    }];
    
}

/**
 *  更新提示新版本
 *
 *  @param update update description
 */
- (void)updateVersion:(UpdateM *)update {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if (![currentVersion isEqualToString:update.version]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"软件更新" message:self.updateM.desc delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
        alertView.delegate     = self;
        [alertView show];
    }
}

#pragma mark -- UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ANLog(@"%ld", buttonIndex);
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateM.link]];
    }
}

- (void)dealloc {
    ANLog(@"UpdateViewController-dealloc");
}

@end
