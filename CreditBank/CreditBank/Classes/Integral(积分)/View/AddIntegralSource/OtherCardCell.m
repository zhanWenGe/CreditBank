//
//  OtherCardCell.m
//  CreditBank
//
//  Created by Eric on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "OtherCardCell.h"
#import "PrefixHeader.pch"

@interface OtherCardCell()

///**
// *  图标
// */
//@property (nonatomic, weak) UIImageView *icon;
///**
// *  标题
// */
//@property (nonatomic, weak) UILabel *titlabel;

@end

@implementation OtherCardCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(13, 0, 15, 15);
    self.imageView.center = CGPointMake(self.imageView.center.x, self.contentView.center.y);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 10, 0, WIDTH - 100, self.contentView.frame.size.height);
    
}


+ (OtherCardCell *)otherCardCellView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    OtherCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OtherCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}


@end