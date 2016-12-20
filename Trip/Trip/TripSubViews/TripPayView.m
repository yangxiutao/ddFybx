//
//  TripPayView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripPayView.h"
#import "Masonry.h"
#import "TripDwzzView.h"

@interface TripPayView ()<UITextFieldDelegate>

@property (strong, nonatomic)  UILabel *fkfsLabel;// 付款方式

@property (strong, nonatomic)  UITextField *fkfsTextField;

@property (nonatomic, strong) TripDwzzView *dwzzDeteilView;//对外转账界面

@end

@implementation TripPayView

- (UILabel *)fkfsLabel{
    if (!_fkfsLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"付款方式";
        label.font = [UIFont systemFontOfSize:15];
        _fkfsLabel = label;
    }
    return _fkfsLabel;
}

- (UITextField *)fkfsTextField{
    
    if (!_fkfsTextField) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请选择冲付款方式";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _fkfsTextField = textField;
    }
    return _fkfsTextField;
}

- (TripDwzzView *)dwzzDeteilView{
    
    if (!_dwzzDeteilView) {
        _dwzzDeteilView = [[TripDwzzView alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 400)];
    }
    return _dwzzDeteilView;
}

- (instancetype)initWithFrame:(CGRect)frame fkfsSytle:(TripPayStyle)fkfs{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        [self addSubViews:fkfs];
    }
    return self;
}

- (void)addSubViews:(TripPayStyle)fkfs{
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self addSubview:topView];
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"付款情况";
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
    
    [self addSubview:self.fkfsLabel];
    [self addSubview:self.fkfsTextField];
    
    
    [self.fkfsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.fkfsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fkfsLabel.mas_top).offset(0);
        make.bottom.equalTo(self.fkfsLabel.mas_bottom).offset(0);
        make.left.equalTo(self.fkfsLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    
    
    //对外转账详细信息
    if (fkfs == TripPayStyleWy) {
        [self.dwzzDeteilView removeFromSuperview];
        
    }else if (fkfs == TripPayStyleDwzz){
        [self addSubview:self.dwzzDeteilView];
    }
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.fkfsTextField) {
        [self.fkfsTextField resignFirstResponder];
        [self chooseFKFS];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 选择付款方式
- (void)chooseFKFS{
    NSLog(@"选择付款方式");
    
    if (self.payDelegate && [self.payDelegate respondsToSelector:@selector(choosePayStyleWithTripView:)]) {
        [self.payDelegate choosePayStyleWithTripView:self];
    }
}


#pragma mark - Property setter and getter

//付款方式
- (TripPayStyle)fkfsStyle{
    return self.fkfsStyle;
}

- (void)setFkfsStyle:(TripPayStyle)fkfsStyle{
    if (fkfsStyle == TripPayStyleWy) {
        self.fkfsTextField.text = @"网银";
        [self.dwzzDeteilView removeFromSuperview];
 
        
    }else if (fkfsStyle == TripPayStyleDwzz){
        self.fkfsTextField.text = @"对外转账";
        [self addSubview:self.dwzzDeteilView];
        
 
    }else{
        self.fkfsTextField.text = @"请选择转账方式";
        [self.dwzzDeteilView removeFromSuperview];
        
    }
}


@end
