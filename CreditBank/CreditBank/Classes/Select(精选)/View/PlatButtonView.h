//
//  PlatButtonView.h
//  CreditBank
//
//  Created by Eric on 15/4/24.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatButtonView;

@protocol PlatButtonViewDelegate <NSObject>

@optional

- (void)platButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index;


@end
@interface PlatButtonView : UIView

@property (nonatomic, strong) NSArray *platButtonDataArray;

@property (nonatomic, weak) id <PlatButtonViewDelegate> delegate;

+ (PlatButtonView *)plantButton:(UIView *)view;

@end
