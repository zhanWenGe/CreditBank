//
//  UpdateM.h
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateM : NSObject
/**
 *  版本号
 */
@property(nonatomic, copy) NSString *version;
/**
 *  新版本应用地址
 */
@property(nonatomic, copy) NSString *link;
/**
 *  更新描述信息
 */
@property(nonatomic, copy) NSString *desc;
/**
 *  更新时间
 */
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *status;
@end
