//
//  HDBadgeButton.m
//  hudongweibo
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "HDBadgeButton.h"
#import "PrefixHeader.pch"

@implementation HDBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
//        CGFloat badgeY = 0;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
//            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];// 该方法以废弃
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
//        CGFloat badgeX = self.frame.size.width - badgeW - 10;
//        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        
    } else {
        self.hidden = YES;
    }

}

@end
