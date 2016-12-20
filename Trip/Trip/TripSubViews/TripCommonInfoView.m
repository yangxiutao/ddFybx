//
//  TripCommanInfoView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//  基本信息

#import "TripCommonInfoView.h"
#import "Masonry.h"

@interface TripCommonInfoView ()<UITextFieldDelegate>

@property (strong, nonatomic)  UILabel *bxbmLabel;//报销部门
@property (strong, nonatomic)  UILabel *zthLabel;//账套好
@property (strong, nonatomic)  UILabel *tbsjLabel;//填表时间
@property (strong, nonatomic)  UILabel *zbLabel;//职别

@property (strong, nonatomic)  UITextField *bxbmTextField;//报销部门
@property (strong, nonatomic)  UITextField *zthTextField;//账套好
@property (strong, nonatomic)  UITextField *tbsjTextField;//填表时间
@property (strong, nonatomic)  UITextField *zbTextField;//职别

//选择申请人
@property (strong, nonatomic)  UILabel *applyLabel;// 选择申请人
@property (strong, nonatomic)  UILabel *selectedLabel;//已选中的申请人

@end

@implementation TripCommonInfoView

- (UILabel *)bxbmLabel{
    if (!_bxbmLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"报销部门";
        label.font = [UIFont systemFontOfSize:15];
        _bxbmLabel = label;
    }
    return _bxbmLabel;
}

- (UITextField *)bxbmTextField{
    
    if (!_bxbmTextField) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请选择报销部门";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _bxbmTextField = textField;
    }
    return _bxbmTextField;
}

- (UILabel *)zthLabel{
    if (!_zthLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"帐套号";
        label.font = [UIFont systemFontOfSize:15];
        _zthLabel = label;
    }
    return _zthLabel;
}

- (UITextField *)zthTextField{
    
    if (!_zthTextField) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"系统自动生成";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _zthTextField = textField;
    }
    return _zthTextField;
}

- (UILabel *)tbsjLabel{
    if (!_tbsjLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"填表时间";
        label.font = [UIFont systemFontOfSize:15];
        _tbsjLabel = label;
    }
    return _tbsjLabel;
}

- (UITextField *) tbsjTextField{
    
    if (!_tbsjTextField) {
        _tbsjTextField = [[UITextField alloc]init];
        _tbsjTextField.placeholder = [self getCurrentTime];
        _tbsjTextField.borderStyle = UITextBorderStyleRoundedRect;
        _tbsjTextField.font = [UIFont systemFontOfSize:15];
        _tbsjTextField.delegate = self;
 
    }
    return _tbsjTextField;
}

- (UILabel *)zbLabel{
    if (!_zbLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"职别";
        label.font = [UIFont systemFontOfSize:15];
        _zbLabel = label;
    }
    return _zbLabel;
}

- (UITextField *)zbTextField{
    
    if (!_zbTextField) {
        _zbTextField = [[UITextField alloc]init];
        _zbTextField.placeholder = @"请填写职别";
        _zbTextField.font = [UIFont systemFontOfSize:15];
        _zbTextField.borderStyle = UITextBorderStyleRoundedRect;
        _zbTextField.delegate = self;
    }
    return _zbTextField;
}

//申请人
- (UILabel *)applyLabel{
    if (!_applyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"申请人";
        label.font = [UIFont systemFontOfSize:15];
        _applyLabel = label;
    }
    return _applyLabel;
}

- (UILabel *)selectedLabel{
    
    if (!_selectedLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"请选择申请人";
        label.font = [UIFont systemFontOfSize:15];
        label.layer.cornerRadius = 5;
        label.numberOfLines = 0;
        label.layer.masksToBounds = YES;
        label.layer.borderColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:193.0/255.0].CGColor;
        label.layer.borderWidth = 0.5;
        _selectedLabel = label;
    }
    return _selectedLabel;
}


- (void)awakeFromNib{
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
        
    }
    
    return self;
}

- (void)addSubViews{
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self addSubview:topView];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"基本信息";
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
    
    
    //报销部门
    [self addSubview:self.bxbmLabel];
    [self addSubview:self.bxbmTextField];
    //账套好
    [self addSubview:self.zthLabel];
    [self addSubview:self.zthTextField];
    //填表时间
    [self addSubview:self.tbsjLabel];
    [self addSubview:self.tbsjTextField];
    //职别
    [self addSubview:self.zbLabel];
    [self addSubview:self.zbTextField];
    //申请人
    [self addSubview:self.applyLabel];
    [self addSubview:self.selectedLabel];
    
    //报销部门
    [self.bxbmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.bxbmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bxbmLabel.mas_top).offset(0);
        make.left.equalTo(self.bxbmLabel.mas_right).offset(0);
        make.bottom.equalTo(self.bxbmLabel.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    //账套好
    [self.zthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bxbmLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    
    [self.zthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zthLabel.mas_top).offset(0);
        make.left.equalTo(self.zthLabel.mas_right).offset(0);
        make.bottom.equalTo(self.zthLabel.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    //填表时间
    [self.tbsjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.zthLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.tbsjTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbsjLabel.mas_top).offset(0);
        make.left.equalTo(self.tbsjLabel.mas_right).offset(0);
        make.bottom.equalTo(self.tbsjLabel.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    //职别
    [self.zbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tbsjLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    

    [self.zbTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.zbLabel.mas_top).offset(0);
        make.left.equalTo(self.zbLabel.mas_right).offset(0);
        make.bottom.equalTo(self.zbLabel.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        
    }];
    

    //申请人
    [self.applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.zbLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    
    [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.applyLabel.mas_top).offset(0);
        make.left.equalTo(self.applyLabel.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.mas_right).offset(-10);
        
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePerson)];
    [self.selectedLabel addGestureRecognizer:tap];
    self.selectedLabel.userInteractionEnabled = YES;
}

- (void)chooseBXBM{
    NSLog(@"%@",@"报销部门");
    if (self.commonInfoDelegate && [self.commonInfoDelegate respondsToSelector:@selector(commonInfoView:selcted:)]) {
        [self.commonInfoDelegate commonInfoView:self selcted:TripCommonInfoViewSelectedTypeBxbm];
    }
}

- (void)chooseTBSJ{
    NSLog(@"%@",@"填表时间");
    if (self.commonInfoDelegate && [self.commonInfoDelegate respondsToSelector:@selector(commonInfoView:selcted:)]) {
        [self.commonInfoDelegate commonInfoView:self selcted:TripCommonInfoViewSelectedTypeTbsj];
    }
}

- (void)choosePerson{
    NSLog(@"%@",@"申请人");
    if (self.commonInfoDelegate && [self.commonInfoDelegate respondsToSelector:@selector(commonInfoView:selcted:)]) {
        [self.commonInfoDelegate commonInfoView:self selcted:TripCommonInfoViewSelectedTypeApplyPerson];
    }
}


#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.bxbmTextField) {
        [self.zbTextField resignFirstResponder];
        [self.bxbmTextField resignFirstResponder];
        [self chooseBXBM];
    }else  if (textField == self.zthTextField) {
        [self.zbTextField resignFirstResponder];
        [self.zthTextField resignFirstResponder];
        
    }else if (textField == self.tbsjTextField) {
        [self.zbTextField resignFirstResponder];
        [self.tbsjTextField resignFirstResponder];
        [self chooseTBSJ];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Property setter and getter

//申请人
- (NSString *)applyPerson{
    return self.selectedLabel.text;
}

- (void)setApplyPerson:(NSString *)applyPerson{
    self.selectedLabel.text = applyPerson;
}

//填表时间
- (NSString *)tbsj{
    
    if ([self.tbsjTextField.placeholder isEqualToString:[self getCurrentTime]] && self.tbsjTextField.text.length == 0) {
        return self.tbsjTextField.placeholder;
    }

    return self.tbsjTextField.text;
}

- (void)setTbsj:(NSString *)tbsj{
    self.tbsjTextField.text = tbsj;
}

//报销部门
- (NSString *)bxbm{
    return self.bxbmTextField.text;
}

- (void)setBxbm:(NSString *)bxbm{
    self.bxbmTextField.text = bxbm;
}

#pragma mark - 开始时间和结束时间设置初始值，默认今天

- (NSString *)getCurrentTime{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}
@end
