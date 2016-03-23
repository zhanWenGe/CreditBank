//
//  MessageViewCell.h
//  CreditBank
//
//  Created by Eric on 15/4/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageListModel;
@interface MessageViewCell : UITableViewCell

@property (nonatomic, strong) MessageListModel *messageListModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
