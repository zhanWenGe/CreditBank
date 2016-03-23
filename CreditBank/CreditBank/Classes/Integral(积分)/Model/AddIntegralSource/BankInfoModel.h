//
//  BankInfoModel.h
//  CreditBank
//
//  Created by Eric on 15/5/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankInfoModel : NSObject

/**
 *  银行积分
 */
@property (nonatomic, copy) NSString *bank_credit;
/**
 *  银行信息
 */
@property (nonatomic, copy) NSString *bank_info;
/**
 *  银行卡尾号
 */
@property (nonatomic, copy) NSString *bank_number;
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




/**
 *  是否为信用卡
 */
@property (nonatomic, copy) NSString *is_credit_card;
/**
 *  用户姓名
 */
@property (nonatomic, copy) NSString *user_name;
/**
 *  积分数量
 */
@property (nonatomic, copy) NSString *credit;

@end
