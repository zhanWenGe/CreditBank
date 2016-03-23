//
//  IndexModuleCell.h
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//  积分页模块cell


#import <UIKit/UIKit.h>
@class IndexModuleF;
@class IndexModuleCell;
@class ModuleButton;

@protocol IndexModuleCellDelegate <NSObject>

@optional
- (void)cell:(IndexModuleCell *)cell btnClick:(ModuleButton *) btn;
@end

@interface IndexModuleCell : UITableViewCell
/**
 *  代理对象
 */
@property(nonatomic, weak)  id <IndexModuleCellDelegate> delegate;
/**
 *  frame模型
 */
@property(nonatomic, strong) IndexModuleF *indexModuleF;
/**
 *  frame模型数组
 */
@property(nonatomic, strong) NSArray *data;
/**
 *  初始化自定义Cell方法
 */
+ (instancetype) indexModuleCellWithTableView:(UITableView *)tableview moduleCount:(NSInteger)count;
@end
