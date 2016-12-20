//
//  TripReasonView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripReasonView.h"
#import "Masonry.h"

@interface TripReasonView ()<UITextFieldDelegate>

/**出差事由描述 */
@property (nonatomic, strong) UILabel *ccsyLabel;
@property (nonatomic, strong) UITextView *ccsyTextView;

/**个人意见 */
@property (nonatomic, strong) UILabel *gryjLabel;
@property (nonatomic, strong) UITextView *gryjTextView;

/**常用意见 */
@property (nonatomic, strong) UILabel *cyyjLabel;
@property (nonatomic, strong) UITextField *cyyjTextField;

@end

@implementation TripReasonView
/**开始时间 */
- (UILabel *)cyyjLabel{
    
    if (!_cyyjLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"常用意见";
        label.font = [UIFont systemFontOfSize:15];
        _cyyjLabel = label;
    }
    return _cyyjLabel;
}

- (UITextField *)cyyjTextField{
    
    if (!_cyyjTextField) {
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"请选择常用意见";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.delegate = self;
        _cyyjTextField = textField;
    }
    return _cyyjTextField;
}

/* 出差事由描述 */

- (UILabel *)ccsyLabel{
    
    if (!_ccsyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"出差事由";
        label.font = [UIFont systemFontOfSize:15];
        _ccsyLabel = label;
    }
    return _ccsyLabel;
}

- (UITextView *)ccsyTextView{
    if (!_ccsyTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.font = [UIFont systemFontOfSize:15];
        textView.layer.cornerRadius = 5;
        textView.layer.masksToBounds = YES;
        textView.layer.borderColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:193.0/255.0].CGColor;
        textView.layer.borderWidth = 0.5;
        _ccsyTextView = textView;
    }
    return _ccsyTextView;
}

//个人意见
- (UILabel *)gryjLabel{
    if (!_gryjLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"个人意见";
        label.font = [UIFont systemFontOfSize:15];
        _gryjLabel = label;
    }
    return _gryjLabel;
}

- (UITextView *)gryjTextView{
    if (!_gryjTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.font = [UIFont systemFontOfSize:15];
        textView.layer.cornerRadius = 5;
        textView.layer.masksToBounds = YES;
        textView.layer.borderColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:193.0/255.0].CGColor;
        textView.layer.borderWidth = 0.5;
        _gryjTextView = textView;
    }
    return _gryjTextView;
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
    titlelabel.text = @"事由和意见";
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
    
    //出差事由
    [self addSubview:self.ccsyLabel];
    [self addSubview:self.ccsyTextView];
    
    //个人意见
    [self addSubview:self.gryjLabel];
    [self addSubview:self.gryjTextView];
    
    /**常用意见 */
    [self addSubview:self.cyyjLabel];
    [self addSubview:self.cyyjTextField];
    
    //出差事由
    [self.ccsyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    [self.ccsyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ccsyLabel.mas_bottom).offset(5);
        make.left.equalTo(self.ccsyLabel.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(150);
    }];
    
    //出差事由
    [self.gryjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.ccsyTextView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    [self.gryjTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gryjLabel.mas_bottom).offset(5);
        make.left.equalTo(self.gryjLabel.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(150);
    }];
    
    //添加约束
    [self.cyyjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.gryjTextView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.cyyjTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cyyjLabel.mas_top).offset(0);
        make.bottom.equalTo(self.cyyjLabel.mas_bottom).offset(0);
        make.left.equalTo(self.cyyjLabel.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(- 10);
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.cyyjTextField) {
        //开始时间
        [self.cyyjTextField resignFirstResponder];
        [self chooseCommonReason];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 选择常用意见

- (void)chooseCommonReason{
    
    if (self.reasonDelegate && [self.reasonDelegate respondsToSelector:@selector(chooseCommonReasonWithTripReasonView:)]) {
        [self.reasonDelegate chooseCommonReasonWithTripReasonView:self];
    }
}


#pragma mark - Property setter and getter

//出差事由
- (NSString *)ccsy{
    
    return self.ccsyTextView.text;
}

- (void)setCcsy:(NSString *)ccsy{
    self.ccsyTextView.text = ccsy;
}

//个人意见
- (NSString *)gryj{
    return self.gryjTextView.text;
}

- (void)setGryj:(NSString *)gryj{
    self.gryjTextView.text = gryj;
}

//常用意见
- (NSString *)cyyj{
    return self.cyyjTextField.text;
}

- (void)setCyyj:(NSString *)cyyj{
    self.cyyjTextField.text = cyyj;
}


@end
