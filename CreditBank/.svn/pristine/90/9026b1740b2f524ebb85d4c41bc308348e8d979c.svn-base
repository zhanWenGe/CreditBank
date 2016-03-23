//
//  StatementNetWork.h
//  CreditBank
//
//  Created by 王德康 on 15/6/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import <Foundation/Foundation.h>
@class StatementNetWork;

@protocol StatementNetWorkDelegate <NSObject>
@optional
// 数据请求回调
- (void)statementNetWork:(StatementNetWork *)statementNetWork loadDataFinish:(NSArray *)data;
// 没有更多数据
- (void)statementNetWork:(StatementNetWork *)statementNetWork loadErrorInfo:(NSString *)info;
@end

@interface StatementNetWork : NSObject
// 请求参数 页码
@property(nonatomic, assign) int pageNo;
// 请求参数 类型
@property(nonatomic, strong) NSString *type;
// 当次加载的数据
@property(nonatomic, strong, readonly) NSArray  *lastData;
// 数据是否在当前月份(section)加载
@property(nonatomic, assign, readonly) BOOL cureenSection;
@property(nonatomic, weak) id <StatementNetWorkDelegate> delegate;


// 加载数据方法
- (void)getData;
- (void)clearData;
-(BOOL)isMoreData;
@end
