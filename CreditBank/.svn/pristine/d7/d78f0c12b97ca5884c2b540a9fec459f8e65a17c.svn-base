//
//  HDTitleButton.m
//  hudongweibo
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "HDTitleButton.h"
#import "PrefixHeader.pch"

#define HDTitleButtonImageW 20

@interface HDTitleButton()



@end

@implementation HDTitleButton

+ (instancetype)titleButton
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 当高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        // 背景
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *leftImage = [[UIImageView alloc] init];
        [self addSubview:leftImage];
        
        self.leftImage = leftImage;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageY = 0;
    CGFloat imageW = HDTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 25;
    CGFloat titleW = contentRect.size.width - HDTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据title计算自己的宽度
    CGFloat titleW = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + HDTitleButtonImageW + 5;
    
    if (self.leftImage) {
        self.leftImage.frame = CGRectMake(5, 6, 14, 13);
        frame.size.width = titleW + HDTitleButtonImageW + 5 + 20;
    }
    
    self.frame = frame;
    [super setTitle:title forState:state];
    
}

@end
