//
//  MessageListModel.h
//  CreditBank
//
//  Created by Eric on 15/4/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListModel : NSObject

/**
 *   id：消息id
 */
@property (nonatomic, copy) NSString *ID;
/**
 *content：消息内容
 */
@property (nonatomic, copy) NSString *content;
/**
 * id_read：已读1-未读0
 */
@property (nonatomic, copy) NSString *is_read;




@end
