//
//  IndexModuleF.m
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IndexModuleF.h"
#import "PrefixHeader.pch"
#import "IndexModuleM.h"

@implementation IndexModuleF

- (void)setDataM:(NSArray *)dataM {
    _dataM = dataM;
    
    // 计算位置
    
    int n = 3;
    CGFloat btnW = WIDTH / n;
    CGFloat btnH = btnW * 190 / 213;
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (int i = 0; i < dataM.count; i++) {
        
        CGFloat btnX = (i % n) * btnW;
        CGFloat btnY = (i / n) * btnH;
        
        IndexModuleM *m = [self.dataM objectAtIndex:i];
        
        if (i % n  < n) {
            m.showRightLine= YES;
        }
        
        if (i / n  < n) {
            m.showBottomLine = YES;
        }
        
        CGRect btnRect = CGRectMake(btnX, btnY, btnW, btnH);
        [tmpArr addObject:[NSValue valueWithCGRect:btnRect]];
        
        if (i + 1 == dataM.count) {
            _cellHeight = CGRectGetMaxY(btnRect);
        }
    }
    
    
    _dataF = tmpArr;
    
}
@end
