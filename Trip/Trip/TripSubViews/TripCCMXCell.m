//
//  TripCCMXCell.m
//  gdoaDemo
//
//  Created by YXT on 2016/12/16.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripCCMXCell.h"


@interface TripCCMXCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UITextField *monthTextField;//月

@property (weak, nonatomic) IBOutlet UITextField *dayTextField;//年

@property (weak, nonatomic) IBOutlet UITextField *beginAddressTextField;//出发地

@property (weak, nonatomic) IBOutlet UITextField *endTextField;//目的地

@property (weak, nonatomic) IBOutlet UITextField *daysCountTextField;//天数

@property (weak, nonatomic) IBOutlet UITextField *bzTextField;//补助

@property (weak, nonatomic) IBOutlet UITextField *kmlxTextField;//科目类型

@property (weak, nonatomic) IBOutlet UITextField *jeTextField;//金额

@property (weak, nonatomic) IBOutlet UITextField *djzsTextField;//单据张数

@property (weak, nonatomic) IBOutlet UITextField *fpdmTextField;//发票代码

@property (weak, nonatomic) IBOutlet UITextField *fphmTextField;//发票号码

@end

@implementation TripCCMXCell

- (void)awakeFromNib {
    // Initialization code
    
    self.monthTextField.delegate = self;
    self.dayTextField.delegate = self;
    self.beginAddressTextField.delegate = self;
    self.endTextField.delegate = self;
    self.daysCountTextField.delegate = self;
    self.bzTextField.delegate = self;
    self.kmlxTextField.delegate = self;
    self.jeTextField.delegate = self;
    self.djzsTextField.delegate = self;
    self.fpdmTextField.delegate = self;
    self.fphmTextField.delegate = self;
    
    [self.jeTextField addTarget:self action:@selector(jeValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBtnAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteCellWithIndexPath:)]) {
        [self.delegate deleteCellWithIndexPath:self.model.indexPath];
    }
}

- (void)setModel:(CCMXModel *)model{
     //_model = a;
    _model = model;
    
    if (model.showBtn) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    //title
    self.titleLabel.text = [NSString stringWithFormat:@"出差明细（%ld）",model.indexPath.row+1];
    
    
    self.monthTextField.text = model.month;
    self.dayTextField.text = model.day;
    self.beginAddressTextField.text = model.qsdd;
    self.endTextField.text = model.mdd;
    self.daysCountTextField.text = model.ts;
    self.bzTextField.text = model.bz;
    self.kmlxTextField.text = [model.kmlx valueForKey:@"name"];
    self.jeTextField.text = model.je;
    self.djzsTextField.text = model.djzs;
    self.fpdmTextField.text = model.fpdm;
    self.fphmTextField.text = model.fphm;
}




#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.kmlxTextField) {
        [self.kmlxTextField resignFirstResponder];
        [self ccmxChooseKMLX];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
     
    if (textField == self.monthTextField) {
        self.model.month = textField.text;
        
    }else if (textField == self.dayTextField) {
        self.model.day = textField.text;
        
    }else if (textField == self.beginAddressTextField) {
        self.model.qsdd = textField.text;
        
    }else if (textField == self.endTextField) {
        self.model.mdd = textField.text;
        
    }else if (textField == self.daysCountTextField) {
        self.model.ts = textField.text;
        
    }else if (textField == self.bzTextField) {
        self.model.bz = textField.text;
        
    }else if (textField == self.djzsTextField) {
        self.model.djzs = textField.text;
        
    }else if (textField == self.fpdmTextField) {
        self.model.fpdm = textField.text;
        
    }else if (textField == self.fphmTextField) {
        self.model.fphm = textField.text;
    } 
}

- (void)ccmxChooseKMLX{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseKmlxWithCell:indexPath:)]) {
        [self.delegate chooseKmlxWithCell:self indexPath:self.model.indexPath];
    }
}

- (void)jeValueChanged:(UITextField *)textField{
    
    self.model.je = textField.text; 
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TripHjjeAddNotificationName" object:nil];
}

@end
