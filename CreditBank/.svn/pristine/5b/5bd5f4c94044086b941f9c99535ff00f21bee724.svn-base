//
//  IndexCell.m
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "IndexCell.h"
#import "IndexF.h"
#import "IndexM.h"
#import "PrefixHeader.pch"

@interface IndexCell()
/**
 *  总积分图标
 */
@property(nonatomic, weak) UIImageView *totalImageView;
/**
 *  总积分文案
 */
@property(nonatomic, weak) UILabel     *totalIntegralLabel;
/**
 *  问号按钮
 */
@property(nonatomic, weak) UIButton    *helpBtn;
/**
 *  积分数量
 */
@property(nonatomic, weak) UILabel     *integralLabel;
/**
 *  分割线
 */
@property(nonatomic, weak) UIView     *lineView;
/**
 *  推荐Label
 */
@property(nonatomic, weak) UILabel    *recommendLabel;
/**
 *  推荐按钮下面的View
 */
@property(nonatomic, weak) UIView    *recommendBtnBlowView;

/**
 *  推荐详情按钮
 */
@property(nonatomic, weak) UIButton   *recommendBtn;
/**
 *  导入积分的提示Label
 */
@property(nonatomic, weak) UILabel   *importPromptLabel;
/**
 *  导入积分的提示Btn
 */
@property(nonatomic, weak) UIButton   *importPromptBtn;


@end

@implementation IndexCell

/**
 *  封装复用方法
 *
 *  @param tableview <#tableview description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype) indexCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"IndexCell";
    
    IndexCell *cell = (IndexCell *)[tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}

/**
 *  重写 initWithStyle, 增加子控件
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubviews];
        
//        // 注册积分改变通知
//        NSNotificationCenter *noticCenter = [NSNotificationCenter defaultCenter];
//        [noticCenter addObserver:self selector:@selector(notificationAction:) name:@"changeCredit" object:nil];
        
    }
    
    return self;
}

//- (void)notificationAction:(NSNotification *)notification
//{
//    NSString *str = [notification.userInfo objectForKey:@"credit"];
//    self.integralLabel.text = str;
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  加载子控件
 */
- (void) setUpSubviews {
    
    self.backgroundColor = HDColor(250, 93, 93);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 1、积分图标
    UIImageView *totalImageView = [[UIImageView alloc] init];
    totalImageView.image = [UIImage imageNamed:@"total_integral"];
    [self addSubview:totalImageView];
    self.totalImageView = totalImageView;
    
    // 2、总积分
    UILabel *totalIntegralLabel  = [[UILabel alloc] init];
    totalIntegralLabel.text      = @"总积分";
    totalIntegralLabel.font      = [UIFont systemFontOfSize:12.0];
    totalIntegralLabel.textColor = [UIColor whiteColor];
    [self addSubview:totalIntegralLabel];
    self.totalIntegralLabel = totalIntegralLabel;
    
    // 3、line
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HDColor(250, 122, 100);
    
    [self addSubview:lineView];
    self.lineView    = lineView;
    
    
    // 4、问号按钮
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [helpBtn setBackgroundImage:[UIImage imageNamed:@"index_help"] forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(helpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:helpBtn];
    self.helpBtn  = helpBtn;
    
    // 5、积分数
    UILabel *integralLabel  = [[UILabel alloc] init];
//    integralLabel.text      = @"998,54";
    integralLabel.font      = [UIFont systemFontOfSize:32];
    integralLabel.textColor = [UIColor whiteColor];
    [self addSubview:integralLabel];
    self.integralLabel = integralLabel;
    
    // 6、推荐label
    UILabel *recommendLabel  = [[UILabel alloc] init];
    recommendLabel.font      = [UIFont systemFontOfSize:12.0];
    recommendLabel.textColor = [UIColor whiteColor];
//    recommendLabel.text = @"[推荐] 按照预案，“五一”期间如果出现大客流情况，警方将采取措施使客流南北均衡，尽量利用外滩两公里长的区域对客流进行“蓄水”，减少局部区域的拥堵。";
    [self addSubview:recommendLabel];
    self.recommendLabel = recommendLabel;
    
    // 推荐按钮下面的视图(用于遮挡动画视图)
    UIView *recommendBtnBlowView = [[UIView alloc] init];
    recommendBtnBlowView.backgroundColor = HDColor(250, 93, 93);
    [self addSubview:recommendBtnBlowView];
    self.recommendBtnBlowView = recommendBtnBlowView;

    
    // 7、赚取积分Btn
    UIButton *recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendBtn addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [recommendBtn setTitle:@"赚取积分" forState:UIControlStateNormal];
    recommendBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    recommendBtn.layer.cornerRadius = 4;
    recommendBtn.layer.borderColor  = [UIColor whiteColor].CGColor;
    recommendBtn.layer.borderWidth  = 1;
    [self addSubview:recommendBtn];
    self.recommendBtn = recommendBtn;
    
    // 8、导入积分的Box
    UIView *importPromptView = [[UIView alloc] init];
    importPromptView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:246/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:importPromptView];
    self.importPromptView = importPromptView;
    
    // 9、提示导入积分Label
    UILabel *importPromptLabel = [[UILabel alloc] init];
//    importPromptLabel.text =  @"用户张强信用卡有积分可导入...";
    importPromptLabel.font = [UIFont systemFontOfSize:12.0];
    [self.importPromptView addSubview:importPromptLabel];
    self.importPromptLabel = importPromptLabel;
    
    // 10、提示导入积分Btn
    UIButton *importPromptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [importPromptBtn addTarget:self action:@selector(importPromptClick:) forControlEvents:UIControlEventTouchUpInside];

    [importPromptBtn setTitle:@"立即查看" forState:UIControlStateNormal];
    importPromptBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [importPromptBtn setTitleColor:HDColor(254, 87, 53) forState:UIControlStateNormal];
    
    [self.importPromptView addSubview:importPromptBtn];
    self.importPromptBtn = importPromptBtn;
    
}

#pragma mark 事件代理调用方法

- (void)helpBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(IndexCell:helpBtnClick:)]) {
        [self.delegate IndexCell:self helpBtnClick:btn];
    }
}

- (void)recommendBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(IndexCell:recommendBtnClick:)]) {
        [self.delegate IndexCell:self recommendBtnClick:btn];
    }
}

- (void)importPromptClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(IndexCell:importPromptBtnClick:)]) {
        [self.delegate IndexCell:self importPromptBtnClick:btn];
    }
}



/**
 *  重写setIndexFrame方法，保存frame
 *
 *  @param indexFrame <#indexFrame description#>
 */
- (void)setIndexFrame:(IndexF *)indexFrame {
    _indexFrame = indexFrame;

    // 设置数据
    [self settingData];
    
    // 设置Frame
    [self settingFrame];
}


- (void)settingData {
    // 积分数量
    self.integralLabel.text = self.indexFrame.model.integralLabelTitle;
    
    // 推荐文案
    self.recommendLabel.text = self.indexFrame.model.recommendLabelTitle;
    
    // 导入积分提示
    if (self.indexFrame.model.importPromptLabelTitle.length == 0) {
        self.importPromptView.hidden = YES;
    } else {
        self.importPromptView.hidden = NO;
    self.importPromptLabel.text = self.indexFrame.model.importPromptLabelTitle;
    }
    
}


- (void)settingFrame {
    
    // 积，图标
    self.totalImageView.frame = self.indexFrame.totalImageViewFrame;
    
    // 总积分 Label
    self.totalIntegralLabel.frame = self.indexFrame.totalIntegralLabelFrame;
    
    // 问号按钮
    self.helpBtn.frame = self.indexFrame.helpBtnFrame;
    
    // 积分数
    self.integralLabel.frame = self.indexFrame.integralLabelFrame;
    
    // line分割线
    self.lineView.frame = self.indexFrame.lineViewFrame;
    
    // 推荐Label
    self.recommendLabel.frame = self.indexFrame.recommendLabelFrame;
    
    
    // 推荐按钮
    self.recommendBtn.frame = self.indexFrame.recommendBtnFrame;
    
    self.recommendBtnBlowView.frame = self.indexFrame.buttonBelowViewFrame;
    // 提示积分导入Box
    self.importPromptView.frame = self.indexFrame.importPromptViewFrame;
    
    // 有积分导入提示Label
    self.importPromptLabel.frame = self.indexFrame.importPromptLabelFrame;
    
    // 积分导入提示Label
    self.importPromptBtn.frame = self.indexFrame.importPromptBtnFrame;
    
    // 加载动画
    [self animationOfScrollOnlyOne];
}

//滚动的动画，就是改变label1的frame的x的值。
-(void)animationOfScrollOnlyOne
{
    CGRect frame = self.recommendLabel.frame;
    
    CGSize dims = [self.recommendLabel.text sizeWithAttributes:@{NSFontAttributeName:self.recommendLabel.font}];
    
    frame.origin.x = dims.width >WIDTH ? dims.width:WIDTH- 100;      //设置起点
    [self.recommendLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y + 11, dims.width, dims.height)];
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:10.8f];     //动画执行时间
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999]; // 动画执行次数
    
    frame = self.recommendLabel.frame;
    frame.origin.x = -dims.width;   //设置终点
    self.recommendLabel.frame = frame;
    [UIView commitAnimations];
}
@end
