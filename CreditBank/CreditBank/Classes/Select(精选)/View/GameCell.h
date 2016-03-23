//
//  GameCell.h
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
@protocol GameCellDelegate <NSObject>

@optional
- (void)gameButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link;
@end

@interface GameCell : UITableViewCell

@property (nonatomic, weak)  id <GameCellDelegate> delegate;

@property (nonatomic, strong) ListModel *listModel;
+ (GameCell *)gameCellView:(UITableView *)tableView;

@end
