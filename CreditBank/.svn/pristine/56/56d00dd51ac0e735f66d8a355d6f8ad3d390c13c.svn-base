//
//  IndexModuleCell.m
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "IndexModuleCell.h"
#import "ModuleButton.h"
#import "IndexModuleF.h"
#import "IndexModuleM.h"
#import "PrefixHeader.pch"

@interface IndexModuleCell()

@end

@implementation IndexModuleCell
/**
 *  封装复用方法
 *
 *  @param tableview <#tableview description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype) indexModuleCellWithTableView:(UITableView *)tableview moduleCount:(NSInteger)count {
    static NSString *ID = @"IndexModuleCell";
    
    IndexModuleCell *cell = (IndexModuleCell *)[tableview dequeueReusableCellWithIdentifier:ID];
    
    cell = [[IndexModuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID moduleCount:count];
    
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier moduleCount:(NSInteger)count {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpSubviews:count];
        self.backgroundColor = DEFALT_BG;
    }
    
    return self;
}

/**
 *  加载子控件
 */
- (void)setUpSubviews:(NSInteger)count {
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 初始化子控件
    for (int i = 0; i < count; i++) {
        ModuleButton *btn = [ModuleButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(moduleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        NSString *str = [NSString stringWithFormat:@"电影票%d", i];
        [btn setTitle:str forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"Integral"] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        [self.contentView addSubview:btn];
    }
    
}
/**
 *  模块事件点击处理
 *
 *  @param btn <#btn description#>
 */
- (void)moduleButtonClick:(ModuleButton *) btn {
    ANLog(@"moduleButtonClick");
    if ([self.delegate respondsToSelector:@selector(cell:btnClick:)]) {
        [self.delegate cell:self btnClick:btn];
    }
}

/**
 *  重写setIndexModuleF方法，保存frame
 *
 *  @param indexFrame <#indexFrame description#>
 */
- (void)setIndexModuleF:(IndexModuleF *)indexModuleF{
    _indexModuleF = indexModuleF;
    
    // 设置数据
    [self settingData];
    
    // 设置Frame
    [self settingFrame];
    
}


- (void)settingData {

    for (int i = 0; i < self.indexModuleF.dataM.count; i++) {
      
        ModuleButton *btn =   (ModuleButton *)[self.contentView viewWithTag:100 + i];
        IndexModuleM *indexM = self.data[i];
        
        [btn setTitle:indexM.name forState:UIControlStateNormal];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
//        imageView.backgroundColor = [UIColor redColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:indexM.cover] placeholderImage:[UIImage imageNamed:@"Integral"]];
        [btn.imageView addSubview:imageView];
        imageView.frame = btn.imageView.bounds;

    }
  
}


- (void)settingFrame {
    
    for (int i = 0; i < self.indexModuleF.dataM.count; i++) {
        ModuleButton *btn = (ModuleButton *)[self viewWithTag:100 + i];
        
        NSValue *value = self.indexModuleF.dataF[i];
        btn.frame = [value CGRectValue];
        
        IndexModuleM *m = self.indexModuleF.dataM[i];
        if (m.isShowRightLine) {
            btn.rightLineView.hidden = NO;
        }
        
        if (m.isShowBottomLine) {
            btn.bottomLineView.hidden = NO;
        }
        
        
    }
    
}
@end
