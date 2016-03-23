//
//  IndexModuleF.h
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IndexModuleF : NSObject

/**
 *  数据模型数组
 */
@property(nonatomic, strong) NSArray *dataM;
/**
 *  Frame模型数组
 */
@property(nonatomic, strong,readonly) NSArray *dataF;

/**
 *  高度
 */
@property(nonatomic, assign,readonly) CGFloat cellHeight;
@end
