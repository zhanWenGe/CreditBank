//
//  GameCell.m
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "GameCell.h"

#import "PrefixHeader.pch"
#import "ListModel.h"

@interface GameCell()

/**
 *  顶部长方形
 */
@property (nonatomic, weak) UIButton *topButton;
/**
 *  底部左边长方形
 */
@property (nonatomic, weak) UIButton *footLeftButton;
/**
 *  底部右边长方形
 */
@property (nonatomic, weak) UIButton *footRightButton;

/**
 *  顶部链接
 */
@property (nonatomic, copy) NSString *topLink;
/**
 *  底部左边链接
 */
@property (nonatomic, copy) NSString *footLeftLink;
/**
 *  底部右边链接
 */
@property (nonatomic, copy) NSString *footRightLink;

@property (nonatomic, strong) UIImageView *topImv;
@property (nonatomic, strong) UIImageView *footLeftImv;
@property (nonatomic, strong) UIImageView *footRightImv;


@end

@implementation GameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setButtonImageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.topImv = [[UIImageView alloc] init];
        self.footLeftImv = [[UIImageView alloc] init];
        self.footRightImv = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setButtonImageView
{
    // 顶部长方形
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:topButton];
    self.topButton = topButton;
    
    // 底部左边长方形
    UIButton *footLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footLeftButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:footLeftButton];
    self.footLeftButton = footLeftButton;
    
    // 底部右边长方形
    UIButton *footRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [footRightButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:footRightButton];
    self.footRightButton = footRightButton;
    
//    topButton.backgroundColor = HDColor(126, 112, 109);
//    footLeftButton.backgroundColor = HDColor(104, 31, 10);
//    footRightButton.backgroundColor = HDColor(86, 82, 134);
    [self.topButton setImage:[UIImage imageNamed:@"shimingzhaohuan"] forState:UIControlStateNormal];
    [self.footLeftButton setImage:[UIImage imageNamed:@"hongsejingjie"] forState:UIControlStateNormal];
    [self.footRightButton setImage:[UIImage imageNamed:@"shikuangzuqiu"] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // 顶部长方形
    CGFloat topButtonX = MALL_CELL_PADDIN;
    CGFloat topButtonY = 0;
    CGFloat topButtonW = WIDTH - 2 * MALL_CELL_PADDIN;
    CGFloat topButtonH = WIDTH * 87 / 300;
    self.topButton.frame = CGRectMake(topButtonX, topButtonY, topButtonW, topButtonH);
    
    // 底部左边长方形
    CGFloat footLeftButtonX = MALL_CELL_PADDIN;
    CGFloat footLeftButtonY = CGRectGetMaxY(self.topButton.frame) + MALL_CELL_PADDIN;
    CGFloat footLeftButtonW = (topButtonW - MALL_CELL_PADDIN) * 0.5;
    CGFloat footLeftButtonH = topButtonH;
    self.footLeftButton.frame = CGRectMake(footLeftButtonX, footLeftButtonY, footLeftButtonW, footLeftButtonH);
    
    // 底部右边长方形
    CGFloat footRightButtonX = CGRectGetMaxX(self.footLeftButton.frame) + MALL_CELL_PADDIN;
    CGFloat footRightButtonY = footLeftButtonY;
    CGFloat footRightButtonW = footLeftButtonW;
    CGFloat footRightButtonH = topButtonH;
    self.footRightButton.frame = CGRectMake(footRightButtonX, footRightButtonY, footRightButtonW, footRightButtonH);
    
}


+ (GameCell *)gameCellView:(UITableView *)tableView
{
    static NSString *ID = @"GameCell";
    GameCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[GameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)buttonClickedAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(gameButtonClickedAction:button:index:link:)]) {
        if (btn == self.topButton) {
            [self.delegate gameButtonClickedAction:self button:btn index:0 link:self.topLink];
            
        } else if (btn == self.footLeftButton) {
            [self.delegate gameButtonClickedAction:self button:btn index:1 link:self.footLeftLink];
            
        } else if (btn == self.footRightButton) {
            [self.delegate gameButtonClickedAction:self button:btn index:2 link:self.footRightLink];
            
        }
    }
}

- (void)setListModel:(ListModel *)listModel
{
    if (_listModel == listModel) {
        return;
    }
    
    _listModel = listModel;
    
    [self.topImv sd_setImageWithURL:[NSURL URLWithString:_listModel.top_cover] placeholderImage:[UIImage imageNamed:@"shimingzhaohuan"]];
    [self.topButton setImage:self.topImv.image forState:UIControlStateNormal];
    self.topLink = _listModel.top_link;

    [self.footLeftImv sd_setImageWithURL:[NSURL URLWithString:_listModel.left_cover] placeholderImage:[UIImage imageNamed:@"hongsejingjie"]];
    [self.footLeftButton setImage:self.footLeftImv.image forState:UIControlStateNormal];
    self.footLeftLink = _listModel.left_link;
    
    [self.footRightImv sd_setImageWithURL:[NSURL URLWithString:_listModel.right_cover] placeholderImage:[UIImage imageNamed:@"shikuangzuqiu"]];
    [self.footRightButton setImage:self.footRightImv.image forState:UIControlStateNormal];
    self.footRightLink = _listModel.right_link;
    
//    [self.topButton setImage:[UIImage imageNamed:@"shimingzhaohuan"] forState:UIControlStateNormal];
//    [self.footLeftButton setImage:[UIImage imageNamed:@"hongsejingjie"] forState:UIControlStateNormal];
//    [self.footRightButton setImage:[UIImage imageNamed:@"shikuangzuqiu"] forState:UIControlStateNormal];
    
}

@end