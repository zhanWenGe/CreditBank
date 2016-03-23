//
//  TicketCell.m
//  CreditBank
//
//  Created by Eric on 15/4/25.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "TicketCell.h"
#import "PrefixHeader.pch"
#import "ListModel.h"

@interface TicketCell()


/**
 *  顶部长方形
 */
@property (nonatomic, weak) UIButton *topButton;
/**
 *  底部方形
 */
@property (nonatomic, weak) UIButton *footButton;
/**
 *  顶部链接
 */
@property (nonatomic, copy) NSString *topLink;
/**
 *  底部链接
 */
@property (nonatomic, copy) NSString *footLink;

@property(nonatomic, strong) UIImageView *footImv;
@property(nonatomic, strong) UIImageView *topImv;
@end

@implementation TicketCell

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
    // 顶部长方形
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:topButton];
    self.topButton = topButton;
    
    // 底部长方形
    UIButton *footButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [footButton addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:footButton];
    self.footButton = footButton;
    
//    topButton.backgroundColor = HDColor(20, 127, 183);
//    footButton.backgroundColor = HDColor(128, 127, 135);
    [self.topButton setImage:[UIImage imageNamed:@"chaonengluzhandui"] forState:UIControlStateNormal];
    [self.footButton setImage:[UIImage imageNamed:@"MuchAdoAboutNothing"] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //右上方长方形
    CGFloat topButtonX =  MALL_CELL_PADDIN;
    CGFloat topButtonY = 0;
    CGFloat topButtonW = WIDTH - 2 * MALL_CELL_PADDIN;
    CGFloat topButtonH = WIDTH * 87 / 300;
    self.topButton.frame = CGRectMake(topButtonX, topButtonY, topButtonW, topButtonH);
    
    //右下长方形
    CGFloat footButtonX = topButtonX;
    CGFloat footButtonY = CGRectGetMaxY(self.topButton.frame) + MALL_CELL_PADDIN;
    CGFloat footButtonW = topButtonW;
    CGFloat footButtonH = topButtonH;
    self.footButton.frame = CGRectMake(footButtonX, footButtonY, footButtonW, footButtonH);
    
}


+ (TicketCell *)tickCellView:(UITableView *)tableView
{
    static NSString *ID = @"TicketCell";
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)buttonClickedAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tickButtonClickedAction:button:index:link:)]) {
        if (btn == self.topButton) {
            [self.delegate tickButtonClickedAction:self button:btn index:0 link:self.topLink];
        
        } else if (btn == self.footButton) {
            [self.delegate tickButtonClickedAction:self button:btn index:1 link:self.footLink];
            
        }
    }
}

- (void)setListModel:(ListModel *)listModel
{
    if (_listModel == listModel) {
        return;
    }
    _listModel = listModel;
    
    UIImageView *topImv = [[UIImageView alloc] init];
    [topImv sd_setImageWithURL:[NSURL URLWithString:_listModel.top_cover] placeholderImage:[UIImage imageNamed:@"chaonengluzhandui"]];
    
    [self.topButton setImage:topImv.image forState:UIControlStateNormal];
    self.topLink = _listModel.top_link;
    self.topImv = topImv;

    
    UIImageView *footImv = [[UIImageView alloc] init];
    [footImv sd_setImageWithURL:[NSURL URLWithString:_listModel.bottom_cover] placeholderImage:[UIImage imageNamed:@"MuchAdoAboutNothing"]];
    [self.footButton setImage:footImv.image forState:UIControlStateNormal];
    
    self.footLink = _listModel.bottom_link;
    self.footImv = footImv;
}

@end
