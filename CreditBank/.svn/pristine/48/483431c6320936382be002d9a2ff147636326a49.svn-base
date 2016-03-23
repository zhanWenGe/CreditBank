//
//  ShopCollectionViewCell.m
//  无线滚动-0012
//
//  Created by Eric on 15/4/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ShopCollectionViewCell.h"
#import "ShopM.h"

@interface ShopCollectionViewCell()
@property(nonatomic, weak) UILabel *label;
@property(nonatomic, weak) UILabel *labelDesc;
@property(nonatomic, weak) UIImageView *imageView;
@end

@implementation ShopCollectionViewCell
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)setM:(ShopM *)m {
    
    self.label.text = m.title;
    self.imageView.image = [UIImage imageNamed:m.icon];
    self.labelDesc.text = m.titleDesc;
}



- (void)setUp {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    [self addSubview:label];
    self.label = label;
    
    UILabel *labelDesc = [[UILabel alloc] init];
    labelDesc.textColor = [UIColor greenColor];
    [self addSubview:labelDesc];
    self.labelDesc = labelDesc;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.frame.size.width;
    CGFloat labelH = 20;
    
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat labelDescX = 0;
    CGFloat labelDescY = CGRectGetMaxY(self.label.frame) + 10;
    CGFloat labelDescW = self.frame.size.width;
    CGFloat labelDescH = 20;
    self.labelDesc.frame = CGRectMake(labelDescX, labelDescY, labelDescW, labelDescH);
    
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
}
@end
