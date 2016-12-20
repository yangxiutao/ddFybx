//
//  TirpDateView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripDateView.h"
#import "Masonry.h"

static CGFloat labelHeight = 30.0f;
static CGFloat labelWidth = 100.f;
static CGFloat margin = 10.0f;

@interface TripDateView ()<UITextFieldDelegate>

/**开始时间 */
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UITextField *startTimeTextField;

/**结束时间 */
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UITextField *endTimeTextField;

/**共计（天） */
@property (nonatomic, strong) UILabel *gjLabel;
@property (nonatomic, strong) UITextField *gjTextField;

/**单据张数(张) */
@property (nonatomic, strong) UILabel *dzjsLabel;
@property (nonatomic, strong) UITextField *dzjsTextField;

@end

@implementation TripDateView

/**开始时间 */
- (UILabel *)startTimeLabel{
    
    if (!_startTimeLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"开始时间";
        label.font = [UIFont systemFontOfSize:15];
        _startTimeLabel = label;
    }
    return _startTimeLabel;
}

- (UITextField *)startTimeTextField{
    
    if (!_startTimeTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = [self getCurrentTime];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _startTimeTextField = textField;
    }
    return _startTimeTextField;
}

/**开户行 */
- (UILabel *)endTimeLabel{
    
    if (!_endTimeLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"结束时间";
        label.font = [UIFont systemFontOfSize:15];
        _endTimeLabel = label;
    }
    return _endTimeLabel;
}

- (UITextField *)endTimeTextField{
    
    if (!_endTimeTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = [self getCurrentTime];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _endTimeTextField = textField;
    }
    return _endTimeTextField;
}

/**共计（天） */

- (UILabel *)gjLabel{
    
    if (!_gjLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"共计（天）";
        label.font = [UIFont systemFontOfSize:15];
        _gjLabel = label;
    }
    return _gjLabel;
}

- (UITextField *)gjTextField{
    
    if (!_gjTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"0";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _gjTextField = textField;
    }
    return _gjTextField;
}

/**单据张数(张) */

- (UILabel *)dzjsLabel{
    
    if (!_dzjsLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"单据张数(张)";
        label.font = [UIFont systemFontOfSize:15];
        _dzjsLabel = label;
    }
    return _dzjsLabel;
}

- (UITextField *)dzjsTextField{
    
    if (!_dzjsTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请填写单据张数(张)";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _dzjsTextField = textField;
    }
    return _dzjsTextField;
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
    titlelabel.text = @"出差日期";
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
    
    
    /**开始时间 */
    [self addSubview:self.startTimeLabel];
    [self addSubview:self.startTimeTextField];
    
    /**开户行 */
    [self addSubview:self.endTimeLabel];
    [self addSubview:self.endTimeTextField];
    
    /**共计（天） */
    [self addSubview:self.gjLabel];
    [self addSubview:self.gjTextField];
    
    /**单据张数(张) */
    [self addSubview:self.dzjsLabel];
    [self addSubview:self.dzjsTextField];
    
    //添加约束
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.startTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeLabel.mas_top).offset(0);
        make.bottom.equalTo(self.startTimeLabel.mas_bottom).offset(0);
        make.left.equalTo(self.startTimeLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**开户行 */
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.startTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.endTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTimeLabel.mas_top).offset(0);
        make.bottom.equalTo(self.endTimeLabel.mas_bottom).offset(0);
        make.left.equalTo(self.endTimeLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**共计（天） */
    
    [self.gjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.endTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.gjTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gjLabel.mas_top).offset(0);
        make.bottom.equalTo(self.gjLabel.mas_bottom).offset(0);
        make.left.equalTo(self.gjLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
    
    /**单据张数(张) */
    
    [self.dzjsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.gjLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(labelHeight);
    }];
    
    [self.dzjsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dzjsLabel.mas_top).offset(0);
        make.bottom.equalTo(self.dzjsLabel.mas_bottom).offset(0);
        make.left.equalTo(self.dzjsLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- margin);
    }];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.startTimeTextField) {
        //开始时间
        [self.startTimeTextField resignFirstResponder];
        [self chooseStartTime];
    }else if (textField == self.endTimeTextField) {
        //结束时间
        [self.endTimeTextField resignFirstResponder];
        [self chooseEndTime];
    }else if (textField == self.endTimeTextField) {
        //共计
        [self.endTimeTextField resignFirstResponder];
        //[self chooseStartTime];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//选择开始时间
- (void)chooseStartTime{
    
    if (self.dateDelegate && [self.dateDelegate respondsToSelector:@selector(dateView:startOrEndTag:)]) {
        [self.dateDelegate dateView:self startOrEndTag:0];
    }
}

//选择结束时间
- (void)chooseEndTime{
    if (self.dateDelegate && [self.dateDelegate respondsToSelector:@selector(dateView:startOrEndTag:)]) {
        [self.dateDelegate dateView:self startOrEndTag:1];
    }
}



#pragma mark - Property setter and getter

//开始时间
- (NSString *)startTime{
    if ([self.startTimeTextField.placeholder isEqualToString:[self getCurrentTime]] && self.startTimeTextField.text.length == 0) {
        return self.startTimeTextField.placeholder;
    }
    return self.startTimeTextField.text;
}

- (void)setStartTime:(NSString *)startTime{
    self.startTimeTextField.text = startTime;
}

//结束时间
- (NSString *)endTime{
    
    if ([self.endTimeTextField.placeholder isEqualToString:[self getCurrentTime]] && self.endTimeTextField.text.length == 0) {
        return self.endTimeTextField.placeholder;
    }
    return self.endTimeTextField.text;
}

- (void)setEndTime:(NSString *)endTime{
    self.endTimeTextField.text = endTime;
}

//共计
- (NSString *)gj{
    return self.gjTextField.text;
}

- (void)setGj:(NSString *)gj{
    self.gjTextField.text = gj;
}

//单据张数
- (NSString *)djzs{
    return self.dzjsTextField.text;
}

- (void)setDjzs:(NSString *)djzs{
    self.dzjsTextField.text = djzs;
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
