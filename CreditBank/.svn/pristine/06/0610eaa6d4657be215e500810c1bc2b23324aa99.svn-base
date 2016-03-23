//
//  settingCell.m
//  001-caipiao
//
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "settingArrowItem.h"
#import "settingSwitchItem.h"
#import "SetttingLabelItem.h"
#import "PrefixHeader.pch"

@interface SettingCell()
/**
 *  右侧箭头的View，懒加载模式只加载一次
 *  这里使用strong 是因为这个控件没有初始化在view上
 *  用weak 创建完就自动销毁了
 */
@property(nonatomic, strong) UIImageView *arrowImageView;


/**
 *  右侧箭头的开关，懒加载模式只加载一次
 *  这里使用strong 是因为这个控件没有初始化在view上
 *  用weak 创建完就自动销毁了
 */
@property(nonatomic, strong) UISwitch *switchView;

/**
 *  右侧显示自定义Label,懒加载模式
 *  这里使用strong 是因为这个空间没有初始化在View上
 *  用weak 创建完毕就销毁了
 */
@property(nonatomic, strong) UILabel  *labelView;
/**
 *  右侧图片，懒加载模式只加载一次
 */
@property(nonatomic, strong) UIImageView *rightImageView;

/**
 *  自定义View
 */
@property(nonatomic, strong) UIView  *customView;
@end

@implementation SettingCell


- (UIImageView *) arrowImageView {
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellarrow"]];
    }
    
    return _arrowImageView;
}

- (UIImageView *) rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.hidden = YES;
    }
    
    return _rightImageView;
}

- (UISwitch *) switchView {
    if(_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChangeEvent) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchView;
}


- (UILabel *) labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.textAlignment = NSTextAlignmentRight;
        _labelView.font = [UIFont systemFontOfSize:14.0];
    }
    
    return _labelView;
}

- (UIView *)customView {
    if (_customView == nil) {
        _customView = [[UIView alloc] init];
    }
    
    return _customView;
}

/**
 *  设置的开关数据存储
 *  key => self.item.title
 */
- (void) switchChangeEvent {
    NSUserDefaults *UserDefault =  [NSUserDefaults standardUserDefaults];
    [UserDefault setBool:_switchView.on forKey:self.item.title];
    [UserDefault synchronize];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
          // cell 右侧自定义图片
          [self.contentView addSubview:self.rightImageView];
        
         // 自定义View
          [self.contentView addSubview:self.customView];
        
    }
    
    return  self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (self.item.rightImage || self.item.rightImageView) {
        // 设置右侧图像
        CGFloat margin = 25;
        CGFloat imageW = 50;
        CGFloat imageH = 50;
        CGFloat imageX = self.frame.size.width - imageW - self.accessoryView.frame.size.width - margin;
        CGFloat imageY = (self.frame.size.height - imageH) * 0.5;
        self.rightImageView.layer.cornerRadius  = imageW / 2.0;
        self.rightImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    if (self.item.customView) {
        // 自定义View
        CGFloat customViewX = 0;
        CGFloat customViewY = 0;
        CGFloat customViewW = self.frame.size.width;
        CGFloat customViewH = self.frame.size.height;
        self.customView.frame = CGRectMake(customViewX, customViewY, customViewW, customViewH);

    }

}

/**
 *  settingCell 初始化方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"settting";
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.font       = [UIFont systemFontOfSize:15.0];
        
    }
    return cell;
}


/**
 *  初始化数据
 */
- (void)setItem:(SettingItem *)item {
    _item = item;
    
    // 1、设置数据
    [self setupData];
    
    // 2、设置右侧区域
    [self setupRightContent];
}

/**
 *  设置右侧区域控制
 */
- (void)setupRightContent {
    
    // 箭头
    if ([self.item isKindOfClass:[SettingArrowItem class]]) {

        self.accessoryView = self.arrowImageView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    } else if ([self.item isKindOfClass:[SettingSwitchItem class]]) {
        
        // 开关
        self.accessoryView = self.switchView;
        
        // 开关没有选中效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 读取存储的数据
        NSUserDefaults *UserDefault = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [UserDefault boolForKey:self.item.title];
        
    } else if ([self.item isKindOfClass:[SetttingLabelItem class]]) {
        
        // Label
        self.accessoryView = self.labelView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

        // 读取存储的数据
        NSUserDefaults *UserDefault = [NSUserDefaults standardUserDefaults];
        NSString *dateString = [UserDefault objectForKey:self.item.title];
        
        if (dateString) {
            self.labelView.text = dateString;
        }
        
    } else {
        // 默认为空，必须写（循环利用问题）
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    // 设置cell 自带label标题颜色
    if (self.item.titleColor) {
        self.textLabel.textColor = self.item.titleColor;
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
    
    // 设置 cell desctionTextLabel 颜色
    if (self.item.subTitleColor) {
        self.detailTextLabel.textColor = self.item.subTitleColor;
    } else {
        self.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    // 添加右侧图像
    if (self.item.rightImage) {
        self.rightImageView.hidden = NO;
    } else {
        self.rightImageView.hidden = YES;
    }
    
    if (self.item.rightImageView) {
        self.rightImageView.hidden = NO;
    } else {
        self.rightImageView.hidden = YES;
    }
    
    // 自定义View
    if (self.item.customView) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.customView.hidden = NO;
    } else {
         self.customView.hidden = YES;
    }
}


- (void)setupData {
    
    // cell 默认图片
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    // cell 自带label标题
    self.textLabel.text = self.item.title;
    
    // cell 自定义label
    if (self.item.labelTitle) {
        self.labelView.text = self.item.labelTitle;
    }
    
    // cell 副标题
    if (self.item.subTitle) {
        self.detailTextLabel.text = self.item.subTitle;
    }

    // 自定义右侧图片
    if (self.item.rightImage) {
        self.rightImageView.image = [UIImage imageNamed:self.item.rightImage];
    }
    
    // 自定义右侧图片View
    if (self.item.rightImageView) {
        [self.rightImageView addSubview:self.item.rightImageView];
    }
    
    // 自定义View
    if (self.item.customView) {
        [self.customView addSubview:self.item.customView];
    }
}

@end

