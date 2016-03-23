//
//  CardDetailCell.m
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CardDetailView.h"
#import "PrefixHeader.pch"
#import "BrankCardM.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CardDetailView()

/**
 *  银行logo
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  银行的名称
 */
@property (nonatomic, weak) UILabel *brankNameLabel;
/**
 *  银行卡尾号
 */
@property (nonatomic, weak) UILabel *brankCardNoLabel;
/**
 *  储蓄卡，信用卡
 */
@property (nonatomic, weak) UIButton *brankCardCredit;

@end

@implementation CardDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 初始化子控件
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    
    // 银行的logo
    UIImageView *iconView = [[UIImageView alloc] init];
//    iconView.layer.cornerRadius = 27.5;
//    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    self.iconView = iconView;
//    iconView.image = [UIImage imageNamed:@"ccb@3x"];
    
    // 银行的名称
    UILabel *brankNameLabel = [[UILabel alloc] init];
//    brankNameLabel.textColor = [UIColor whiteColor];
    brankNameLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:brankNameLabel];
    self.brankNameLabel = brankNameLabel;
//    brankNameLabel.backgroundColor = [UIColor yellowColor];
//    brankNameLabel.text = @"中国光大银行";
    
    // 银行卡尾号
    UILabel *brankCardNoLabel = [[UILabel alloc] init];
    brankCardNoLabel.textColor = HDColor(173, 173, 173);
    brankCardNoLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:brankCardNoLabel];
    self.brankCardNoLabel = brankCardNoLabel;
//    brankCardNoLabel.backgroundColor = [UIColor yellowColor];
//    brankCardNoLabel.text = @"尾号 4213";
    
    // 银行卡类型
    UIButton *brankCardCredit = [UIButton buttonWithType:UIButtonTypeCustom];
    brankCardCredit.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [brankCardCredit setTitleColor:HDColor(173, 173, 173) forState:UIControlStateNormal];
    [brankCardCredit setImage:[UIImage imageNamed:@"cardIcon"] forState:UIControlStateNormal];
    [self addSubview:brankCardCredit];
    self.brankCardCredit = brankCardCredit;
//    [self.brankCardCredit setTitle:@"  储蓄卡" forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    // 银行的logo
    CGFloat space = 15;
    CGFloat iconViewX = space;
    CGFloat iconViewY = 5;
    CGFloat iconViewW = 60;
    CGFloat iconViewH = 60;
    self.iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    self.iconView.backgroundColor = [UIColor redColor];
    
    // 银行的名称
    CGFloat brankNameLabelX = CGRectGetMaxX(self.iconView.frame) + space;
    CGFloat brankNameLabelY = 18.5;
    CGFloat brankNameLabelW = WIDTH - 95;
    CGFloat brankNameLabelH = 17;
    self.brankNameLabel.frame = CGRectMake(brankNameLabelX, brankNameLabelY, brankNameLabelW, brankNameLabelH);
    
    // 银行卡尾号
    CGFloat paddig = 7.5;
    CGFloat brankCardNoLabelX = brankNameLabelX;
    CGFloat brankCardNoLabelY = CGRectGetMaxY(self.brankNameLabel.frame) + paddig;
    CGFloat brankCardNoLabelW = brankNameLabelW - 75;
    CGFloat brankCardNoLabelH = 12;
    self.brankCardNoLabel.frame = CGRectMake(brankCardNoLabelX, brankCardNoLabelY, brankCardNoLabelW, brankCardNoLabelH);
    
    // 银行卡类型
    CGFloat brankCardCreditX = WIDTH - 68;
    CGFloat brankCardCreditY = brankCardNoLabelY;
    CGFloat brankCardCreditW = 60;
    CGFloat brankCardCreditH = 12;
    self.brankCardCredit.frame = CGRectMake(brankCardCreditX, brankCardCreditY, brankCardCreditW, brankCardCreditH);

    
}

- (void)setBrankCardModel:(BrankCardM *)brankCardModel
{
    _brankCardModel = brankCardModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:brankCardModel.icon]
                     placeholderImage:[UIImage imageNamed:@"avatar"]];
    self.brankNameLabel.text = [NSString stringWithFormat:@"%@", brankCardModel.card_name];
    self.brankCardNoLabel.text = [NSString stringWithFormat:@"尾号 %@", brankCardModel.card_no_tail];
   
    if ([brankCardModel.is_credit_card isEqualToString:@"0"]) {
        [self.brankCardCredit setTitle:[NSString stringWithFormat:@"  储蓄卡"] forState:UIControlStateNormal];
    } else if ([brankCardModel.is_credit_card isEqualToString:@"1"]){
        [self.brankCardCredit setTitle:[NSString stringWithFormat:@"  信用卡"] forState:UIControlStateNormal];
    }
}

@end
