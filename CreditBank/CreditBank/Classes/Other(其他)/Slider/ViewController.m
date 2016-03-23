////
////  ViewController.m
////  无线滚动-0012
////
////  Created by Eric on 15/4/11.
////  Copyright (c) 2015年 Eric. All rights reserved.
////
//
//
//#import "ViewController.h"
//#import "ShopSliderView.h"
//#import "MJExtension.h"
//#import "NewsM.h"
//#import "ShopM.h"
//#import "NewsSliderView.h"
//
//@interface ViewController () <SliderViewDelegate>
//@property(nonatomic, weak) ShopSliderView *shopSliderView;
//@property(nonatomic, weak) NewsSliderView *newsSliderView;
//
//@property(nonatomic, strong) NSArray *data;
//@property(nonatomic, strong) NSArray *shopData;
//@end
//
//@implementation ViewController
//
//
//- (NSArray *)data {
//    if (_data == nil) {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"newses.plist" ofType:nil];
//        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *tmpArray = [NSMutableArray array];
//        for (NSDictionary *dic in dicArr) {
//            
//            NewsM *image = [NewsM objectWithKeyValues:dic];
//            [tmpArray addObject:image];
//        }
//        
//        _data = tmpArray;
//    }
//    
//    return _data;
//}
//
//- (NSArray *)shopData {
//    if (_shopData == nil) {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"shops.plist" ofType:nil];
//        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *tmpArray = [NSMutableArray array];
//        for (NSDictionary *dic in dicArr) {
//            
//            ShopM *image = [ShopM objectWithKeyValues:dic];
//            [tmpArray addObject:image];
//        }
//        
//        _shopData = tmpArray;
//    }
//    
//    return _shopData;
//}
//
//#pragma mark - init
//
//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//
//    ShopSliderView *shopSliderView = [[ShopSliderView alloc] init];
//    shopSliderView.delegate    = self;
//    shopSliderView.data        = self.shopData;
//    
//    CGFloat sliderX = 0;
//    CGFloat sliderY = 100;
//    CGFloat sliderW = 320;
//    CGFloat sliderH = 130;
//
//    shopSliderView.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
//    shopSliderView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:shopSliderView];
//    self.shopSliderView  = shopSliderView;
//    
//    
//    
//    NewsSliderView *newsSliderView = [[NewsSliderView alloc] init];
//    newsSliderView.delegate    = self;
//    newsSliderView.data        = self.data;
//    
//    CGFloat newsSliderX = 0;
//    CGFloat newsSliderY = CGRectGetMaxY(shopSliderView.frame);
//    CGFloat newsSliderW = 320;
//    CGFloat newsSliderH = 130;
//    
//    newsSliderView.frame = CGRectMake(newsSliderX, newsSliderY, newsSliderW, newsSliderH);
//    newsSliderView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:newsSliderView];
//    self.newsSliderView  = newsSliderView;
//
//}
//
//- (void)SliderView:(SliderView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"--%@", view);
//}
//
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    // 左右都可以滑动
//    self.shopSliderView.ScrollToCenter = YES;
//    self.newsSliderView.ScrollToCenter = YES;
//}
//
//
//@end
