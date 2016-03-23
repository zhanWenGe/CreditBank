
#import "ResetPayPaswdViewController.h"
#import "PrefixHeader.pch"
#import "BlueButtonView.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"

#import "ProfileControllerView.h"
#import "NavigationController.h"

@interface ResetPayPaswdViewController ()<BlueButtonViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) BlueButtonView *resetPayPasswordBtn;
@property (nonatomic, weak) UITextField *payPasswordText;

@end

@implementation ResetPayPaswdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DEFALT_BG;
    self.title = @"修改密码";
    
    // 1.设置支付密码输入框
    [self setupInputPayPasswordText];
    
    // 2.设置按钮
    [self setupVerificationButton];
}

/**
 *  设置新的支付密码输入框
 */
- (void)setupInputPayPasswordText
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 85, WIDTH + 1, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CGFloat payPasswordTextX = 20;
    CGFloat payPasswordTextY = 60;
    CGFloat payPasswordTextW = WIDTH - 20;
    CGFloat payPasswordTextH = 20;
    UITextField *payPasswordText = [[UITextField alloc] init];
    [self.view addSubview:payPasswordText];
    
    view.layer.borderColor = [HDColor(214, 214, 214) CGColor];
    view.layer.borderWidth = 0.5f;
    
    payPasswordText.frame = CGRectMake(payPasswordTextX, payPasswordTextY, payPasswordTextW, payPasswordTextH);
    payPasswordText.center = CGPointMake(payPasswordText.center.x, view.center.y);
    
    payPasswordText.placeholder = @"请输入新的支付密码";
    [payPasswordText becomeFirstResponder];
    payPasswordText.secureTextEntry = YES;
//    verificationText.keyboardType = UIKeyboardTypeNumberPad;
    self.payPasswordText = payPasswordText;
    
}

/**
 *  设置确认修改密码的按钮
 */
- (void)setupVerificationButton
{
    BlueButtonView *resetPayPasswordBtn = [[BlueButtonView alloc] initWithBtnTitle:@"确认修改"];
    resetPayPasswordBtn.delegate = self;
    CGFloat resetPayPasswordBtnX = 0;
    CGFloat resetPayPasswordBtnY = CGRectGetMaxY(self.payPasswordText.frame) + 35;
    CGFloat resetPayPasswordBtnW = WIDTH;
    CGFloat resetPayPasswordBtnH = 46.0;
    resetPayPasswordBtn.frame = CGRectMake(resetPayPasswordBtnX, resetPayPasswordBtnY, resetPayPasswordBtnW, resetPayPasswordBtnH);
    [self.view addSubview:resetPayPasswordBtn];
    self.resetPayPasswordBtn = resetPayPasswordBtn;
}

/**
 *  按钮的代理方法
 */
- (void)btnClick:(id)view btn:(UIButton *)btn
{
    
    [self getVerificationCode:nil nextControllerTitle:nil];

}

/**
 *  获取验证码
 */
- (void)getVerificationCode:(NSString *)type nextControllerTitle:(NSString *)title
{
        NSString *time = [NSDate getTime];
        NSArray *arr = @[self.token, self.phoneNumber, self.payPasswordText.text, time];
        NSString *md5 = [Common paramsSign:arr];
    
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     self.token, @"token",
                                     self.phoneNumber, @"mobile",
                                     self.payPasswordText.text, @"pay_pass",
                                     time, @"time",
                                     md5, @"sign",
                                     PLATFORMID, @"app_id", nil];
        NSString *netStr = @"?anu=api/1/user/save_pay_pass";

        AnRequest *anReq = [[AnRequest alloc] init];
        [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//            ANLog(@"success: %@", responseObject);
            [self setAlertViewWithMessage:@"修改成功,请牢记密码,不要告诉别人哦..." tag:10000];
        } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            ANLog(@"error: %@", responseObject);
            [self setAlertViewWithMessage:responseObject[@"error_info"] tag:0];
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            ANLog(@"fail: %@", error);
        }];
    
    
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message tag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }
}



@end
