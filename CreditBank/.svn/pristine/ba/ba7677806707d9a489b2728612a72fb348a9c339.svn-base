//
//  NewsCollectionViewCell.m
//  无线滚动-0012
//
//  Created by Eric on 15/4/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "NewsCollectionViewCell.h"
#import "FocusModel.h"
#import "PrefixHeader.pch"

@interface NewsCollectionViewCell()
@property(nonatomic, weak) UILabel *label;
@property(nonatomic, weak) UIImageView *imageView;
@end

@implementation NewsCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}


- (void)setFocusM:(FocusModel *)focusM
{
    _focusM = focusM;
//    self.label.text = focusM.title;
//    ANLog(@"setFocusM:%@", focusM.cover);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:focusM.cover]];
}

- (void)setUp {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [self addSubview:imageView];
    self.imageView = imageView;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    self.label = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.frame.size.width;
    CGFloat labelH = 20;
    
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
}
@end
