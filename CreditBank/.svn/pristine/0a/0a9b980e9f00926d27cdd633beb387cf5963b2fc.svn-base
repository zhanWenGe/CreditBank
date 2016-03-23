//
//  ErrorView.h
//  CreditBank
//
//  Created by 王德康 on 15/5/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ErrorView;

@protocol ErrorViewDelegate <NSObject>

@optional
- (void)errorView:(ErrorView *)view reloadBtn:(UIButton *)btn;
@end

@interface ErrorView : UIView
@property(nonatomic, weak) id <ErrorViewDelegate> delegate;
+ (instancetype) errWithView;
@end
