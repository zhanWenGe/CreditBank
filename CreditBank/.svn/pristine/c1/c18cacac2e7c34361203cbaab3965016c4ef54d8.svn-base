//
//  ShopSliderView.m
//  无线滚动-0012
//
//  Created by Eric on 15/4/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "ShopSliderView.h"
#import "ShopCollectionViewCell.h"

@interface ShopSliderView()
@property(nonatomic, assign) NSString *ID;
@end

@implementation ShopSliderView

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
 *  注册cell，必须重写
 */
- (__unsafe_unretained Class)getClassCell {
    return [ShopCollectionViewCell class];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.ID forIndexPath:indexPath];
    cell.m = self.data[indexPath.item % self.data.count];
    return cell;
}

@end
