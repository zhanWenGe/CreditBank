//
//  IndexF.m
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IndexF.h"
#import "IndexM.h"
#import "PrefixHeader.pch"

@implementation IndexF
/**
 *  根据模型数据计算高度
 *
 *  @param model <#model description#>
 */
- (void)setModel:(IndexM *)model {
    _model = model;
    
    // 积，图标
    CGFloat totalImageViewX = 10;
    CGFloat totalImageViewY = 15;
    CGFloat totalImageViewW = 12;
    CGFloat totalImageViewH = 12;
    
    self.totalImageViewFrame = CGRectMake(totalImageViewX, totalImageViewY, totalImageViewW, totalImageViewH);
    
    // 总积分 Label
    CGFloat totalIntegralLabelX = CGRectGetMaxX(self.totalImageViewFrame) + 10;
    CGFloat totalIntegralLabelY = totalImageViewY;
    CGFloat totalIntegralLabelW = 80;
    CGFloat totalIntegralLabelH = 12;
    self.totalIntegralLabelFrame = CGRectMake(totalIntegralLabelX, totalIntegralLabelY, totalIntegralLabelW, totalIntegralLabelH);
    
    // 问号按钮
    CGFloat helpBtnW = 21;
    CGFloat helpBtnH = 21;
    CGFloat helpBtnX = WIDTH - helpBtnW - 10;
    CGFloat helpBtnY = totalImageViewY;
    self.helpBtnFrame = CGRectMake(helpBtnX, helpBtnY, helpBtnW, helpBtnH);
    
    
    // 积分数
    CGFloat integralLabelX = totalImageViewX;
    CGFloat integralLabelY = CGRectGetMaxY(self.totalIntegralLabelFrame) + 18;
    CGFloat integralLabelW = 110;
    CGFloat integralLabelH = 25;
    self.integralLabelFrame = CGRectMake(integralLabelX, integralLabelY, integralLabelW, integralLabelH);
    
    // line分割线
    CGFloat lineViewX = 0;
    CGFloat lineViewY = CGRectGetMaxY(self.integralLabelFrame) + 20;
    CGFloat lineViewW = WIDTH;
    CGFloat lineViewH = 1;
    self.lineViewFrame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    // 推荐按钮
    CGFloat recommendBtnW = 60;
    CGFloat recommendBtnH = 20;
    CGFloat recommendBtnX = WIDTH - recommendBtnW - 10;;
    CGFloat recommendBtnY = CGRectGetMaxY(self.lineViewFrame) + 10;
    self.recommendBtnFrame = CGRectMake(recommendBtnX, recommendBtnY, recommendBtnW, recommendBtnH);
    
    // 推荐Label
    CGFloat recommendLabelX = totalImageViewX;
    CGFloat recommendLabelY = CGRectGetMaxY(self.lineViewFrame);
    CGFloat recommendLabelW = WIDTH - recommendLabelX - recommendBtnW - 20;
    CGFloat recommendLabelH = 38;
    self.recommendLabelFrame = CGRectMake(recommendLabelX, recommendLabelY, recommendLabelW, recommendLabelH);
    
    // 推荐按钮下面的视图
    CGFloat recommendBtnBelowW = recommendBtnW + 20;
    CGFloat recommendBtnBelowX = WIDTH - recommendBtnBelowW;
    CGFloat recommendBtnBelowY = CGRectGetMaxY(self.lineViewFrame);
    CGFloat recommendBtnBelowH = 38;
    self.buttonBelowViewFrame = CGRectMake(recommendBtnBelowX, recommendBtnBelowY, recommendBtnBelowW, recommendBtnBelowH);
    
    // 提示积分导入Box
    CGFloat importPromptViewX = 0;
    CGFloat importPromptViewY = CGRectGetMaxY(self.recommendLabelFrame);
    CGFloat importPromptViewW = WIDTH;
    CGFloat importPromptViewH = 35;
    self.importPromptViewFrame = CGRectMake(importPromptViewX, importPromptViewY, importPromptViewW, importPromptViewH);
    
    // 积分导入提示Label
    CGFloat importPromptBtnW = 48;
    CGFloat importPromptBtnX = WIDTH - importPromptBtnW - 17;
    CGFloat importPromptBtnY = 0;
    CGFloat importPromptBtnH = importPromptViewH;
    self.importPromptBtnFrame = CGRectMake(importPromptBtnX, importPromptBtnY, importPromptBtnW, importPromptBtnH);

    // 有积分导入提示Label
    CGFloat importPromptLabelX = totalImageViewX;
    CGFloat importPromptLabelY = 0;
    CGFloat importPromptLabelW = WIDTH - importPromptBtnW - importPromptLabelX - 20;
    CGFloat importPromptLabelH = importPromptViewH;
    self.importPromptLabelFrame = CGRectMake(importPromptLabelX, importPromptLabelY, importPromptLabelW, importPromptLabelH);
    CGFloat cellY = CGRectGetMaxY(self.recommendLabelFrame);
    
    // 是否有导入提示
    if (model.importPromptLabelTitle.length > 0) {
        _cellHeight = cellY + importPromptViewH;
    } else {
        _cellHeight = cellY;
    }
    
    
}
@end
