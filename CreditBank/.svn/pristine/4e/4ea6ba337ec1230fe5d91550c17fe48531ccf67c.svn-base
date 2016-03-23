//
//  SettingArrowItem.m
//  001-caipiao
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem

+ (instancetype) arrowItemWithIcon:(NSString *)icon title:(NSString *)title pushController:(Class) controller {
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.controller = controller;
    return item;
}


+ (instancetype) arrowItemWithTitle:(NSString *)title pushController:(Class) controller {
    SettingArrowItem *item = [self itemWithTitle:title];
    item.controller = controller;
    return item;
}
@end
