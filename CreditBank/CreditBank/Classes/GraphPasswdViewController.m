//
//  GraphPasswdViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "GraphPasswdViewController.h"
#import "UnlockView.h"
#import "SetGraphPasswdViewController.h"
#import "NavigationController.h"
#import "ResetPasswordController.h"
#import "LogoutHandler.h"
#import "LoginViewController.h"



@interface GraphPasswdViewController () <UnlockViewDelegate,UIAlertViewDelegate, UIGestureRecognizerDelegate>
/**
 *  手势解锁绘图 view
 */
@property(nonatomic, weak) UnlockView *lockView;
/**
 *  解锁错误提示 label
 */
@property(nonatomic, weak) UILabel    *notifyLabel;
/**
 *  请输入解锁图形 label
 */
@property(nonatomic, weak) UILabel    *promptLabel;
/**
 *  忘记密码 btn
 */
@property(nonatomic, weak) UIButton   *forgetPasswdBtn;
/**
 *  错误密码计数
 */
@property(nonatomic, assign) int    errorPasswdCount;
/**
 *  图形密码
 */
@property(nonatomic, copy) NSString    *passwd;
@end

@implementation GraphPasswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorPasswdCount = 5;
    self.title = @"手势解锁";
    self.view.backgroundColor = [UIColor colorWithRed:36/255.0 green:39/255.0 blue:54/255.0 alpha:1.0];
    
    // 返回按钮
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBarButtonItemWhite"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    // 导航栏黑色
    [NavigationController setNavigationBarBlack:self];
    
    // 初始化子控件
    [self setUp];
    
}



- (void)leftBarButtonClick {
    // 恢复导航栏
    [NavigationController setNavigationBarDefault:self];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 成员变量懒加载
- (NSString *)passwd {
    if (_passwd == nil) {
        _passwd = [SetGraphPasswdViewController getPasswd];
    }
    
    return _passwd;
}


#pragma mark -- 初始化控件
- (void)setUp {
    
    // 提示框
    UILabel *notifyLabel       = [[UILabel alloc] init];
    notifyLabel.font           = [UIFont systemFontOfSize:14.0];
    notifyLabel.textColor      = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    notifyLabel.textAlignment  = NSTextAlignmentCenter;
    notifyLabel.text           = @"请输入原手势密码";
    
    CGFloat notifyLabelX = 0;
    CGFloat notifyLabelY = 94;
    CGFloat notifyLabelW = self.view.frame.size.width;
    CGFloat notifyLabelH = 25;
    notifyLabel.frame    = CGRectMake(notifyLabelX, notifyLabelY, notifyLabelW, notifyLabelH);
    
    self.notifyLabel     = notifyLabel;
    [self.view addSubview:notifyLabel];
    
    // 图形锁 view
    UnlockView *lockView     = [[UnlockView alloc] init];
    lockView.backgroundColor = [UIColor clearColor];
    lockView.delegate        = self;
    [self.view addSubview:lockView];
    self.lockView            = lockView;
    
    CGFloat viewX  = 0;
    CGFloat viewY  = CGRectGetMaxY(notifyLabel.frame);
    CGFloat viewW  = self.view.frame.size.width;
    CGFloat viewH  = self.view.frame.size.height - 200;
    lockView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    // 提示解锁 label
    UILabel *promptLabel   = [[UILabel alloc] init];
    promptLabel.text       = @"请输入解锁图形";
    promptLabel.textColor  = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    promptLabel.font       = [UIFont systemFontOfSize:14.0];
    
    CGFloat promptLabelX   = 20;
    CGFloat promptLabelY   = self.view.frame.size.height - 52;
    CGFloat promptLabelW   = 100;
    CGFloat promptLabelH   = 25;
    
    promptLabel.frame      = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    [self.view addSubview:promptLabel];
    self.promptLabel = promptLabel;
    
    // 忘记密码按钮
    UIButton *forgetPasswdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    forgetPasswdBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [forgetPasswdBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
    
    [forgetPasswdBtn addTarget:self action:@selector(forgetPasswdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswdBtn];
    self.forgetPasswdBtn = forgetPasswdBtn;
    
    CGFloat forgetPasswdBtnY = self.view.frame.size.height - 52;
    CGFloat forgetPasswdBtnW = 100;
    CGFloat forgetPasswdBtnX = self.view.frame.size.width - forgetPasswdBtnW;
    CGFloat forgetPasswdBtnH = 25;
    forgetPasswdBtn.frame    = CGRectMake(forgetPasswdBtnX, forgetPasswdBtnY, forgetPasswdBtnW, forgetPasswdBtnH);
    
    
    self.forgetPasswdBtn.hidden = self.isCheckRsetPasswd;
    self.promptLabel.hidden     = self.isCheckRsetPasswd;
    
}

/**
 *  忘记密码控制器
 */
- (void)forgetPasswdBtnClick {
    
    // 忘记密码回调
    if (self.forgetPasswBlock) {
        self.forgetPasswBlock();
    }
    
    // 恢复导航栏
    [NavigationController setNavigationBarDefault:self];
    
    // 忘记密码去登陆
    [LogoutHandler logoutHandlerFromControllor:self];
}

#pragma mark -- UnlockViewDelegate
- (void)UnlockView:(UnlockView *)lockView didFinishPath:(NSString *)path {
    // 密码正确
    if ([self.passwd isEqualToString:[SetGraphPasswdViewController encodePasswd:path]]) {
        
        // 重设密码
        if (self.checkRsetPasswd) {
            SetGraphPasswdViewController *setVc = [[SetGraphPasswdViewController alloc] init];
            setVc.top = self.top;
            [self.navigationController pushViewController:setVc animated:YES];
        }
        
//        // 密码验证通过回调函数
        if (self.successBlock) {
            self.successBlock();
        }

        
    } else {
        // 5次输入密码的机会
        if (self.errorPasswdCount > 1) {
            
            self.errorPasswdCount--;
            
            self.notifyLabel.text      = [NSString stringWithFormat:@"密码错误，还可以输入%d次", self.errorPasswdCount];
            self.notifyLabel.textColor = [UIColor redColor];
            [self showNotifyLabelAnimation];
            
            // 显示失败图形
            [lockView didFailPath];
        } else {
            
            // 显示失败图形
            [lockView didFailPath];
            
            // 密码次数不够
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手势密码错误次数过多，你可以通过忘记手势密码才验证身份" message:nil delegate:self cancelButtonTitle:@"忘记手势密码" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        // [lockView clearAll];
    }

}

#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        // 忘记手势密码
        [self forgetPasswdBtnClick];
    }
}

/**
 *  手势密码输入错误动画效果
 */
- (void)showNotifyLabelAnimation {
    
    int offsetX = 10;
    
    CGPoint position = self.notifyLabel.layer.position;
    
    CAKeyframeAnimation *cKeyAnim = [[CAKeyframeAnimation alloc] init];
    cKeyAnim.keyPath = @"position";
    
    NSValue *postion1 = [NSValue valueWithCGPoint:CGPointMake(position.x, position.y)];
    NSValue *postion2 = [NSValue valueWithCGPoint:CGPointMake(position.x - offsetX, position.y)];
    NSValue *postion3 = [NSValue valueWithCGPoint:CGPointMake(position.x, position.y)];
    NSValue *postion4 = [NSValue valueWithCGPoint:CGPointMake(position.x + offsetX , position.y)];
    
    cKeyAnim.values  = @[postion1,postion2,postion3,postion4];
    
    // 动画时间
    cKeyAnim.duration = 0.1;
    
    // 重复次数
    cKeyAnim.repeatCount = 2;
    
    // 动画最后不进行还原
     cKeyAnim.removedOnCompletion = NO;
     cKeyAnim.fillMode = kCAFillModeBackwards;
    
    [self.notifyLabel.layer addAnimation:cKeyAnim forKey:@"notifyLabel"];
}

- (void)dealloc {
    NSLog(@"GraphPasswdViewController-dealloc");
}

+ (void)showGraphPasswdController:(UIViewController *) controller {
    
    // 密码存在，要先验证密码
    NSString *passwd = [SetGraphPasswdViewController getPasswd];
    
    if (passwd.length) {
        GraphPasswdViewController *graphVc = [[GraphPasswdViewController alloc] init];
        
        // 手势密码验证成功
        graphVc.successBlock = ^{
           [NavigationController setNavigationBarDefault:controller];
           [controller dismissViewControllerAnimated:YES completion:nil];
        };
        
        // 忘记密码
        graphVc.forgetPasswBlock = ^{
            [NavigationController setNavigationBarDefault:controller];
            [controller dismissViewControllerAnimated:YES completion:^{
                // 忘记密码去登陆
                [LogoutHandler logoutHandlerFromControllor:controller];
            }];
        };
        
        
        [controller presentViewController:graphVc animated:YES completion:nil];
    }
}


@end
