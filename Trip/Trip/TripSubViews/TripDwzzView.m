//
//  TripDwzzView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripDwzzView.h"
#import "Masonry.h"

static CGFloat labelHeight = 30.0f;
static CGFloat labelWidth = 100.f;
static CGFloat margin = 10.0f;

@interface TripDwzzView ()<UITextFieldDelegate>

/**单位名称 */
@property (nonatomic, strong) UILabel *dwmcLabel;
@property (nonatomic, strong) UITextField *dwmcTextField;

/**开户行及支行 */
@property (nonatomic, strong) UILabel *khhLabel;
@property (nonatomic, strong) UITextField *khhTextField;

/**省市 */
@property (nonatomic, strong) UILabel *ssLabel;
@property (nonatomic, strong) UITextField *ssTextField;

/**银行账号 */
@property (nonatomic, strong) UILabel *yhzhLabel;
@property (nonatomic, strong) UITextField *yhzhTextField;

/** 金额*/
@property (nonatomic, strong) UILabel *jeLabel;
@property (nonatomic, strong) UITextField *jeTextField;

/**身份证号*/
@property (nonatomic, strong) UILabel *sfzhmLabel;
@property (nonatomic, strong) UITextField *sfzhmTextField;

/**备注描述 */
@property (nonatomic, strong) UILabel *bzLabel;
@property (nonatomic, strong) UITextView *bzTextView;

@end

@implementation TripDwzzView

/**单位名称 */
- (UILabel *)dwmcLabel{
    
    if (!_dwmcLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"单位名称";
        label.font = [UIFont systemFontOfSize:15];
        _dwmcLabel = label;
    }
    return _dwmcLabel;
}

- (UITextField *)dwmcTextField{
    
    if (!_dwmcTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写单位名称";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _dwmcTextField = textField;
    }
    return _dwmcTextField;
}

/**开户行 */
- (UILabel *)khhLabel{
    
    if (!_khhLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"开户行";
        label.font = [UIFont systemFontOfSize:15];
        _khhLabel = label;
    }
    return _khhLabel;
}

- (UITextField *)khhTextField{
    
    if (!_khhTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写开户行及支行名称";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _khhTextField = textField;
    }
    return _khhTextField;
}

/**省市 */

- (UILabel *)ssLabel{
    
    if (!_ssLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"省市";
        label.font = [UIFont systemFontOfSize:15];
        _ssLabel = label;
    }
    return _ssLabel;
}

- (UITextField *)ssTextField{
    
    if (!_ssTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请选择省市";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _ssTextField = textField;
    }
    return _ssTextField;
}

/**银行账号 */

- (UILabel *)yhzhLabel{
    
    if (!_yhzhLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"银行账号";
        label.font = [UIFont systemFontOfSize:15];
        _yhzhLabel = label;
    }
    return _yhzhLabel;
}

- (UITextField *)yhzhTextField{
    
    if (!_yhzhTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写银行账号";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _yhzhTextField = textField;
    }
    return _yhzhTextField;
}

/**金额 */

- (UILabel *)jeLabel{
    
    if (!_jeLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"金额";
        label.font = [UIFont systemFontOfSize:15];
        _jeLabel = label;
    }
    return _jeLabel;
}

- (UITextField *)jeTextField{
    
    if (!_jeTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写金额";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _jeTextField = textField;
    }
    return _jeTextField;
}

/**身份证号 */

- (UILabel *)sfzhmLabel{
    
    if (!_sfzhmLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"身份证号";
        label.font = [UIFont systemFontOfSize:15];
        _sfzhmLabel = label;
    }
    return _sfzhmLabel;
}

- (UITextField *)sfzhmTextField{
    
    if (!_sfzhmTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写身份证号";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _sfzhmTextField = textField;
    }
    return _sfzhmTextField;
}

/* 备注描述 */

- (UILabel *)bzLabel{
    
    if (!_bzLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"备注";
        label.font = [UIFont systemFontOfSize:15];
        _bzLabel = label;
    }
    return _bzLabel;
}

- (UITextView *)bzTextView{
    if (!_bzTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.font = [UIFont systemFontOfSize:15];
        textView.layer.cornerRadius = 5;
        textView.layer.masksToBounds = YES;
        textView.layer.borderColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:193.0/255.0].CGColor;
        textView.layer.borderWidth = 0.5;
        _bzTextView = textView;
    }
    return _bzTextView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        //self.backgroundColor = [UIColor orangeColor];
    }
    
    return self;
}

- (void)setUp{
    
    /**单位名称 */
    [self addSubview:self.dwmcLabel];
    [self addSubview:self.dwmcTextField];
    
    /**开户行 */
    [self addSubview:self.khhLabel];
    [self addSubview:self.khhTextField];
    
    /**省市 */
    [self addSubview:self.ssLabel];
    [self addSubview:self.ssTextField];
    
    /**银行账号 */
    [self addSubview:self.yhzhLabel];
    [self addSubview:self.yhzhTextField];
    
    /**金额 */
    [self addSubview:self.jeLabel];
    [self addSubview:self.jeTextField];
    
    /**身份证号 */
    [self addSubview:self.sfzhmLabel];
    [self addSubview:self.sfzhmTextField];
    
    //备注
    [self addSubview:self.bzLabel];
    [self addSubview:self.bzTextView];
    
    //添加约束
    [self.dwmcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.dwmcTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dwmcLabel.mas_top).offset(0);
        make.bottom.equalTo(self.dwmcLabel.mas_bottom).offset(0);
        make.left.equalTo(self.dwmcLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**开户行 */
    [self.khhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.dwmcLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.khhTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.khhLabel.mas_top).offset(0);
        make.bottom.equalTo(self.khhLabel.mas_bottom).offset(0);
        make.left.equalTo(self.khhLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**省市 */
    
    [self.ssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.khhLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.ssTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ssLabel.mas_top).offset(0);
        make.bottom.equalTo(self.ssLabel.mas_bottom).offset(0);
        make.left.equalTo(self.ssLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**银行账号 */
    
    [self.yhzhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.ssLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.yhzhTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yhzhLabel.mas_top).offset(0);
        make.bottom.equalTo(self.yhzhLabel.mas_bottom).offset(0);
        make.left.equalTo(self.yhzhLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**金额 */
    
    [self.jeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.yhzhLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.jeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jeLabel.mas_top).offset(0);
        make.bottom.equalTo(self.jeLabel.mas_bottom).offset(0);
        make.left.equalTo(self.jeLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**身份证号 */
    
    [self.sfzhmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.jeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.sfzhmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sfzhmLabel.mas_top).offset(0);
        make.bottom.equalTo(self.sfzhmLabel.mas_bottom).offset(0);
        make.left.equalTo(self.sfzhmLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    //备注
    [self.bzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.sfzhmLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.bzTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bzLabel.mas_top).offset(0);
        //make.bottom.equalTo(self.sfzhmLabel.mas_bottom).offset(0);
        make.left.equalTo(self.sfzhmLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
        make.height.mas_equalTo(150);
    }];
}

@end
