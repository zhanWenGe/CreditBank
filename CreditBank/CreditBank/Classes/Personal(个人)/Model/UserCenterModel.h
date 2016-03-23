//
//  UserCenterModel.h
//  CreditBank
//
//  Created by Eric on 15/4/15.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterModel : NSObject

/**
 *  头像
 */
@property (nonatomic, copy) NSString *avatar;
/**
 *  银行卡个数
 */
@property (nonatomic, copy) NSString *card_num;
/**
 *  积分
 */
@property (nonatomic, copy) NSString *credit;
/**
 *  收藏个数
 */
@property (nonatomic, assign) NSInteger fav_num;

/**
 *  我的票务个数
 */
@property (nonatomic, assign) NSInteger ticket_num;

/**
 *  抽奖记录个数
 */
@property (nonatomic, assign) NSInteger lottery_record_num;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  订单个数
 */
@property (nonatomic, assign) NSInteger order_num;
/**
 *  安全等级
 */
@property (nonatomic, copy) NSString *safe_level;
/**
 *  操作成功失败的标识（error-失败 success-成功）
 */
@property (nonatomic, copy) NSString *status;

/**
 *  是否有未读消息
 */
@property (nonatomic, assign) NSInteger has_message;


@end
