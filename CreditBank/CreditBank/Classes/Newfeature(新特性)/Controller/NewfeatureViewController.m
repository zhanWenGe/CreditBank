//
//  NewfeatureViewController.m
//  CreditBank
//
//  Created by Eric on 15/5/18.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "PrefixHeader.pch"
#import "TabBarViewController.h"
#define NewfeatureImageCount 3

@interface NewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;




@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.添加UIScrollView
    [self setupScrollView];
    
    // 2.添加pagePageController
    [self setupPageControl];
    
    
}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 2.设置圆点的颜色
//    pageControl.currentPageIndicatorTintColor = HDColor(253, 98, 42);
    //    pageControl.pageIndicatorTintColor = HDColor(189, 189, 189);
    pageControl.currentPageIndicatorTintColor = HDColor(189, 189, 189);
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
   
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < NewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];

        // 设置图片
        NSString *name = nil;
        if (fourInch) { // 4inch
            name = [NSString stringWithFormat:@"new_feature_%d-568h", index + 1];
        } else if (fourPointSevenInch) { // 4.7inch
            name = [NSString stringWithFormat:@"new_feature_%d-667h", index + 1];
        } else if (fivePointFiveInch) { // 5.5inch
            name = [NSString stringWithFormat:@"new_feature_%d-736h", index + 1];
        } else { // 3.5inch
            name = [NSString stringWithFormat:@"new_feature_%d-480h", index + 1];
        }
        imageView.image = [UIImage imageNamed:name];

        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == NewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * NewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    
    if (threePointFive) { // 3.5inch
        startButton.frame = CGRectMake((68 * WIDTH / 320), HIGH - (70 * HIGH / 568) - (45 * HIGH / 568) + 15, WIDTH - 2 * (68 * WIDTH / 320), (45 * HIGH / 568));
    } else if (fourInch) { // 4inch
        startButton.frame = CGRectMake((68 * WIDTH / 320), HIGH - (65 * HIGH / 568) - (45 * HIGH / 568), WIDTH - 2 * (68 * WIDTH / 320), (40 * HIGH / 568));
    } else if (fourPointSevenInch) { // 4.7inch
        startButton.frame = CGRectMake((68 * WIDTH / 320), HIGH - (75 * HIGH / 568) - (45 * HIGH / 568), WIDTH - 2 * (68 * WIDTH / 320), (40 * HIGH / 568));
    } else { // 5.5inch
        startButton.frame = CGRectMake((68 * WIDTH / 320), HIGH - (75 * HIGH / 568) - (45 * HIGH / 568), WIDTH - 2 * (68 * WIDTH / 320), (45 * HIGH / 568));
    }
    startButton.center = CGPointMake(WIDTH * 0.5, startButton.center.y);
    
    // 3.设置文字
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];

}

/**
 *  开始体验
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[TabBarViewController alloc] init];
}

/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}



@end
