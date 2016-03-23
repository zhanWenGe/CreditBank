//
//  MessageViewCell.m
//  CreditBank
//
//  Created by Eric on 15/4/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "MessageViewCell.h"
#import "PrefixHeader.pch"
#import "MessageListModel.h"

@interface MessageViewCell()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *messageLabel;




@end

@implementation MessageViewCell

/**
 *  添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.未读状态
        UIImageView *iconView = [[UIImageView alloc] init];
        // 设置圆形imageView的半径
        iconView.layer.cornerRadius = 7.5 * 0.5;
        // 设置图片是否遮住边界
        iconView.layer.masksToBounds = YES;
        // 设置边框的颜色
        iconView.layer.borderColor = [[UIColor whiteColor] CGColor];

        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 2.消息内容
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.font = [UIFont systemFontOfSize:12];
        messageLabel.textColor = HDColor(0, 0, 0);
        messageLabel.numberOfLines = 2;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        // 3.下边线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 67 - 0.5, WIDTH, 0.5)];
        line.backgroundColor = HDColor(213, 214, 214);
        [self.contentView addSubview:line];
        
//        iconView.backgroundColor = [UIColor redColor];
//        messageLabel.backgroundColor = [UIColor yellowColor];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置大小
    [self settingFrame];
}

/**
 *  赋值
 */
- (void)setMessageListModel:(MessageListModel *)messageListModel
{
    _messageListModel = messageListModel;
    
    // 消息内容
    self.messageLabel.text = messageListModel.content;
    
    // 未读状态
    if ([messageListModel.is_read isEqual:@0]) {
        self.iconView.backgroundColor = [UIColor redColor];
    } else {
        self.iconView.backgroundColor = [UIColor whiteColor];
    }
    
}

/**
 *  设置frame
 */
- (void)settingFrame
{
    // 1.未读状态图标
    CGFloat iconViewX = 15;
    CGFloat iconViewY = 30;
    CGFloat iconViewW = 7.5;
    CGFloat iconViewH = iconViewW;
    self.iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 2.消息
    CGFloat messageX = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat messageY = 0;
    CGFloat messageW = WIDTH - 60;
    CGFloat messageH = 0;
    self.messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageH);
    [self.messageLabel sizeToFit];
    self.messageLabel.center = CGPointMake(self.messageLabel.center.x, self.iconView.center.y);

}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

@end
