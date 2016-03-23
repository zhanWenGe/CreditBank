//
//  AboutViewModel.m
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AboutViewModel.h"
#import "AboutM.h"

@implementation AboutViewModel
/**
 *  请求评分和微博的接口
 *
 *  @param succBlock <#succBlock description#>
 *  @param errBlock  <#errBlock description#>
 *  @param failBlock <#failBlock description#>
 */
- (void) requestAboutData:(success)succBlock  errBlock:(error) errBlock failBlock:(fail) failBlock {
    
    NSString *url = @"?anu=api/1/setting/get_weibo_store";
    
    [self.request get:url params:nil successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        AboutM *aboutModel = [AboutM objectWithKeyValues:responseObject];
        succBlock(aboutModel);
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        errBlock(operation, responseObject);
        ANLog(@"%@", responseObject);

    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(operation, error);
        ANLog(@"%@", error);
    }];
}
@end
