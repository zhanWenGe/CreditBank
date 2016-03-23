//
//  SliderView.h
//  无线滚动-0012
//
//  Created by Eric on 15/4/12.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import <UIKit/UIKit.h>
@class SliderView;

@protocol SliderViewDelegate <NSObject>
@optional
- (void)SliderView:(SliderView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SliderView : UIView
/**
 *  代理对象
 */
@property(nonatomic, weak) id <SliderViewDelegate> delegate;
/**
 *  模型数组
 */
@property(nonatomic, strong) NSArray *data;

/**
 *  滚动条是否居中，让左右都可以滚动
 */
@property(nonatomic, assign) BOOL ScrollToCenter;
/**
 *  页码选中的颜色
 */
@property(nonatomic, strong) UIColor *currentPageTintColor;

/**
 *  collectionview 对象
 */
@property(nonatomic, weak) UICollectionView *collectionView;
@end
