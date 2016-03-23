//
//  UnlockView.m
//  滑动解锁-001
//
//  Created by Eric on 15/4/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "UnlockView.h"
#import "LockButton.h"
@interface UnlockView() <UIGestureRecognizerDelegate>
/**
 *  选中按钮的数组
 */
@property(nonatomic, strong) NSMutableArray *selectedButtons;
/**
 *  选中按钮的角度数组
 */
@property(nonatomic, strong) NSMutableArray *angleArray;
/**
 *  选中按钮的数组 验证失败提示
 */
@property(nonatomic, strong) NSArray *errSelectedButtons;
/**
 *  当前用户触摸的位置，在未触碰到下一个按钮的时候的位置
 */
@property(nonatomic, assign) CGPoint currentPoint;
/**
 *  当前用户触摸的位置，在未触碰到下一个按钮的时候的位置
 */
@property(nonatomic, assign) CGPoint prevPoint;
/**
 *  是否允许画当前线
 */
@property(nonatomic, assign, getter=isCurrentLine) BOOL currentLine;
/**
 *  是否允许画当前线
 */
@property(nonatomic, strong) UIColor *pathColor;
@end
@implementation UnlockView


/**
 *  xib 初始化
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

/**
 *  代码初始化
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}


/**
 *  选择
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)selectedButtons {
    
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    
    return _selectedButtons;
}

- (NSMutableArray *)angleArray {
    if (_angleArray == nil) {
        _angleArray = [NSMutableArray array];
    }
    return _angleArray;
}

- (UIColor *)pathColor {
    if (_pathColor == nil) {
        _pathColor = [UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5];
    }
    
    return  _pathColor;
}

#pragma mark 触摸手势相关

/**
 *  根据NSSet对象获取UITouch
 *
 *  @param touches <#touches description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)touchWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}


/**
 *  获取点击的按钮
 *
 *  @param point <#point description#>
 *
 *  @return <#return value description#>
 */
- (UIButton *) buttonWithPoint:(CGPoint )point {
    for (LockButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    
    return nil;
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前点
    CGPoint pos    = [self touchWithTouches:touches];
    
    // 获取当前触摸的按钮
    UIButton *btn  = [self buttonWithPoint:pos];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }
    
    [self setNeedsDisplay];
}

/**
 *  用户正在触摸中
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取当前点
    CGPoint pos    = [self touchWithTouches:touches];
    
    // 获取当前触摸的按钮
    LockButton *btn  = (LockButton *)[self buttonWithPoint:pos];
    
    if (btn && btn.selected == NO) {
        
        btn.selected = YES;
        
        if (self.selectedButtons.count > 0) {
            LockButton *prvBtn = [self.selectedButtons lastObject];
            NSString *angle = [self getPointAngle:prvBtn.center endPoint:btn.center];
            [self.angleArray addObject:angle];
        }
        [self.selectedButtons addObject:btn];

        
    }else {
        // 记录最新触摸位置
        self.currentPoint = pos;
    }

    self.currentLine = YES;
    [self setNeedsDisplay];
    
}

- (NSString *)getPointAngle:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    if (endPoint.y > startPoint.y) {
                // 上
        if (endPoint.x == startPoint.x) {
            // 正下方
            return @"180";
        } else if(endPoint.x < startPoint.x) {
            // 下左方
            return @"-135";
        } else if(endPoint.x > startPoint.x) {
            // 下右方
            return @"135";
        }
    } else if (endPoint.y < startPoint.y) {
        // 下
        if (endPoint.x == startPoint.x) {
            // 上方
            return @"0";
        } else if(endPoint.x > startPoint.x) {
            // 右上方
            return @"45";
        } else if(endPoint.x < startPoint.x) {
            // 左上方
            return @"-45";
        }
    } else  {
        
        if (endPoint.x > startPoint.x) {
            // 右侧
            return @"90";
        } else {
            // 左侧
            return @"-90";
        }
    }
    return @"";
}

/**
 *  用户触摸结束
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    // 保存当前的手势轨迹，用于显示错误信息
    self.errSelectedButtons = self.selectedButtons;
    
    // 绘图密码成功
    if ([self.delegate respondsToSelector:@selector(UnlockView:didFinishPath:)]) {
        
        NSMutableString *path = [NSMutableString string];
        for (LockButton *btn in self.selectedButtons) {
            [path appendFormat:@"%ld", (long)btn.tag];
        }
        
        [self.delegate UnlockView:self didFinishPath:path];
    }
    
    
    self.currentLine = NO;
}

/**
 *  用户触摸被打断
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


/**
 *  系统绘图函数
 *
 *  @param rect <#rect description#>
 */
- (void)drawRect:(CGRect)rect {
    
    if (!self.selectedButtons.count) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth     = 2;
    
    [self.pathColor set];
    
    // 连线最新按钮
    for (int index = 0; index < self.selectedButtons.count; index++) {
        
        LockButton *btn = self.selectedButtons[index];
        
        if (index == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 连线最新的点
    if (self.isCurrentLine) [path addLineToPoint:self.currentPoint];
    
    [path stroke];

}

-(void)clearAll;
{
    // 所有按钮状态取消
    for (LockButton *btn in self.selectedButtons) {
        btn.selected = NO;
    }
    
    [self.selectedButtons removeAllObjects];
    [self.angleArray removeAllObjects];
    [self setNeedsDisplay];
}

/**
 *  切换原始图片
 *
 *  @param image <#image description#>
 */
- (void)buttonChangeDefaultBackImage {
    for (LockButton *btn in self.selectedButtons) {
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [btn setBordeColorDefault];
    }

}

/**
 *  切换失败的图片
 *
 *  @param image <#image description#>
 */
- (void)buttonChangeErrorBackImage {
    for (int i = 0; i < self.selectedButtons.count; i++) {
        
        LockButton *btn;
        NSString *path;
        
        if (i + 1 >= self.selectedButtons.count) {
            btn    = (LockButton *)self.selectedButtons[i];
            path   = @"gesture_node_fail_default";
        } else {
            NSString *angle = self.angleArray[i];
            btn = (LockButton *)self.selectedButtons[i];
            path   = [NSString stringWithFormat:@"gesture_node_fail_%@", angle];
        }

        UIImage  *image  = [UIImage imageNamed:path];
        [btn setBackgroundImage:image forState:UIControlStateSelected];
        [btn setBordeColorError];

    }
    
}

/**
 *  验证失败提示
 *
 *  @param color <#color description#>
 */
- (void)didFailPath{
    
    // 设置要显示失败的按钮
    self.selectedButtons =  (NSMutableArray *)self.errSelectedButtons;
    
    // 设置要显示失败线的颜色
    self.pathColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    // 设置要显示按钮的图片
    [self buttonChangeErrorBackImage];
    
    [self setNeedsDisplay];
    
    // 0.5秒后还原
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         self.pathColor = nil;
         [self buttonChangeDefaultBackImage];
         [self clearAll];
    });
}


#pragma mark 初始化子控件

/**
 *  初始化子控件
 */
- (void) setUpSubviews {
    for (int i = 0; i < 9; i++) {
        LockButton *btn = [LockButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [self addSubview:btn];
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        CGFloat BtnW = 70;
        CGFloat BtnH = 70;
        
        int totalColumns = 3;
        int totalRowumns = 3;
        
        // 计算当前按钮在哪一列
        int col = i % totalColumns;
        
        // 计算当前位置在哪一行
        int row = i / totalColumns;
        
        // 算法是先列，后行
        CGFloat marginX = (self.frame.size.width - totalColumns * BtnW) / (totalColumns  + 1);
        CGFloat marginY = (self.frame.size.height - totalRowumns * BtnH) / (totalRowumns  + 1);
        
        // 间距 + 列 * (按钮宽度 + 行间距)
        CGFloat BtnX = marginX + col * (BtnW + marginX);
        
        // 行间距 + 行数 * (按钮高度 + 列间距)
        CGFloat BtnY = marginY + row  * (BtnH + marginY);
        
        LockButton *btn = (LockButton *)self.subviews[i];
        btn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
        // 圆角
        self.layer.cornerRadius = BtnH / 2;
        
    }
}


@end
