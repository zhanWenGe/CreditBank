//
//  settingCell.h
//  001-caipiao
//
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;

@interface SettingCell : UITableViewCell
@property(nonatomic, strong) SettingItem *item;



+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

