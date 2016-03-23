//
//  BindingAccountController.h
//  CreditBank
//
//  Created by Eric on 15/5/14.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseSetingViewController.h"

typedef void (^ChangeSubTitleBlock)(NSString *, UIColor *);

@interface BindingAccountController : BaseSetingViewController

@property (nonatomic, copy) ChangeSubTitleBlock changeSubTitleBlock;


@property (nonatomic, copy) NSString *shopId;

/**
 *  改变subTitle的block
 */
//- (void)changeSubTitleWithBlock:(ChangeSubTitleBlock)subTitle titleColor:(UIColor *)titleColor;
- (void)changeSubTitleWithBlock:(ChangeSubTitleBlock)subTitle;


@end
