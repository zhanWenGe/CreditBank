//
//  SettingArrowItem.h
//  001-caipiao
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
/**
 *  跳转控制器
 */
@property(nonatomic, assign) Class controller;

+ (instancetype) arrowItemWithIcon:(NSString *)icon title:(NSString *)title pushController:(Class) controller;
+ (instancetype) arrowItemWithTitle:(NSString *)title pushController:(Class) controller;

@end
