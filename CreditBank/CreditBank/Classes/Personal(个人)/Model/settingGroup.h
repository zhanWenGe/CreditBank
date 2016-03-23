//
//  settingGroup.h
//  001-caipiao
//
//  Created by Eric on 15/3/22.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface settingGroup : NSObject
/**
 *  分组的header标题
 */
@property(nonatomic, copy) NSString *header;

/**
 *  分组的footer标题
 */
@property(nonatomic, copy) NSString *footer;

@property(nonatomic, strong) NSArray *items;
@end
