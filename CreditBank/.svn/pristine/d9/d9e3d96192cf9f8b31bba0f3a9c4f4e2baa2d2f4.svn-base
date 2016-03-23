//
//  HDTabBar.h
//  hudongweibo
//
//  Created by Eric on 15/3/19.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDTabBar;

@protocol HDTabBarDelegate <NSObject>

@optional
- (void)tabBar:(HDTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface HDTabBar : UIView

@property (nonatomic, weak) id<HDTabBarDelegate> delegate;




- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
