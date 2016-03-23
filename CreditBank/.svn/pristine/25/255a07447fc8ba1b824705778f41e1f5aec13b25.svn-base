//
//  settingItem.h
//  001-caipiao
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SettingItem;
/**
 *  定义事件回调block
 */
typedef void (^SettingOption)(SettingItem *);

@interface SettingItem : NSObject
/**
 *  图标
 */
@property(nonatomic, copy) NSString *icon;
/**
 *  显示的标题
 */
@property(nonatomic, copy) NSString *title;
/**
 *  标题颜色
 */
@property(nonatomic, strong) UIColor *titleColor;

/**
 *  右侧自定义Label的标题
 */
@property(nonatomic, copy) NSString *labelTitle;

/**
 *  右侧自定义ImageView的图片
 */
@property(nonatomic, copy) NSString *rightImage;

/**
 *  右侧自定义ImageView
 */
@property(nonatomic, strong) UIImageView *rightImageView;

/**
 *  Cell的副标题
 */
@property(nonatomic, copy) NSString *subTitle;
/**
 *  Cell的副标题颜色
 */
@property(nonatomic, strong) UIColor *subTitleColor;
/**
 *  当用户点击当前cell调用这个block函数
 */
@property(nonatomic, copy) SettingOption option;
/**
 *  cell的高度
 */
@property(nonatomic, assign) CGFloat  height;



/**
 *  自定义View
 */
@property(nonatomic, strong) UIView  *customView;


/**
 *  初始化带图片和标题的Item
 */
+ (instancetype) itemWithIcon:(NSString *)icon title:(NSString *)title;

/**
 *  初始化自定义Label和标题的Item
 */
+ (instancetype) itemWithLabel:(NSString *)labelTitle title:(NSString *)title;

/**
 *  初始化自定义Label和标题的Item
 */
+ (instancetype) itemWithTitle:(NSString *)title;
@end

