//
//  settingItem.m
//  001-caipiao
//
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SettingItem.h"
@class UIColor;

@implementation SettingItem
/**
 *  设置选项的图标和标题
 */
+ (instancetype) itemWithIcon:(NSString *)icon title:(NSString *)title {
    return [[self alloc] initWithIcon:icon title:title];
}
/**
 *  设置选项的图标和标题
 */
- (instancetype) initWithIcon:(NSString *)icon title:(NSString *)title {
    if (self = [super init]) {
        _title = title;
        _icon  = icon;
    }
    
    return self;
}


/**
 *  设置选项的图标和标题
 */
+ (instancetype) itemWithLabel:(NSString *)labelTitle title:(NSString *)title {
    return [[self alloc] initWithLabel:labelTitle title:title];
}

/**
 *  设置行标题和自定义Label的标题
 */
- (instancetype) initWithLabel:(NSString *)labelTitle title:(NSString *)title {
    if (self = [super init]) {
        _labelTitle = labelTitle;
        _title = title;
    }
    
    return self;
}

/**
 *  只初始化标题的Item
 */
+ (instancetype) itemWithTitle:(NSString *)title {
    return [self itemWithIcon:nil title:title];
}


@end
