//
//  CateButton.m
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CateButton.h"

@interface CateButton()
@property(nonatomic, weak) UIImageView *cateImageView;
@end
@implementation CateButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"triangle"];
        
        [self addSubview:imageView];
        self.cateImageView = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageViewW  = 5;
    CGFloat imageViewH  = 2;
    CGFloat imageViewX  = self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x + 2;
    CGFloat imageViewY  = self.titleLabel.frame.origin.y + (self.titleLabel.frame.size.height - imageViewH ) * 0.5;
    self.cateImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}


@end
