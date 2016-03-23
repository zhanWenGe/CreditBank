//
//  BarkModel.h
//  CreditBank
//
//  Created by Eric on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarkModel : NSObject

/**
 *  银行ID
 */
@property (nonatomic, copy) NSString *bank_id;
/**
 *  是否信用卡
 */
@property (nonatomic, copy) NSString *is_credit;
/**
 *  银行名字
 */
@property (nonatomic, copy) NSString *name;

@end
