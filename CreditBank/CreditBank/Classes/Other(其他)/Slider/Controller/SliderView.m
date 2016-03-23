
//  SliderView.m
//  无线滚动-0012
//  滑块视图
//  Created by Eric on 15/4/12.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


// Item倍数
#define MULTIPLE 500

#import "SliderView.h"
#import "NewsCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "FocusModel.h"


// #define CLASSNAME;

@interface SliderView()<UICollectionViewDelegate, UICollectionViewDataSource>


/**
 *  布局对象
 */
@property(nonatomic, weak) UICollectionViewFlowLayout *layout;

/**
 *  页码控制器
 */
@property(nonatomic, weak) UIPageControl    *pageControl;

/**
 *  当前选中的数据ID
 */
@property(nonatomic, assign) NSInteger      selectIndex;
/**
 *  当前选中的Item
 */
@property(nonatomic, assign) NSInteger      selectItemIndex;

/**
 *  重用ID
 */
@property(nonatomic, strong) NSString       *ID;
/**
 *  定时器
 */
@property(nonatomic, strong) NSTimer        *timer;
/**
 *  预加载图片使用
 */
@property(nonatomic, strong) NSMutableArray    *tmpImageViewArr;
@end

@implementation SliderView

- (instancetype)init {
    
    if (self = [super init]) {
        
        // 初始化子控件
        [self setUpSubview];
        
    }
    
    return self;
}


- (void)setUpSubview {
    
    // 创建流布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 横向滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 水平间距
    layout.minimumInteritemSpacing = 0;
    
    // 垂直间距
    layout.minimumLineSpacing = 0;
    
    // 四面八方间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layout = layout;
    
    // 加载 collection
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    
    // 不显示滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator   = NO;
    collectionView.backgroundColor   = [UIColor whiteColor];
    
    // 设置代理
    collectionView.delegate   = self;
    collectionView.dataSource = self;
    
    // 开启滚动
    collectionView.pagingEnabled = YES;
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册cell
    [self.collectionView registerClass:[self getClassCell] forCellWithReuseIdentifier:self.ID];
    
    // 页码
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor = HDColor(250, 93, 94);
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];

    self.pageControl = pageControl;

    // 默认选中0
    self.selectIndex = 0;
    
    // 默认颜色，在没有网络的情况下会加载出现
    self.collectionView.backgroundColor = HDColor(239, 239, 239);

}


/**
 *  注册cell
 */
- (__unsafe_unretained Class)getClassCell {
    return [NewsCollectionViewCell class];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // 设置Item大小
    self.layout.itemSize      = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    // 页码 frame
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 15;
    CGFloat pageControlX = (self.frame.size.width  - pageControlW) * 0.5;
    CGFloat pageControlY = self.frame.size.height - pageControlH;
    
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}

- (NSString *)ID {
    if (_ID == nil) {
        _ID = @"slider";
    }
    return _ID;
}

/**
 *  设置模型数组
 *
 *  @param data <#data description#>
 */
- (void)setData:(NSArray *)data {
    
    if (_data == nil) {
         _data = data;
        
        // 焦点图预加载，因为collectionView为了优化加载是显示图片的时候才会加载
        // 这样造成加载速度慢，必须滑动的时候图片才开始下载
        // 预处理这些图片先让下载出来，这样滑动的时候不会出现图片才刚刚加载
        // 如果图片太多也会带来性能问题，后续优化可以考虑延迟加载下一张
        
        for (int i = 0; i < data.count; i++) {
            FocusModel *focusM = self.data[i % self.data.count];
            UIImageView *imageView = [[UIImageView alloc] init];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:focusM.cover] placeholderImage:nil];
            [self.tmpImageViewArr addObject:imageView];
        }
    }
    
    // 页码数量
    self.pageControl.numberOfPages = data.count;
}

/**
 *  让轮播图左右滑动
 */
- (void)setScrollToCenter:(BOOL)ScrollToCenter {
    _ScrollToCenter = ScrollToCenter;
        if (self.data.count != 0) {

        if (ScrollToCenter == YES) {
            
            self.selectItemIndex = MULTIPLE * self.data.count / 2;
            
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectItemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
        }
    }
    // 开启定时轮播
    [self addTimer];
}

#pragma mark -- ScrollViewDelete

/**
 *  Item滑动效果结束时候调用
 *
 *  @param scrollView 滑动的 scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算当前选中Item
    self.selectItemIndex = (int)scrollView.contentOffset.x / (int)self.frame.size.width;
    
    // 计算当前选中的数据ID
    self.selectIndex     = self.selectItemIndex % self.data.count;
    
    self.pageControl.currentPage = self.selectIndex;
}


- (void) addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    
    // 定时器优先级高，线程处理
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void) next {
    
    if (self.data.count != 0) {

        self.selectItemIndex++;
        if (self.selectItemIndex >= MULTIPLE * self.data.count) {
            
            self.selectItemIndex = MULTIPLE * self.data.count / 2;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectItemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectItemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        
        self.pageControl.currentPage = self.selectItemIndex % self.data.count;
    }
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

// 手工触发，停止定时器 定时器只能用一次，一旦停止就不能在使用了
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

#pragma mark -- UICollectionView DataScore
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count * MULTIPLE;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.ID forIndexPath:indexPath];
    cell.focusM = self.data[indexPath.item % self.data.count];
    return cell;
}

#pragma mark -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(SliderView:didSelectItemAtIndexPath:)]) {
        [self.delegate  SliderView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma makr -- subview object Mehtod
/**
 *  设置page选中的颜色
 */
//- (void)setCurrentPageTintColor:(UIColor *)currentPageTintColor {
//    _currentPageTintColor = currentPageTintColor;
//    if (self.pageControl) {
//        self.pageControl.currentPageIndicatorTintColor = currentPageTintColor;
//    }
//}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake(3, 3);
}
@end
