//
//  LineButton.h
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LineButton;
@protocol LineButtonDelegate <NSObject>

@optional
- (void)lineButtonClicked:(LineButton *)view button:(UIButton *)btn index:(NSInteger)index;

@end

@interface LineButton : UIView

+ (instancetype)lineButtonTableView:(UITableView *)tableView
                         leftButton:(NSString *)leftButtonTitle
                        middleBtton:(NSString *)middleButtonTitle
                        rightButton:(NSString *)rightButtonTitle;


@property (nonatomic, weak) id <LineButtonDelegate> delegate;



@end
