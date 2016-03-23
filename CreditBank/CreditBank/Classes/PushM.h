//
//  PushM.h
//  CreditBank
//
//  Created by Eric on 15/4/10.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushM : NSObject
/**
 *  推送时间
 */
@property(nonatomic, copy) NSString *add_time;
/**
 *  消息内容
 */
@property(nonatomic, copy) NSString *content;
/**
 *  提示信息
 */
@property(nonatomic, copy) NSString *info;
/**
 *  对应链接（如果有的话）
 */
@property(nonatomic, copy) NSString *link;
/**
 *  推送的id
 */
@property(nonatomic, copy) NSString *push_id;
/**
 *  分类对应id（如果有的话)
 */
@property(nonatomic, copy) NSString *res_id;
/**
 *  res_name:分类名称（如果有的话）
 */
@property(nonatomic, copy) NSString *res_name;
/**
 *  操作成功失败的标识（error-失败 success-成功)
 */
@property(nonatomic, copy) NSString *status;
@end
