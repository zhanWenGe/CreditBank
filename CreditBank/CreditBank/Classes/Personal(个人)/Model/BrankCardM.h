//
//  BrankCardM.h
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrankCardM : NSObject
/**
 *  银行名字
 */
@property(nonatomic, copy) NSString *card_name;
/**
 *  银行图标
 */
@property(nonatomic, copy) NSString *icon;
/**
 *  银行卡尾号
 */
@property(nonatomic, copy) NSString *card_no_tail;
/**
 *  银行卡ID
 */
@property(nonatomic, copy) NSString *card_id;
/**
 *  银行卡类型ID
 */
@property(nonatomic, assign) NSString *brankTypeId;
/**
 *  银行卡类型(0 = 储蓄卡, 1 = 信用卡)
 */
@property(nonatomic, assign) NSString *is_credit_card;
/**
 *  银行卡的背景颜色
 */
@property (nonatomic, copy) NSString *color;
/**
 *  可导入积分
 */
@property (nonatomic, copy) NSString *credit;

/**
 *  汇率
 */
@property (nonatomic, copy) NSString *bank_rate;
/**
 *  银行卡号
 */
@property (nonatomic, copy) NSString *card_no;

/**
 *  银行id
 */
@property (nonatomic, copy) NSString *bank_id;


@end
