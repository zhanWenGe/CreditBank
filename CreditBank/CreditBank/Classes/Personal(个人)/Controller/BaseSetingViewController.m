//
//  settingViewController.m
//  001-caipiao
//
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//




#import "BaseSetingViewController.h"
#import "SettingItem.h"
#import "settingGroup.h"
#import "settingSwitchItem.h"
#import "SettingArrowItem.h"
#import "settingCell.h"
#import "PrefixHeader.pch"
@implementation BaseSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = DEFALT_BG;
    
}
#pragma mark -- init 初始化函数
/**
 *  重写init 初始Style就是分组
 */
- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

/**
 *  重写 initWithStyle 初始style就是分组
 */
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}


#pragma mark -- data

- (NSArray *)data {
    if (_data == nil) {
        _data = [NSMutableArray array];
        [self setUpData];
    }
    return _data;
}

- (void)setUpData {
    
}


#pragma mark -- Tableview DataSorce
/**
 *  section 包含行数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    settingGroup *group = self.data[section];
    return group.items.count;
}

/**
 *  tableview 包含几个 section
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

/**
 *  cell 创建
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    
    settingGroup *group = self.data[indexPath.section];
    SettingItem  *item  = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
    
    
}


#pragma mark -- TableView Delegate
/**
 *  选中事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1、取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2、数据模型
    settingGroup *group = self.data[indexPath.section];
    SettingItem  *item  = group.items[indexPath.row];
    
    // 调用item的事件处理
    if (item.option) {
        item.option(item);
    } else if ([item isKindOfClass:[SettingArrowItem class]]) {
        
        // 只有带箭头的设置选项才能跳转
        SettingArrowItem *pushItem = (SettingArrowItem *)item;
        if (pushItem.controller != nil) {
            
            UIViewController *vc = [[pushItem.controller alloc] init];
            vc.title = pushItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}

/**
 *  设置每一行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    settingGroup *group = self.data[indexPath.section];
    SettingItem  *item  = group.items[indexPath.row];
    if (item.height) {
        return item.height;
    }
    return 44;
}
/**
 *  设置组的footer提示
 */
- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    settingGroup *group = self.data[section];
    return group.footer;
}

/**
 *  设置组的header提示
 */
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    settingGroup *group = self.data[section];
    return group.header;
}

@end
