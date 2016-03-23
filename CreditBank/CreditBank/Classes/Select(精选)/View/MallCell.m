//
//  mallCell.m
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "MallCell.h"
#import "PrefixHeader.pch"
#import "ListModel.h"

@interface MallCell()

/**
 *  左边正方形
 */
@property (nonatomic, weak) UIButton *leftButton;
/**
 *  右上方长方形
 */
@property (nonatomic, weak) UIButton *rightTopButton;
/**
 *  右下长方形
 */
@property (nonatomic, weak) UIButton *rightFootButton;

/**
 *  左边正方形链接
 */
@property (nonatomic, copy) NSString *leftLink;
/**
 *  右上方长方形链接
 */
@property (nonatomic, copy) NSString *rightTopLink;
/**
 *  右下长方形链接
 */
@property (nonatomic, copy) NSString *rightFootLink;
/**
 *  保存网络图片容器
 */
@property(nonatomic, strong) UIImageView *leftimV;
@property(nonatomic, strong) UIImageView *rightTopImV;
@property(nonatomic, strong) UIImageView *rightFootImV;

@end

@implementation MallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setButtonImageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setButtonImageView
{
    //左边正方形
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftButton];
    self.leftButton = leftButton;
    
    //右上方长方形
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightTopButton];
    self.rightTopButton = rightTopButton;
    
    //右下长方形
    UIButton *rightFootButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightFootButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightFootButton];
    self.rightFootButton = rightFootButton;
    
//    leftButton.backgroundColor = HDColor(249, 164, 41);
//    rightTopButton.backgroundColor = HDColor(247, 61, 76);
//    rightFootButton.backgroundColor = HDColor(85, 99, 132);
    [self.leftButton setImage:[UIImage imageNamed:@"shishangbiaodai"] forState:UIControlStateNormal];
    [self.rightTopButton setImage:[UIImage imageNamed:@"zhinengfenshan"] forState:UIControlStateNormal];
    [self.rightFootButton setImage:[UIImage imageNamed:@"jiatingyingxiang"] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //左边正方形
    CGFloat leftButtonX = MALL_CELL_PADDIN;
    CGFloat leftButtonY = 0;
    CGFloat leftButtonW = (WIDTH - 3 * MALL_CELL_PADDIN) * 0.5;
    CGFloat leftButtonH = leftButtonW;
    self.leftButton.frame = CGRectMake(leftButtonX, leftButtonY, leftButtonW, leftButtonH);
    self.leftimV.frame = CGRectMake(0, 0, leftButtonW, leftButtonH);
    
    //右上方长方形
    CGFloat rightTopButtonX = CGRectGetMaxX(self.leftButton.frame) + MALL_CELL_PADDIN;
    CGFloat rightTopButtonY = 0;
    CGFloat rightTopButtonW = leftButtonW;
    CGFloat rightTopButtonH = (leftButtonW - MALL_CELL_PADDIN) * 0.5;
    self.rightTopButton.frame = CGRectMake(rightTopButtonX, rightTopButtonY, rightTopButtonW, rightTopButtonH);
    self.rightTopImV.frame = CGRectMake(0, 0, rightTopButtonW, rightTopButtonH);
    
    //右下长方形    
    CGFloat rightFootButtonX = CGRectGetMaxX(self.leftButton.frame) + MALL_CELL_PADDIN;
    CGFloat rightFootButtonY = CGRectGetMaxY(self.rightTopButton.frame) + MALL_CELL_PADDIN;
    CGFloat rightFootButtonW = leftButtonW;
    CGFloat rightFootButtonH = (leftButtonW - MALL_CELL_PADDIN) * 0.5;
    self.rightFootButton.frame = CGRectMake(rightFootButtonX, rightFootButtonY, rightFootButtonW, rightFootButtonH);
    self.rightFootImV.frame = CGRectMake(0, 0, rightFootButtonW, rightFootButtonH);

}


+ (MallCell *)mallCellView:(UITableView *)tableView
{
    static NSString *ID = @"MallCell";
    MallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)buttonClickedAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(mallButtonClickedAction:button:index:link:)]) {
        if (btn == self.leftButton) {
            [self.delegate mallButtonClickedAction:self button:btn index:0 link:self.leftLink];
            
        } else if (btn == self.rightTopButton) {
            [self.delegate mallButtonClickedAction:self button:btn index:1 link:self.rightTopLink];
            
        } else if (btn == self.rightFootButton) {
            [self.delegate mallButtonClickedAction:self button:btn index:2 link:self.rightFootLink];
            
        }
    }
}

- (void)setListModel:(ListModel *)listModel
{
    if (_listModel == listModel) {
        return;
    }
    
    _listModel = listModel;
    
    // 左侧图片
    UIImageView *leftimV = [[UIImageView alloc] init];
    
    [leftimV sd_setImageWithURL:[NSURL URLWithString:_listModel.left_cover] placeholderImage:[UIImage imageNamed:@"shishangbiaodai"]];
    [self.leftButton.imageView addSubview:leftimV];
    
    self.leftimV = leftimV;
    self.leftLink = _listModel.left_link;
    
    // 右侧上部图片
    UIImageView *rightTopImV = [[UIImageView alloc] init];
    [rightTopImV sd_setImageWithURL:[NSURL URLWithString:_listModel.right_cover] placeholderImage:[UIImage imageNamed:@"zhinengfenshan"]];
    
    [self.rightTopButton.imageView addSubview:rightTopImV];
    self.rightTopLink = _listModel.right_link;
    
    self.rightTopImV = rightTopImV;
    
    // 右侧下部图片
    UIImageView *rightFootImV = [[UIImageView alloc] init];
    [rightFootImV sd_setImageWithURL:[NSURL URLWithString:_listModel.right_bottom_cover] placeholderImage:[UIImage imageNamed:@"jiatingyingxiang"]];
    
    [self.rightFootButton addSubview:rightFootImV];
    self.rightFootLink = _listModel.right_bottom_link;
    self.rightFootImV = rightFootImV;
 
}

@end
