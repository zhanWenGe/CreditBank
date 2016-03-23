//
//  NewsSliderView.m
//  无线滚动-0012
//
//  Created by Eric on 15/4/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//  新闻轮播图


#import "NewsSliderView.h"
#import "NewsCollectionViewCell.h"

@interface NewsSliderView()
@property(nonatomic, strong) NSString *ID;
@end

@implementation NewsSliderView

/**
 *  复写 ReuseIdentifier
 *
 *  @return <#return value description#>
 */
- (NSString *)ID {
    if (_ID == nil) {
        _ID = @"news";
    }
    return _ID;
}

/**
 *  注册cell
 */
- (__unsafe_unretained Class)getClassCell {
    return [NewsCollectionViewCell class];
}




//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.ID forIndexPath:indexPath];
//    cell.m = self.data[indexPath.item % self.data.count];
//    return cell;
//}

@end
