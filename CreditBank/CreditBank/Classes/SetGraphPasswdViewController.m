//
//  SetGraphPasswdViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//
// errLabel 默认显示的颜
#define SUCCCOLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5]
// errLabel 失败显示的颜色
#define FAILCOLOR [UIColor colorWithRed:252/255.0 green:92/255.0 blue:88/255.0 alpha:0.8]


#import "SetGraphPasswdViewController.h"
#import "UnlockView.h"
#import "MBProgressHUD+MJ.h"
#import "PrefixHeader.pch"
#import "NSString+Expand.h"
#import "NavigationController.h"

@interface SetGraphPasswdViewController () <UnlockViewDelegate,UIAlertViewDelegate>
/**
 *  手势解锁绘图 view
 */
@property(nonatomic, weak) UnlockView *lockView;
/**
 *  解锁错误提示 label
 */
@property(nonatomic, weak) UILabel   *errLabel;
/**
 *  小图标容器
 */
@property(nonatomic, weak) UIView   *iconViewBox;
/**
 *  上次图形
 */
@property(nonatomic, copy) NSString  *prevPasswd;
@end

@implementation SetGraphPasswdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:36/255.0 green:39/255.0 blue:54/255.0 alpha:1.0];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBarButtonItemWhite"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    [NavigationController setNavigationBarBlack:self];
    
    self.title = @"设置手势锁";

    // 初始化子控件
    [self setUp];
    
}

- (void)leftBarButtonClick {
     [NavigationController setNavigationBarDefault:self];
    [self.navigationController popToViewController:self.top animated:YES];
}

#pragma mark -- 初始化控件
- (void)setUp {
    
    // 小图标容器
    UIView *iconViewBox = [[UIView alloc] init];
    self.iconViewBox    = iconViewBox;
    
    CGFloat iconViewBoxW = 50;
    CGFloat iconViewBoxH = 50;
    CGFloat iconViewBoxX = (self.view.frame.size.width - iconViewBoxW ) * 0.5;
    CGFloat iconViewBoxY = 64 + 20;
    iconViewBox.frame    = CGRectMake(iconViewBoxX, iconViewBoxY, iconViewBoxW, iconViewBoxH);
    [self.view addSubview:iconViewBox];
    
    // 小图标
    for (int index = 0; index < 9; index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"graphSmallIcon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"graphSmallIcon_highlighted"] forState:UIControlStateSelected];
        btn.tag = index;
        [self.iconViewBox addSubview:btn];
    }
    
    // 设置 frame
    [self setUpIconFrame];
    
    
    // 提示框
    UILabel *errLabel  = [[UILabel alloc] init];
    errLabel.font      = [UIFont systemFontOfSize:14.0];
    errLabel.textColor = SUCCCOLOR;
    errLabel.textAlignment  = NSTextAlignmentCenter;
    errLabel.text      = @"请绘制密码图形";
    
    CGFloat errLabelX = 0;
    CGFloat errLabelY = CGRectGetMaxY(iconViewBox.frame) + 15;
    CGFloat errLabelW = self.view.frame.size.width;
    CGFloat errLabelH = 25;
    errLabel.frame    = CGRectMake(errLabelX, errLabelY, errLabelW, errLabelH);
    
    self.errLabel     = errLabel;
    [self.view addSubview:errLabel];
    
    // 图形锁 view
    UnlockView *lockView     = [[UnlockView alloc] init];
    lockView.backgroundColor = [UIColor clearColor];
    lockView.delegate        = self;
    [self.view addSubview:lockView];
    self.lockView            = lockView;
    
    CGFloat viewX  = 0;
    CGFloat viewY  = CGRectGetMaxY(errLabel.frame);
    CGFloat viewW  = self.view.frame.size.width;
    CGFloat viewH  = self.view.frame.size.height - 220;
    lockView.frame = CGRectMake(viewX, viewY, viewW, viewH);

}

/**
 *  计算小图标的Frame
 */
- (void)setUpIconFrame {
    
    for (int i = 0; i < self.iconViewBox.subviews.count; i++) {
        
        CGFloat BtnW = 10;
        CGFloat BtnH = 10;
        
        int totalColumns = 3;
        int totalRowumns = 3;
        
        // 计算当前按钮在哪一列
        int col = i % totalColumns;
        
        // 计算当前位置在哪一行
        int row = i / totalColumns;
        
        // 算法是先列，后行
        CGFloat marginX = (self.iconViewBox.frame.size.width - totalColumns * BtnW) / (totalColumns  + 1);
        CGFloat marginY = (self.iconViewBox.frame.size.height - totalRowumns * BtnH) / (totalRowumns  + 1);
        
        // 间距 + 列 * (按钮宽度 + 行间距)
        CGFloat BtnX = marginX + col * (BtnW + marginX);
        
        // 行间距 + 行数 * (按钮高度 + 列间距)
        CGFloat BtnY = marginY + row  * (BtnH + marginY);
        
        UIButton  *btn = self.iconViewBox.subviews[i];
        btn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
    }
}

/**
 *  绘制小图标路径
 *
 *  @param path <#path description#>
 */
- (void)setIconStateSelected:(NSString *)path {
    
    // 取消选中
    for (UIButton *btn in self.iconViewBox.subviews) {
        NSString *tagStr = [NSString stringWithFormat:@"%ld", (long)btn.tag];
        if ([path containsString:tagStr] ) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }

}

#pragma mark -- UnlockViewDelegate
/**
 *  手势解锁绘图完成
 *
 *  @param lockView <#lockView description#>
 *  @param path     <#path description#>
 */
- (void)UnlockView:(UnlockView *)lockView didFinishPath:(NSString *)path {
    // 1、保存第一次图形
    if (self.prevPasswd == nil) {
        
        self.prevPasswd = path;
        self.errLabel.textColor = SUCCCOLOR;
        self.errLabel.text = @"请再次绘制密码图形";
        
        // 显示绘制路径
        [self setIconStateSelected:path];
        
    } else {
        // 验证两次图形手势相同，保存密码设置成功
        if ([self.prevPasswd isEqualToString:path]) {
            
            [MBProgressHUD showSuccess:@"设置图形密码成功"];
            [self savePasswd:path];
            
            __weak typeof(self) SetGraphPasswdViewController = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 返回上一层控制器
                [NavigationController setNavigationBarDefault:self];
                [SetGraphPasswdViewController.navigationController popToViewController:self.top animated:YES];
            });
        } else {
            
            self.prevPasswd = nil;
            self.errLabel.textColor = FAILCOLOR;
            self.errLabel.text = @"与上次绘制不一致,请重新绘制";
        }
    }
    
    [lockView clearAll];
}

/**
 *  保存手势密码
 *
 *  @param path <#path description#>
 */
- (void)savePasswd:(NSString *)path {
    // md5加密
    NSString *passwd = [[path stringByAppendingString:MD5STRING] md5];
    
    // 保存文件
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:passwd forKey:PASSKYE];
    [userDefault synchronize];
}

/**
 *  密码加密
 *
 *  @param path <#path description#>
 */
+ (NSString *)encodePasswd:(NSString *)path {
    return [[path stringByAppendingString:MD5STRING] md5];
}
/**
 *  获取密码
 *
 *  @param path <#path description#>
 */
+ (NSString *)getPasswd {
    return [[NSUserDefaults standardUserDefaults] valueForKey:PASSKYE];
}

/**
 *  清空密码
 *
 *  @param path <#path description#>
 */
+ (void)clearPasswd {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSKYE];
}

- (void)dealloc {
    NSLog(@"SetGraphPasswdViewController-dealloc");
}
@end

