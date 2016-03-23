//
//  AddBrankCardButton.m
//  CreditBank
//
//  Created by Eric on 15/4/27.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AddBrankCardButton.h"

@interface AddBrankCardButton()

@property (nonatomic, weak) UIImageView *redIcon;

@end


@implementation AddBrankCardButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"add_brank"] forState:UIControlStateNormal];
        [self setTitle:@"添加银行卡" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIImageView *redIcon = [[UIImageView alloc] init];
        redIcon.backgroundColor = [UIColor redColor];
        redIcon.layer.cornerRadius = 2.5;
        [self addSubview:redIcon];
        self.redIcon = redIcon;
        
        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageViewX = 14;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = 9;
    CGFloat imageViewH = 9;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    self.imageView.center = CGPointMake(self.imageView.center.x, self.center.y);
    
    CGFloat titleLabelX = CGRectGetMaxX(self.imageView.frame) + 7;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelW = 20;
    CGFloat titleLabelH = 20;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    self.titleLabel.center = CGPointMake(self.titleLabel.center.x, self.center.y);
    [self.titleLabel sizeToFit];
    
    CGFloat redIconX = CGRectGetMaxX(self.frame) - 20;
    CGFloat redIconY = 0;
    CGFloat redIconW = 5;
    CGFloat redIconH = 5;
    self.redIcon.frame = CGRectMake(redIconX, redIconY, redIconW, redIconH);
    self.redIcon.center = CGPointMake(self.redIcon.center.x, self.center.y);
    
}


@end
