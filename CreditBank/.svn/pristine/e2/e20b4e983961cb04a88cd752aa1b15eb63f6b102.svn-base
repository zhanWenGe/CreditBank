//
//  StatementCell.h
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatementM.h"

@interface StatementCell : UITableViewCell
// 图标
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 积分数
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
// 交易状态
@property (weak, nonatomic) IBOutlet UILabel *TransactionStatLabel;
// 数据模型
@property (strong, nonatomic) StatementM  *data;
// 构造方法
+ (instancetype)statementWithCell:(UITableView *)tableview;
@end
