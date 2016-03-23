//
//  StatementCell.m
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "StatementCell.h"
#import "PrefixHeader.pch"


@interface StatementCell()

@end

@implementation StatementCell

+ (instancetype)statementWithCell:(UITableView *)tableview {
    static NSString *ID = @"StatementCell";
    
    StatementCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = (StatementCell *)[[[NSBundle mainBundle] loadNibNamed:@"StatementCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setData:(StatementM *)data {
    _data = data;
    
    // 图片
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.m_icon]];
    self.titleLabel.text           = data.title;
    self.creditLabel.text          = [NSString stringWithFormat:@"%@ 积分", data.use_credit];
    self.dateLabel.text            = data.date;
    self.TransactionStatLabel.text = @"交易成功";
}
@end
