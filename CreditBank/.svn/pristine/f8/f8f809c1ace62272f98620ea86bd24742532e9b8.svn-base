//
//  TicketCell.h
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
@protocol TicketCellDelegate <NSObject>

@optional
- (void)tickButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link;


@end

@interface TicketCell : UITableViewCell

@property (nonatomic, weak) id <TicketCellDelegate> delegate;
@property (nonatomic, strong) ListModel *listModel;

+ (TicketCell *)tickCellView:(UITableView *)tableView;
@end
