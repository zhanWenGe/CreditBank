//
//  LineButton.m
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "LineButton.h"
#import "PrefixHeader.pch"

@interface LineButton()

/**
 *  左边按钮
 */
@property (nonatomic, weak) UIButton *leftButton;
/**
 *  中间
 */
@property (nonatomic, weak) UIButton *middleButton;
/**
 *  右边按钮
 */
@property (nonatomic, weak) UIButton *rightButton;

/**
 *  左边下划线
 */
@property (nonatomic, weak) UILabel *leftLine;
/**
 *  中间下划线
 */
@property (nonatomic, weak) UILabel *middleLine;
/**
 *  右边下划线
 */
@property (nonatomic, weak) UILabel *rightLine;
/**
 *  底部边线
 */
@property (nonatomic, weak) UILabel *footLine;



@end




@implementation LineButton


- (instancetype)initLineButton:(NSString *)leftButtonTitle middleBtton:(NSString *)middleButtonTitle rightButton:(NSString *)rightButtonTitle
{
    self = [super init];
    if (self) {
        [self setButton:leftButtonTitle middleBtton:middleButtonTitle rightButton:rightButtonTitle];
    }
    return self;
}

+ (instancetype)lineButtonTableView:(UITableView *)tableView leftButton:(NSString *)leftButtonTitle middleBtton:(NSString *)middleButtonTitle rightButton:(NSString *)rightButtonTitle
{
    LineButton *lineButton = [[LineButton alloc] initLineButton:leftButtonTitle middleBtton:middleButtonTitle rightButton:rightButtonTitle];
    return lineButton;
}

- (void)setButton:(NSString *)leftButtonTitle middleBtton:(NSString *)middleButtonTitle rightButton:(NSString *)rightButtonTitle
{
    // 左边的按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.selected = YES;
    [leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton setTitleColor:HDColor(5, 5, 5) forState:UIControlStateNormal];
    [leftButton setTitleColor:HDColor(213, 35, 27) forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    self.leftButton = leftButton;
    // 左边的下划线
    UILabel *leftLine = [[UILabel alloc] init];
    leftLine.backgroundColor = HDColor(250, 93, 92);
    [leftButton addSubview:leftLine];
    self.leftLine = leftLine;
    leftLine.hidden = NO;
    
    // 中间的按钮
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleButton setTitle:middleButtonTitle forState:UIControlStateNormal];
    middleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [middleButton setTitleColor:HDColor(5, 5, 5) forState:UIControlStateNormal];
    [middleButton setTitleColor:HDColor(213, 35, 27) forState:UIControlStateSelected];
    [middleButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:middleButton];
    self.middleButton = middleButton;
    // 中间的下划线
    UILabel *middleLine = [[UILabel alloc] init];
    middleLine.backgroundColor = HDColor(250, 93, 92);
    [middleButton addSubview:middleLine];
    self.middleLine = middleLine;
    middleLine.hidden = YES;
    
    // 右边的按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton setTitleColor:HDColor(5, 5, 5) forState:UIControlStateNormal];
    [rightButton setTitleColor:HDColor(213, 35, 27) forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    self.rightButton = rightButton;
    // 右边的下划线
    UILabel *rightLine = [[UILabel alloc] init];
    rightLine.backgroundColor = HDColor(250, 93, 92);
    [rightButton addSubview:rightLine];
    self.rightLine = rightLine;
    rightLine.hidden = YES;
    
    UILabel *footLine = [[UILabel alloc] init];
    footLine.backgroundColor = DEFALT_LINE_COLOR;
    [self addSubview:footLine];
    self.footLine = footLine;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 左边
    CGFloat leftButtonX = 0;
    CGFloat leftButtonY = 0;
    CGFloat leftButtonW = WIDTH / 3;
    CGFloat leftButtonH = 35;
    self.leftButton.frame = CGRectMake(leftButtonX, leftButtonY, leftButtonW, leftButtonH);

    CGFloat leftlineX = self.leftButton.titleLabel.frame.origin.x;
    CGFloat leftlineY = CGRectGetMaxY(self.leftButton.titleLabel.frame);
    CGFloat leftlineW = self.leftButton.titleLabel.frame.size.width;
    CGFloat leftlineH = 1;
    self.leftLine.frame = CGRectMake(leftlineX, leftlineY, leftlineW, leftlineH);
    
    // 中间
    CGFloat middleButtonX = CGRectGetMaxX(self.leftButton.frame);
    CGFloat middleButtonY = 0;
    CGFloat middleButtonW = WIDTH / 3;
    CGFloat middleButtonH = 35;
    self.middleButton.frame = CGRectMake(middleButtonX, middleButtonY, middleButtonW, middleButtonH);
    
    CGFloat middleLineX = self.middleButton.titleLabel.frame.origin.x;
    CGFloat middleLineY = CGRectGetMaxY(self.middleButton.titleLabel.frame);
    CGFloat middleLineW = self.middleButton.titleLabel.frame.size.width;
    CGFloat middleLineH = 1;
    self.middleLine.frame = CGRectMake(middleLineX, middleLineY, middleLineW, middleLineH);
    
    // 右边
    CGFloat rightButtonX = CGRectGetMaxX(self.middleButton.frame);
    CGFloat rightButtonY = 0;
    CGFloat rightButtonW = WIDTH / 3;
    CGFloat rightButtonH = 35;
    self.rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    
    CGFloat rightLineX = self.middleButton.titleLabel.frame.origin.x;
    CGFloat rightLineY = CGRectGetMaxY(self.middleButton.titleLabel.frame);
    CGFloat rightLineW = self.middleButton.titleLabel.frame.size.width;
    CGFloat rightLineH = 1;
    self.rightLine.frame = CGRectMake(rightLineX, rightLineY, rightLineW, rightLineH);
 
    // 最底部
    self.footLine.frame = CGRectMake(0, CGRectGetMaxY(self.leftButton.frame) - 0.5, WIDTH, 0.5);
}

- (void)buttonClicked:(UIButton *)btn
{
    btn.selected = YES;
    if ([self.delegate respondsToSelector:@selector(lineButtonClicked:button:index:)]) {
        if (btn == self.leftButton) {
            [self.delegate lineButtonClicked:self button:btn index:0];
            self.middleButton.selected = NO;
            self.rightButton.selected = NO;
            self.leftLine.hidden = NO;
            self.middleLine.hidden = YES;
            self.rightLine.hidden = YES;
        } else if (btn == self.middleButton) {
            [self.delegate lineButtonClicked:self button:btn index:1];
            self.leftButton.selected = NO;
            self.rightButton.selected = NO;
            self.leftLine.hidden = YES;
            self.middleLine.hidden = NO;
            self.rightLine.hidden = YES;
        } else if (btn == self.rightButton) {
            [self.delegate lineButtonClicked:self button:btn index:2];
            self.middleButton.selected = NO;
            self.leftButton.selected = NO;
            self.leftLine.hidden = YES;
            self.middleLine.hidden = YES;
            self.rightLine.hidden = NO;
        }
    }
}





@end
