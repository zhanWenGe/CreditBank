//
//  HDTabBar.m
//  hudongweibo
//
//  Created by Eric on 15/3/19.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "HDTabBar.h"
#import "PrefixHeader.pch"


@interface HDTabBar()

@property (nonatomic, weak) HDTabBarButton *selectedButton;

@end

@implementation HDTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!iOS7) {
            
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    HDTabBarButton *button = [HDTabBarButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClickedAction:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClickedAction:(HDTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index++) {
        
        // 1.取出按钮
        HDTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    
    }
}

@end
