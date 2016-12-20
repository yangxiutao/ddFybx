//
//  TripCzView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//  

#import "TripCzView.h"
#import "Masonry.h"

@interface TripCzView ()<UITextFieldDelegate>

@property (strong, nonatomic)  UILabel *sfczLabel;//是否冲账
@property (strong, nonatomic)  UILabel *czkmLabel;//冲账科目
@property (strong, nonatomic)  UILabel *yjkLabel;//原借款
@property (strong, nonatomic)  UILabel *ytbceLabel;//应退补差额


@property (strong, nonatomic)  UISwitch *sfczSwitch;
@property (strong, nonatomic)  UITextField *czkmTextField;//冲账科目
@property (strong, nonatomic)  UITextField *yjkTextField;//原借款
@property (strong, nonatomic)  UITextField *ytbceTextField;//应退补差额


@end

@implementation TripCzView

//是否冲账
- (UILabel *)sfczLabel{
    if (!_sfczLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"是否冲账";
        label.font = [UIFont systemFontOfSize:15];
        _sfczLabel = label;
    }
    return _sfczLabel;
}

- (UISwitch *)sfczSwitch{
    
    if (!_sfczSwitch) {
        _sfczSwitch = [[UISwitch alloc]init];
        [_sfczSwitch addTarget:self action:@selector(sfzc:) forControlEvents:UIControlEventValueChanged];
    }
    return _sfczSwitch;
}

- (UILabel *)czkmLabel{
    if (!_czkmLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"冲账科目";
        label.font = [UIFont systemFontOfSize:15];
        _czkmLabel = label;
    }
    return _czkmLabel;
}

- (UITextField *)czkmTextField{
    
    if (!_czkmTextField) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请选择冲账科目";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _czkmTextField = textField;
    }
    return _czkmTextField;
}

- (UILabel *)yjkLabel{
    if (!_yjkLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"原借款(元)";
        label.font = [UIFont systemFontOfSize:15];
        _yjkLabel = label;
    }
    return _yjkLabel;
}

- (UITextField *) yjkTextField{
    
    if (!_yjkTextField) {
        _yjkTextField = [[UITextField alloc]init];
        _yjkTextField.placeholder = @"0.00";
        _yjkTextField.borderStyle = UITextBorderStyleRoundedRect;
        _yjkTextField.font = [UIFont systemFontOfSize:15];
        _yjkTextField.delegate = self;
        
    }
    return _yjkTextField;
}

- (UILabel *)ytbceLabel{
    if (!_ytbceLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"应退/补差额";
        label.font = [UIFont systemFontOfSize:15];
        _ytbceLabel = label;
    }
    return _ytbceLabel;
}

- (UITextField *)ytbceTextField{
    
    if (!_ytbceTextField) {
        _ytbceTextField = [[UITextField alloc]init];
        _ytbceTextField.placeholder = @"0.00";
        _ytbceTextField.font = [UIFont systemFontOfSize:15];
        _ytbceTextField.borderStyle = UITextBorderStyleRoundedRect;
        _ytbceTextField.delegate = self;
    }
    return _ytbceTextField;
}

- (instancetype)initWithFrame:(CGRect)frame sfcz:(BOOL)sfcz{
    
    if ([self initWithFrame:frame]) {
        [self addSubViews:sfcz];
        
    }
    return self;
}

- (void)addSubViews:(BOOL)sfcz{
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self addSubview:topView];
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"借款情况";
    titlelabel.textColor = [UIColor lightGrayColor];
    titlelabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:titlelabel];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset   (10);
        make.bottom.equalTo(topView.mas_bottom).offset(0);
    }];
    
    //是否冲账
    [self addSubview:self.sfczLabel];
    [self addSubview:self.sfczSwitch];
    [self.sfczSwitch setOn:sfcz];
    
    //冲账科目
    [self addSubview:self.czkmLabel];
    [self addSubview:self.czkmTextField];
    
    //原借款
    [self addSubview:self.yjkLabel];
    [self addSubview:self.yjkTextField];

    //应退补差额
    [self addSubview:self.ytbceLabel];
    [self addSubview:self.ytbceTextField];
    
    //是否冲账
    [self.sfczSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [self.sfczLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sfczSwitch.mas_top).offset(0);
        make.bottom.equalTo(self.sfczSwitch.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
    }];
    
    //冲账科目
    [self.czkmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.sfczLabel.mas_bottom).offset(10);
        make.left.equalTo(self.sfczLabel.mas_left).offset(0);
        make.right.equalTo(self.sfczLabel.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.czkmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.czkmLabel.mas_top).offset(0);
        make.left.equalTo(self.czkmLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(self.czkmLabel.mas_height).offset(0);
        
    }];
    
    //原借款
    [self.yjkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.czkmLabel.mas_bottom).offset(10);
        make.left.equalTo(self.czkmLabel.mas_left).offset(0);
        make.right.equalTo(self.czkmLabel.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.yjkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.yjkLabel.mas_top).offset(0);
        make.left.equalTo(self.yjkLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(self.yjkLabel.mas_height).offset(0);
        
    }];
    
    //应退补差额
    [self.ytbceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.yjkLabel.mas_bottom).offset(10);
        make.left.equalTo(self.yjkLabel.mas_left).offset(0);
        make.right.equalTo(self.yjkLabel.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.ytbceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.ytbceLabel.mas_top).offset(0);
        make.left.equalTo(self.ytbceLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(self.ytbceLabel.mas_height).offset(0);
        
    }];
    
    
    if (!sfcz) {
        //不冲帐
        
        //冲账科目
        self.czkmLabel.text = @"";
        [self.czkmLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfczLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        //应退补差额
        self.ytbceLabel.text = @"";
        [self.ytbceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yjkLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
    }
    
    
    
    
}


#pragma mark - 是否冲账
- (void)sfzc:(UISwitch *)aSwitch{
    
    if (aSwitch.on) {
        
        //冲账科目
        self.czkmLabel.text = @"冲账科目";
        [self.czkmLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfczLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        //应退补差额
        self.ytbceLabel.text = @"应退/补差额";
        [self.ytbceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yjkLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        [aSwitch setOn:YES animated:YES];
        
    }else{
        
        //冲账科目
        self.czkmLabel.text = @"";
        [self.czkmLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfczLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        //应退补差额
        self.ytbceLabel.text = @"";
        [self.ytbceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yjkLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        [aSwitch setOn:NO animated:YES];
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(czView:sfcz:)]) {
        [self.delegate czView:self sfcz:aSwitch.on];
    }
}



#pragma mark - 选择冲账科目

- (void)chooseCZKM{
    NSLog(@"选择冲账科目");
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseCZKWWithCzView:)]) {
        [self.delegate chooseCZKWWithCzView:self];
    }
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.czkmTextField) {
        [self.yjkTextField resignFirstResponder];
        [self.czkmTextField resignFirstResponder];
        [self chooseCZKM];
    }else  if (textField == self.ytbceTextField) {
        [self.ytbceTextField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Property setter and getter

//是否冲账
- (NSString *)sfcz{
    if (self.sfczSwitch.on) {
        return @"1";
    }else{
        return @"0";
    }
}

- (void)setSfcz:(NSString *)sfcz{
    if (sfcz.integerValue == 1) {
        //冲账
        //冲账科目
        self.czkmLabel.text = @"冲账科目";
        [self.czkmLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfczLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        //应退补差额
        self.ytbceLabel.text = @"应退/补差额";
        [self.ytbceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yjkLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        [self.sfczSwitch setOn:YES animated:YES];
    }else if (sfcz.integerValue == 0) {
        //不冲帐
        //冲账科目
        self.czkmLabel.text = @"";
        [self.czkmLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sfczLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        //应退补差额
        self.ytbceLabel.text = @"";
        [self.ytbceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yjkLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        [self.sfczSwitch setOn:NO animated:YES];
    }
}

//冲账科目
- (NSString *)czkm{
    return self.czkmTextField.text;
}

- (void)setCzkm:(NSString *)czkm{
    self.czkmTextField.text = czkm;
}

//原借款
- (NSString *)yjk{
    return self.yjkTextField.text;
}

- (void)setYjk:(NSString *)yjk{
    self.yjkTextField.text = yjk;
}

//应退补差额
- (void)setYtbce:(NSString *)ytbce{
    self.ytbceTextField.text = ytbce;
}

- (NSString *)ytbce{
    return self.ytbceTextField.text;
}


@end
