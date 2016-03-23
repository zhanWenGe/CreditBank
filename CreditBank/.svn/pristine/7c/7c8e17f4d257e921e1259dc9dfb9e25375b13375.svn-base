//
//  AddBankHeadView.m
//  CreditBank
//
//  Created by Eric on 15/5/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AddBankHeadView.h"
#import "PrefixHeader.pch"

@interface AddBankHeadView () <UITextFieldDelegate>

/**
 *  获取积分成功Lable
 */
@property (nonatomic, weak) UILabel *successLabel;
/**
 *  银行名称及卡号尾号Lable
 */
@property (nonatomic, weak) UILabel *bankNameNumLabel;
/**
 *  自定义积分按钮
 */
@property (nonatomic, weak) UIButton *myIntegralButton;
/**
 *  取消按钮
 */
@property (nonatomic, weak) UIButton *cancelButton;
/**
 *  银行积分Lable
 */
@property (nonatomic, weak) UILabel *bankIntegralLabel;
/**
 *  分割线
 */
@property (nonatomic, weak) UILabel *lineLabel;
/**
 *  换取标识
 */
@property (nonatomic, weak) UIImageView *exchangeImageView;
/**
 *  可换取
 */
@property (nonatomic, weak) UILabel *canExchangeLabel;
/**
 *  汇点Lable
 */
@property (nonatomic, weak) UILabel *selfUnitLabel;


@end

@implementation AddBankHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = HDColor(251, 93, 93);
        [self setHeadView];
    }
    return self;
}

- (void)setHeadView
{
    //获取积分成功Lable
    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.font = [UIFont systemFontOfSize:16];
    successLabel.textColor = [UIColor whiteColor];
    [self addSubview:successLabel];
    self.successLabel = successLabel;
    
    //银行名称及卡号尾号Lable
    UILabel *bankNameNumLabel = [[UILabel alloc] init];
    bankNameNumLabel.textColor = HDColor(253, 190, 190);
    bankNameNumLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:bankNameNumLabel];
    self.bankNameNumLabel = bankNameNumLabel;
    
    //自定义积分按钮
    UIButton *myIntegralButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myIntegralButton.titleLabel.font = [UIFont systemFontOfSize:12];
    myIntegralButton.layer.cornerRadius = 3;
    myIntegralButton.layer.borderWidth = 1;
    myIntegralButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [myIntegralButton addTarget:self action:@selector(customCancelClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:myIntegralButton];
    self.myIntegralButton = myIntegralButton;
    [self.myIntegralButton setTitle:@"自定义积分" forState:UIControlStateNormal];
    self.myIntegralButton.hidden = NO;
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
    cancelButton.layer.cornerRadius = 3;
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [cancelButton addTarget:self action:@selector(customCancelClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    self.cancelButton = cancelButton;
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.hidden = YES;
    
    //积分总数
    UILabel *integralLabel = [[UILabel alloc] init];
    integralLabel.textColor = [UIColor whiteColor];
    integralLabel.font = [UIFont systemFontOfSize:31];
    [self addSubview:integralLabel];
    self.integralLabel = integralLabel;
    self.integralLabel.hidden = NO;
    
    //银行积分Lable
    UILabel *bankIntegralLabel = [[UILabel alloc] init];
    bankIntegralLabel.textColor = [UIColor whiteColor];
    bankNameNumLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:bankIntegralLabel];
    self.bankIntegralLabel = bankIntegralLabel;
    self.bankIntegralLabel.hidden = NO;
    self.bankIntegralLabel.text = @"银行积分";
    
    //自定义分数输入框
    UITextField *inputTextField = [[UITextField alloc] init];
    inputTextField.backgroundColor = [UIColor whiteColor];
    inputTextField.textAlignment = NSTextAlignmentCenter;
    inputTextField.font = [UIFont systemFontOfSize:31];
    inputTextField.layer.cornerRadius = 2;
    inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    inputTextField.delegate = self;
    [self addSubview:inputTextField];
    self.inputTextField = inputTextField;
    self.inputTextField.hidden = YES;
    
    
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = HDColor(251, 121, 101);
    [self addSubview:lineLabel];
    self.lineLabel = lineLabel;
    
    //换取标识
    UIImageView *exchangeImageView = [[UIImageView alloc] init];
    exchangeImageView.image = [UIImage imageNamed:@"exchange"];
    [self addSubview:exchangeImageView];
    self.exchangeImageView = exchangeImageView;
    self.exchangeImageView.hidden = NO;
    
    //可换取
    UILabel *canExchangeLabel = [[UILabel alloc] init];
    canExchangeLabel.textColor = [UIColor whiteColor];
    canExchangeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:canExchangeLabel];
    self.canExchangeLabel = canExchangeLabel;
    
    //可以兑换成积分宝积分数量
    UILabel *exchangedIntegralLabel = [[UILabel alloc] init];
    exchangedIntegralLabel.textColor = [UIColor whiteColor];
    exchangedIntegralLabel.font = [UIFont systemFontOfSize:31];
    [self addSubview:exchangedIntegralLabel];
    self.exchangedIntegralLabel = exchangedIntegralLabel;
    
    //汇点Lable
    UILabel *selfUnitLabel = [[UILabel alloc] init];
    selfUnitLabel.textColor = [UIColor whiteColor];
    selfUnitLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:selfUnitLabel];
    self.selfUnitLabel = selfUnitLabel;
    
    //获取积分成功Lable
    self.successLabel.text = @"获取积分成功";
    
    //银行名称及卡号尾号Lable
    self.bankNameNumLabel.text = @"招商银行信用卡 2843";
    
    //自定义积分按钮
    
    
    //积分总数
    self.integralLabel.text = @"998,54";
    
    //银行积分Lable
    
    
    //换取标识
    
    //可换取
    self.canExchangeLabel.text = @"可换取";
    
    //可以兑换成积分宝积分数量
    self.exchangedIntegralLabel.text = @"200,00";
    
    //汇点Lable
    self.selfUnitLabel.text = @"汇点";
    
//    self.exchangedIntegralLabel.backgroundColor = [UIColor blueColor];
//    self.integralLabel.backgroundColor = [UIColor blueColor];
//    self.exchangeImageView.backgroundColor = [UIColor blueColor];
//    self.myIntegralButton.backgroundColor = [UIColor blueColor];
//    self.bankNameNumLabel.backgroundColor = [UIColor blueColor];
//    self.successLabel.backgroundColor = [UIColor blueColor];
//    self.selfUnitLabel.backgroundColor = [UIColor blueColor];
//    self.canExchangeLabel.backgroundColor = [UIColor blueColor];
//    self.bankIntegralLabel.backgroundColor = [UIColor blueColor];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat spacing = 14;
    //获取积分成功Lable
    CGFloat successLabelX = spacing;
    CGFloat successLabelY = spacing;
    CGFloat successLabelW = 100;
    CGFloat successLabelH = 15;
    self.successLabel.frame = CGRectMake(successLabelX, successLabelY, successLabelW, successLabelH);
    
    //银行名称及卡号尾号Lable
    CGFloat bankNameNumLabelX = spacing;
    CGFloat bankNameNumLabelY = CGRectGetMaxY(self.successLabel.frame) + 4;
    CGFloat bankNameNumLabelW = WIDTH - spacing - 80;
    CGFloat bankNameNumLabelH = 13;
    self.bankNameNumLabel.frame = CGRectMake(bankNameNumLabelX, bankNameNumLabelY, bankNameNumLabelW, bankNameNumLabelH);
    
    //自定义积分按钮
    CGFloat myIntegralButtonY = spacing;
    CGFloat myIntegralButtonW = 69;
    CGFloat myIntegralButtonX = WIDTH - spacing - myIntegralButtonW;
    CGFloat myIntegralButtonH = 20;
    self.myIntegralButton.frame = CGRectMake(myIntegralButtonX, myIntegralButtonY, myIntegralButtonW, myIntegralButtonH);
    
    //取消按钮
    CGFloat cancelButtonY = spacing;
    CGFloat cancelButtonW = 38;
    CGFloat cancelButtonX = WIDTH - spacing - cancelButtonW;
    CGFloat cancelButtonH = 20;
    self.cancelButton.frame = CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH);
    
    //积分总数
    CGFloat integralLabelX = 0;
    CGFloat integralLabelY = CGRectGetMaxY(self.bankNameNumLabel.frame) + 15;
    CGFloat integralLabelW = 100;
    CGFloat integralLabelH = 25;
    self.integralLabel.frame = CGRectMake(integralLabelX, integralLabelY, integralLabelW, integralLabelH);
    [self.integralLabel sizeToFit];
    self.integralLabel.center = CGPointMake(WIDTH * 0.5, self.integralLabel.center.y);
    
    //自定义积分数量输入框
    self.inputTextField.frame = CGRectMake(spacing + 4, CGRectGetMaxY(self.bankNameNumLabel.frame) + spacing, WIDTH - 2 * (spacing + 4), 43);
    
    //银行积分Lable
    CGFloat bankIntegralLabelX = CGRectGetMaxX(self.integralLabel.frame) + 5;
    CGFloat bankIntegralLabelH = 15;
    CGFloat bankIntegralLabelY = CGRectGetMaxY(self.integralLabel.frame) - bankIntegralLabelH - 6;
    CGFloat bankIntegralLabelW = WIDTH - bankIntegralLabelX;
    self.bankIntegralLabel.frame = CGRectMake(bankIntegralLabelX, bankIntegralLabelY, bankIntegralLabelW, bankIntegralLabelH);
    
    //分割线
    CGFloat lineLabelX = 0;
    CGFloat lineLabelY = CGRectGetMaxY(self.integralLabel.frame) + 25;
    CGFloat lineLabelW = WIDTH;
    CGFloat lineLabelH = 0.5;
    self.lineLabel.frame = CGRectMake(lineLabelX, lineLabelY, lineLabelW, lineLabelH);
    
    //换取标识
    CGFloat exchangeImageViewX = 0;
    CGFloat exchangeImageViewY = 0;
    CGFloat exchangeImageViewW = 20;
    CGFloat exchangeImageViewH = 20;
    self.exchangeImageView.frame = CGRectMake(exchangeImageViewX, exchangeImageViewY, exchangeImageViewW, exchangeImageViewH);
    self.exchangeImageView.center = self.lineLabel.center;
    
    //可换取
    CGFloat canExchangeLabelX = spacing;
    CGFloat canExchangeLabelY = CGRectGetMaxY(self.lineLabel.frame) + 15;
    CGFloat canExchangeLabelW = 50;
    CGFloat canExchangeLabelH = 15;
    self.canExchangeLabel.frame = CGRectMake(canExchangeLabelX, canExchangeLabelY, canExchangeLabelW, canExchangeLabelH);
    
    //可以兑换成积分宝积分数量
    CGFloat exchangedIntegralLabelX = 0;
    CGFloat exchangedIntegralLabelY = CGRectGetMaxY(self.canExchangeLabel.frame);
    CGFloat exchangedIntegralLabelW = 100;
    CGFloat exchangedIntegralLabelH = 25;
    self.exchangedIntegralLabel.frame = CGRectMake(exchangedIntegralLabelX, exchangedIntegralLabelY, exchangedIntegralLabelW, exchangedIntegralLabelH);
    [self.exchangedIntegralLabel sizeToFit];
    self.exchangedIntegralLabel.center = CGPointMake(self.lineLabel.center.x, self.exchangedIntegralLabel.center.y);
    
    //汇点Lable
    CGFloat selfUnitLabelX = CGRectGetMaxX(self.exchangedIntegralLabel.frame) + 5;
    CGFloat selfUnitLabelH = 15;
    CGFloat selfUnitLabelY = CGRectGetMaxY(self.exchangedIntegralLabel.frame) - selfUnitLabelH - 6;
    CGFloat selfUnitLabelW = 30;
    self.selfUnitLabel.frame = CGRectMake(selfUnitLabelX, selfUnitLabelY, selfUnitLabelW, selfUnitLabelH);
    
}

- (void)customCancelClickedAction:(UIButton *)button
{

    if ([self.delegate respondsToSelector:@selector(AddBankHeadViewClickedAction:button:index:)]) {
        if (button == self.myIntegralButton) {
            
            self.myIntegralButton.hidden = YES;
            self.cancelButton.hidden = NO;
            
            self.integralLabel.hidden = YES;
            self.bankIntegralLabel.hidden = YES;
            self.exchangeImageView.hidden = YES;
            self.inputTextField.hidden = NO;
           
            [self setCreat:self.inputTextField.text];
            
            
            [self.delegate AddBankHeadViewClickedAction:self button:button index:0];
            
        } else if (button == self.cancelButton) {
            
            self.cancelButton.hidden = YES;
            self.myIntegralButton.hidden = NO;
            
            self.inputTextField.hidden = YES;
            self.integralLabel.hidden = NO;
            self.bankIntegralLabel.hidden = NO;
            self.exchangeImageView.hidden = NO;
            
            [self.inputTextField resignFirstResponder];
            [self setCreat:self.bankInfoModel.bank_credit];
            
            [self.delegate AddBankHeadViewClickedAction:self button:button index:1];
        }
    }
    
}

- (void)setBankInfoModel:(BankInfoModel *)bankInfoModel
{
    _bankInfoModel = bankInfoModel;
    
    //银行名称及卡号尾号Lable
    self.bankNameNumLabel.text = [NSString stringWithFormat:@"%@ %@", bankInfoModel.bank_info, bankInfoModel.bank_number];
    
    //积分总数
    self.integralLabel.text = [NSString stringWithFormat:@"%@", bankInfoModel.bank_credit];
    
    //可以兑换成积分宝积分数量
    CGFloat cread = [bankInfoModel.bank_credit floatValue];
    CGFloat rate = [bankInfoModel.bank_rate floatValue];
    self.exchangedIntegralLabel.text = [NSString stringWithFormat:@"%.2f", cread * rate];
    
}


+ (AddBankHeadView *)addBankHeadView
{
    return [[AddBankHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 210)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *textFieldStr = [NSString stringWithFormat:@"%@%@", textField.text, string];
    CGFloat textFieldDigital = [textFieldStr floatValue];
    CGFloat bankCread = [self.bankInfoModel.bank_credit floatValue];
    if (textFieldDigital <= bankCread) {
        
//        CGFloat rate = [self.bankInfoModel.bank_rate floatValue];
//        self.exchangedIntegralLabel.text = [NSString stringWithFormat:@"%.2f", textFieldDigital * rate];
//        [self.exchangedIntegralLabel sizeToFit];
        [self setCreat:textFieldStr];
        
    } else {
        [self setAlertViewWithMessage:@"亲,你没有足够的积分哦~~~~~,快去赚取积分吧!"];
        return NO;
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setCreat:self.inputTextField.text];
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)setCreat:(NSString *)string
{
    CGFloat textFieldDigital = [string floatValue];
    CGFloat rate = [self.bankInfoModel.bank_rate floatValue];
    self.exchangedIntegralLabel.text = [NSString stringWithFormat:@"%.2f", textFieldDigital * rate];
    [self.exchangedIntegralLabel sizeToFit];
}


@end
