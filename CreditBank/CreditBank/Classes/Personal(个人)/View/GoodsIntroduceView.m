//
//  GoodsIntroduceView.m
//  CreditBank
//
//  Created by Eric on 15/4/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "GoodsIntroduceView.h"
#import "PrefixHeader.pch"

@interface GoodsIntroduceView()

/**
 *  商品图片
 */
@property (nonatomic, weak) UIImageView *goodsImage;
/**
 *  商品详情
 */
@property (nonatomic, weak) UILabel *goodsDetailsLabel;
/**
 *  积分数值
 */
@property (nonatomic, weak) UILabel *integralLabel;
/**
 *  编号名字
 */
@property (nonatomic, weak) UILabel *lotteryNameLabel;
/**
 *  编号号码
 */
@property (nonatomic, weak) UILabel *lotteryNumberLabel;



@end


@implementation GoodsIntroduceView





- (void)setGoodsIntroduceView:(UIView *)view
{
    // 商品图片
    UIImageView *goodsImage = [[UIImageView alloc] init];
    [self addSubview:goodsImage];
    goodsImage.layer.cornerRadius = 3;
    goodsImage.layer.masksToBounds = YES;
    goodsImage.layer.borderColor = DEFALT_LINE_COLOR.CGColor;
    goodsImage.layer.borderWidth = 0.5;
    self.goodsImage = goodsImage;
    
    // 商品详情
    UILabel *goodsDetailsLabel = [[UILabel alloc] init];
    goodsDetailsLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:goodsDetailsLabel];
    
    // 积分数值
    UILabel *integralLabel = [[UILabel alloc] init];
    integralLabel.font = [UIFont systemFontOfSize:12];
    integralLabel.textColor = HDColor(250, 93, 92);
    [self addSubview:integralLabel];
    self.integralLabel = integralLabel;
    
    // 编号名字
    UILabel *lotteryNameLabel = [[UILabel alloc] init];
    lotteryNameLabel.textColor = HDColor(112, 112, 112);
    lotteryNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:lotteryNameLabel];
    self.lotteryNameLabel = lotteryNameLabel;
    
    // 编号号码
    UILabel *lotteryNumberLabel = [[UILabel alloc] init];
    lotteryNumberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:lotteryNumberLabel];
    self.lotteryNumberLabel = lotteryNumberLabel;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 13;
    
    // 商品图片
    CGFloat goodsImageX = padding;
    CGFloat goodsImageY = padding;
    CGFloat goodsImageW = 80;
    CGFloat goodsImageH = 80;
    self.goodsImage.frame = CGRectMake(goodsImageX, goodsImageY, goodsImageW, goodsImageH);
    
    // 商品详情
    CGFloat goodsDetailsLabelX = CGRectGetMaxX(self.goodsImage.frame) + padding;
    CGFloat goodsDetailsLabelY = goodsImageY + 5;
    CGFloat goodsDetailsLabelW = WIDTH - goodsDetailsLabelX;
    CGFloat goodsDetailsLabelH = 15;
    self.goodsDetailsLabel.frame = CGRectMake(goodsDetailsLabelX, goodsDetailsLabelY, goodsDetailsLabelW, goodsDetailsLabelH);
    
    // 积分数值
    CGFloat integralLabelX = goodsDetailsLabelX;
    CGFloat integralLabelY = CGRectGetMaxY(self.goodsDetailsLabel.frame) + 7;
    CGFloat integralLabelW = WIDTH - goodsDetailsLabelX;
    CGFloat integralLabelH = 12;
    self.integralLabel.frame = CGRectMake(integralLabelX, integralLabelY, integralLabelW, integralLabelH);
    
    // 编号名字
    CGFloat lotteryNameLabelX = goodsDetailsLabelX;
    CGFloat lotteryNameLabelY = CGRectGetMaxY(self.integralLabel.frame) + 20;
    CGFloat lotteryNameLabelW = WIDTH - goodsDetailsLabelX;
    CGFloat lotteryNameLabelH = 12;
    self.lotteryNameLabel.frame = CGRectMake(lotteryNameLabelX, lotteryNameLabelY, lotteryNameLabelW, lotteryNameLabelH);
    [self.lotteryNameLabel sizeToFit];
}







@end
