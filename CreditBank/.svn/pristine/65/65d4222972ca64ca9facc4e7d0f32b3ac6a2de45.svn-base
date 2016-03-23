//
//  BrankCell.m
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "BrankCell.h"
#import "BrankCardM.h"
#import "PrefixHeader.pch"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BrankCell()


/**
 *  背景图
 */
@property (nonatomic, weak) UIImageView *backGrandImageView;
/**
 *  上半部分的背景
 */
@property (nonatomic, weak) UIView *topBackView;
/**
 *  下半部分的背景
 */
@property (nonatomic, weak) UIView *footBackView;
/**
 *  银行logo
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  银行的名称
 */
@property (nonatomic, weak) UILabel *brankNameLabel;
/**
 *  可导入积分
 */
@property (nonatomic, weak) UILabel *pointsImportedLabel;
/**
 *  银行卡尾号
 */
@property (nonatomic, weak) UILabel *brankCardNoLabel;
/**
 *  储蓄卡，信用卡
 */
@property (nonatomic, weak) UIButton *brankCardCredit;




@end
@implementation BrankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化子控件
        [self setUpSubViews];
        self.backgroundColor = DEFALT_BG;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpSubViews {
    
    self.textLabel.textColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:1.0];
    
    // 背景图
    UIImageView *backGrandImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backCardBackgrand"]];
    [self.contentView addSubview:backGrandImage];
    [self addSubview:backGrandImage];
    self.backGrandImageView = backGrandImage;
    
    // 上半部分的背景
    UIView *topBackView = [[UIView alloc] init];
    topBackView.layer.cornerRadius = 4;
    [backGrandImage addSubview:topBackView];
    topBackView.backgroundColor = HDColor(223, 70, 59);
    self.topBackView = topBackView;
    
    
    // 银行的logo
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.cornerRadius = 27.5;
    iconView.layer.masksToBounds = YES;
    [topBackView addSubview:iconView];
    self.iconView = iconView;
    iconView.backgroundColor = [UIColor whiteColor];
    
    // 银行的名称
    UILabel *brankNameLabel = [[UILabel alloc] init];
    brankNameLabel.textColor = [UIColor whiteColor];
    brankNameLabel.font = [UIFont systemFontOfSize:19];
    [topBackView addSubview:brankNameLabel];
    self.brankNameLabel = brankNameLabel;
    
    // 可导入积分
    UILabel *pointsImportedLabel = [[UILabel alloc] init];
    pointsImportedLabel.textColor = [UIColor whiteColor];
    pointsImportedLabel.font = [UIFont systemFontOfSize:12];
    [topBackView addSubview:pointsImportedLabel];
    self.pointsImportedLabel = pointsImportedLabel;

    // 下半部分的背景
    UIView *footBackView = [[UIView alloc] init];
    [backGrandImage addSubview:footBackView];
    footBackView.backgroundColor = [UIColor whiteColor];
    self.footBackView = footBackView;
    
    // 银行卡尾号
    UILabel *brankCardNoLabel = [[UILabel alloc] init];
    brankCardNoLabel.textColor = HDColor(173, 173, 173);
    brankCardNoLabel.font = [UIFont systemFontOfSize:12.0];
    [footBackView addSubview:brankCardNoLabel];
    self.brankCardNoLabel = brankCardNoLabel;
    
    // 储蓄卡，信用卡
    UIButton *brankCardCredit = [UIButton buttonWithType:UIButtonTypeCustom];
    brankCardCredit.titleLabel.font = [UIFont systemFontOfSize:12];
    [brankCardCredit setTitleColor:HDColor(173, 173, 173) forState:UIControlStateNormal];
    [brankCardCredit setImage:[UIImage imageNamed:@"cardIcon"] forState:UIControlStateNormal];
    [footBackView addSubview:brankCardCredit];
    self.brankCardCredit = brankCardCredit;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 背景
    CGFloat margin = 7;
    CGFloat backGrandImageH = 120;
    CGFloat backGrandImageX = margin;
    CGFloat backGrandImageY = margin;
    CGFloat backGrandImageW = WIDTH - margin * 2;
    self.backGrandImageView.frame = CGRectMake(backGrandImageX, backGrandImageY, backGrandImageW, backGrandImageH);
    
    // 上半部分的背景
    CGFloat topBackViewH = backGrandImageH - 20 - 2 * margin - 4;
    CGFloat topBackViewX = margin + 1;
    CGFloat topBackViewY = margin + 1;
    CGFloat topBackViewW = backGrandImageW - 2 * margin - 3.5;
    self.topBackView.frame = CGRectMake(topBackViewX, topBackViewY, topBackViewW, topBackViewH);
    
    // 银行的logo
    CGFloat iconViewX = 15;
    CGFloat iconViewY = 10;
    CGFloat iconViewW = 55;
    CGFloat iconViewH = 55;
    self.iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 银行的名称
    CGFloat brankNameLabelX = 83;
    CGFloat brankNameLabelY = 15;
    CGFloat brankNameLabelW = topBackViewW - 83;
    CGFloat brankNameLabelH = 19;
    self.brankNameLabel.frame = CGRectMake(brankNameLabelX, brankNameLabelY, brankNameLabelW, brankNameLabelH);
    
    // 可导入积分
    CGFloat pointsImportedLabelX = brankNameLabelX;
    CGFloat pointsImportedLabelY = CGRectGetMaxY(self.brankNameLabel.frame) + 9;
    CGFloat pointsImportedLabelW = brankNameLabelW;
    CGFloat pointsImportedLabelH = 12;
    self.pointsImportedLabel.frame = CGRectMake(pointsImportedLabelX, pointsImportedLabelY, pointsImportedLabelW, pointsImportedLabelH);
    
    // 下半部分的背景
    CGFloat footBackViewH = 25;
    CGFloat footBackViewX = topBackViewX;
    CGFloat footBackViewY = topBackViewY + 74;
    CGFloat footBackViewW = topBackViewW;
    self.footBackView.frame = CGRectMake(footBackViewX, footBackViewY, footBackViewW, footBackViewH);
    
    // 银行卡尾号
    CGFloat paddig = 17;
    CGFloat brankCardNoLabelX = paddig;
    CGFloat brankCardNoLabelY = paddig * 0.5;
    CGFloat brankCardNoLabelW = footBackViewW * 0.5;
    CGFloat brankCardNoLabelH = 12;
    self.brankCardNoLabel.frame = CGRectMake(brankCardNoLabelX, brankCardNoLabelY, brankCardNoLabelW, brankCardNoLabelH);
    
    // 储蓄卡，信用卡
    CGFloat brankCardCreditX = footBackViewW - 65;
    CGFloat brankCardCreditY = brankCardNoLabelY;
    CGFloat brankCardCreditW = 60;
    CGFloat brankCardCreditH = 12;
    self.brankCardCredit.frame = CGRectMake(brankCardCreditX, brankCardCreditY, brankCardCreditW, brankCardCreditH);
    
    
}

- (void)setCardM:(BrankCardM *)cardM {
    _cardM = cardM;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cardM.icon]
                     placeholderImage:[UIImage imageNamed:@"avatar"]];
    self.brankNameLabel.text      = cardM.card_name;
    self.pointsImportedLabel.text = [NSString stringWithFormat:@"可导入 %@ 积分", cardM.credit];
    self.brankCardNoLabel.text    = [NSString stringWithFormat:@"尾号 %@", cardM.card_no_tail];
    
    if ([cardM.is_credit_card isEqualToString:@"0"]) {
        [self.brankCardCredit setTitle:[NSString stringWithFormat:@"  储蓄卡"] forState:UIControlStateNormal];
    } else if ([cardM.is_credit_card isEqualToString:@"1"]){
        [self.brankCardCredit setTitle:[NSString stringWithFormat:@"  信用卡"] forState:UIControlStateNormal];
    }
    
    self.topBackView.backgroundColor = [UIColor colorWithHexString:cardM.color];
    
}

+(instancetype)cellWithInit:(UITableView *)tableView {
    static NSString *ident = @"brankCell";
    BrankCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        cell = [[BrankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    return cell;
}

@end
