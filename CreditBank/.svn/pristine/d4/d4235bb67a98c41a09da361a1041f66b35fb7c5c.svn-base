//
//  UnlineButton.m
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UnlineButton.h"

@implementation UnlineButton
- (void)drawRect:(CGRect)rect {
    
    // 选中的时候下划线
    if (self.selected == YES) {
        
        CGRect textRect = self.titleLabel.frame;
        
        CGFloat descender = self.titleLabel.font.descender;
        
        // 创建绘图区域
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        // 设置颜色
        CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
        
        // 画线段
        CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 5);
        
        
        CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 5);
        
        CGContextClosePath(contextRef);
        CGContextDrawPath(contextRef, kCGPathStroke);
    }
}

@end
