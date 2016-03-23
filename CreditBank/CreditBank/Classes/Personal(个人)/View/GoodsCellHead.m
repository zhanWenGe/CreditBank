//
//  GoodsCellHead.m
//  CreditBank
//
//  Created by Eric on 15/4/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "GoodsCellHead.h"
#import "PrefixHeader.pch"

@interface GoodsCellHead()

/**
 *  顶部线
 */
@property (nonatomic, weak) UILabel *topLine;
/**
 *  编号名字
 */
@property (nonatomic, weak) UILabel *serialName;
/**
 *  编号号码
 */
@property (nonatomic, weak) UILabel *serialNumber;

/**
 *  右边按钮
 */
@property (nonatomic, weak) UIButton *rightButton;
/**
 *  底部线
 */
@property (nonatomic, weak) UILabel *footLine;

@end


@implementation GoodsCellHead

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)setWinningView:(UIView *)view
{
    // 顶部线
    UILabel *topLine = [[UILabel alloc] init];
    topLine.backgroundColor = DEFALT_LINE_COLOR;
    [self addSubview:topLine];
    self.topLine = topLine;
    
    // 编号名字
    UILabel *serialName = [[UILabel alloc] init];
    serialName.textColor = HDColor(112, 112, 112);
    serialName.font = [UIFont systemFontOfSize:12];
    [self addSubview:serialName];
    self.serialName = serialName;
    
    // 编号号码
    UILabel *serialNumber = [[UILabel alloc] init];
    serialNumber.font = [UIFont systemFontOfSize:12];
    [self addSubview:serialNumber];
    self.serialNumber = serialNumber;
    
    // 右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:rightButton];
    self.rightButton = rightButton;
    
    // 底部线
    UILabel *footLine = [[UILabel alloc] init];
    footLine.backgroundColor = DEFALT_LINE_COLOR;
    [self addSubview:footLine];
    self.footLine = footLine;
    
}

- (void)layoutSubviews
{
    CGFloat paddin = 13;
    // 顶部线
    CGFloat topLineX = 0;
    CGFloat topLineY = 0;
    CGFloat topLineW = WIDTH;
    CGFloat topLineH = 0.5;
    self.topLine.frame = CGRectMake(topLineX, topLineY, topLineW, topLineH);
    
    // 编号名字
    CGFloat serialNameX = paddin;
    CGFloat serialNameY = 0.5;
    CGFloat serialNameW = 50;
    CGFloat serialNameH = 12;
    self.serialName.frame = CGRectMake(serialNameX, serialNameY, serialNameW, serialNameH);
    self.serialName.center = CGPointMake(self.serialName.center.x, self.center.y);
    [self.serialName sizeToFit];
    
    // 编号号码
    CGFloat serialNumberX = CGRectGetMaxX(self.serialName.frame);
    CGFloat serialNumberY = self.serialName.frame.origin.y;
    CGFloat serialNumberW = 100;
    CGFloat serialNumberH = 12;
    self.serialNumber.frame = CGRectMake(serialNumberX, serialNumberY, serialNumberW, serialNumberH);
    
    // 右边按钮
    CGFloat rightButtonX = WIDTH - 100;
    CGFloat rightButtonY = self.serialName.frame.origin.y;
    CGFloat rightButtonW = 100 - 15;
    CGFloat rightButtonH = 12;
    self.rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    
    // 底部线
    CGFloat footLineX = 10;
    CGFloat footLineY = self.bounds.size.height - 0.5;
    CGFloat footLineW = WIDTH - 10;
    CGFloat footLineH = 0.5;
    self.footLine.frame = CGRectMake(footLineX, footLineY, footLineW, footLineH);
}



@end
