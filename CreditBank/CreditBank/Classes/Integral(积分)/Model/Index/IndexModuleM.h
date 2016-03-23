//
//  IndexModuleM.h
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexModuleM : NSObject
@property(nonatomic, copy) NSString *cover;
@property(nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *res_name;
@property (nonatomic, copy) NSString *url;

@property(nonatomic, assign,getter=isShowRightLine) BOOL showRightLine;
@property(nonatomic, assign, getter=isShowBottomLine) BOOL showBottomLine;
@end
