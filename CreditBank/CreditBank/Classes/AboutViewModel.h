//
//  AboutViewModel.h
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ViewModel.h"
#import "AboutM.h"
/**
 *  网络请求完成
 *
 *  @param AboutM 完成的模型数据
 */
typedef void(^success)(AboutM *m);

/**
 *  数据错误
 *
 *  @param AboutM AboutM description
 */
typedef void(^error)(AFHTTPRequestOperation *operation, id responseObject);

/**
 *  网络请求错误
 *
 *  @param AboutM AboutM description
 */
typedef void(^fail)(AFHTTPRequestOperation *operation, NSError *error);

@interface AboutViewModel : ViewModel
- (void) requestAboutData:(success)succBlock  errBlock:(error) errBlock failBlock:(fail) failBlock;
@end
