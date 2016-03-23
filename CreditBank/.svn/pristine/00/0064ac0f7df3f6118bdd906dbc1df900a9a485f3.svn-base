//
//  IndexCell.h
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//  积分上半部分的Cell


#import <UIKit/UIKit.h>
@class IndexF;
@class IndexCell;

@protocol IndexCellDelegate <NSObject>
@optional
// 问号按钮
- (void)IndexCell:(IndexCell *)cell helpBtnClick:(UIButton *)btn;

// 赚取积分按钮
- (void)IndexCell:(IndexCell *)cell recommendBtnClick:(UIButton *)btn;

// 立即查看
- (void)IndexCell:(IndexCell *)cell importPromptBtnClick:(UIButton *)btn;
@end

@interface IndexCell : UITableViewCell

/**
 *  cell 模型数据和高度缓存
 */
@property(nonatomic, strong) IndexF *indexFrame;

/**
 *  代理
 */
@property(nonatomic, weak) id <IndexCellDelegate>  delegate;

/**
 *  初始化自定义Cell方法
 */
+ (instancetype) indexCellWithTableView:(UITableView *)tableview;

/**
 *  导入积分的提示View
 */
@property(nonatomic, weak) UIView   *importPromptView;

///**
// *  积分数量
// */
//@property(nonatomic, weak) UILabel     *integralLabel;
@end
