//
//  mallCell.h
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;

@protocol MallCellDelegate <NSObject>

@optional
- (void)mallButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link;

@end

@interface MallCell : UITableViewCell

@property (nonatomic, weak) id <MallCellDelegate> delegate;

@property (nonatomic, strong) ListModel *listModel;


+ (MallCell *)mallCellView:(UITableView *)tableView;

@end
