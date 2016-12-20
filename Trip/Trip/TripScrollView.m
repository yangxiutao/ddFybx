//
//  TripScrollView.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "TripScrollView.h"
#import "Masonry.h"
#import "STPickerDate.h"
#import "TripCommonInfoView.h"//基本信息
#import "TripCzView.h"//冲账
#import "TripPayView.h"//付款方式
#import "TripDateView.h"//出差日期
#import "TripReasonView.h"//出差事由和个人意见

#import "TripCCMXCell.h"//出差明细
#import "CCMXModel.h"

#define trip_width [UIScreen mainScreen].bounds.size.width

@interface TripScrollView ()< UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, TripCCMXCellDelegate, TripCzViewDelegate, TripPayViewDelegate, TripDateViewDelegate, STPickerDateDelegate, TripReasonViewDelegate, TripCommonInfoViewDelegate>{
    
    NSInteger _dateTag;//出差日期选择日期标志：0-开始时间，1-结束时间，2-填表时间
    CGFloat _selectedApplyPersonHeihgt;//上一个选中的 applperson 的高度
    NSIndexPath *_ccmxKmlxIndexPath;//那个出差明细的 Indexpath
}

@property (nonatomic, strong) TripCommonInfoView *basicInfoView;//基本信息 View

@property (nonatomic, strong) TripCzView *czView;//冲账

@property (nonatomic, strong) TripPayView *payView;//付款方式

@property (nonatomic, strong) TripDateView *dateView;//出差日期

@property (nonatomic, strong) TripReasonView *reasonView;//出差事由和个人意见

@property (nonatomic, strong) STPickerDate *pickerDate;//时间选择

//选择报销部门
@property (nonatomic, strong) UIActionSheet *bxbmSheet;//报销部门 sheet
@property (nonatomic, strong) NSArray *bxbmArray;

//选择常用意见
@property (nonatomic, strong) UIActionSheet *reasonSheet;//报销部门 sheet
@property (nonatomic, strong) NSArray *reasonArray;//常用意见数组

//选择冲账科目
@property (nonatomic, strong) UIActionSheet *czkmSheet;//报销部门 sheet
@property (nonatomic, strong) NSArray *czkmArray;//常用意见数组

/** 出差明细 */
@property (nonatomic, strong) UITableView *tablView;
@property (nonatomic, strong) NSMutableArray *ccmxData;
@property (nonatomic, strong) UIActionSheet *ccmxSheet;//出差明细选择科目类型
@property (nonatomic, strong) NSArray *ccmxKmlxArray;

/** 合计金额 */
@property (nonatomic, strong) UILabel *hjjeLabel;

@end



@implementation TripScrollView

//基本信息 View
- (TripCommonInfoView *)basicInfoView{
    
    if (!_basicInfoView) {
        _basicInfoView = [[TripCommonInfoView alloc]initWithFrame:CGRectMake(0, 0, trip_width, 230)];
        _basicInfoView.commonInfoDelegate = self;
    }
    
    return _basicInfoView;
   
}

//冲账
- (TripCzView *)czView{
    
    if (!_czView) {
        _czView = [[TripCzView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.basicInfoView.frame), trip_width, 110) sfcz:NO];
        _czView.delegate = self;
    }
    return _czView;
}

//付款方式
-  (TripPayView *)payView{
    if (!_payView) {
        _payView = [[TripPayView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.czView.frame), trip_width, 70) fkfsSytle:TripPayStyleWy];
        _payView.payDelegate = self;
    }
    return _payView;
}

//出差日期
- (TripDateView *)dateView{
    
    if (!_dateView) {
        _dateView = [[TripDateView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.payView.frame), trip_width, 190)];
        _dateView.dateDelegate = self;
    }
    return _dateView;
}

//出差事由和个人意见
- (TripReasonView *)reasonView{
    
    if (!_reasonView) {
        
        _reasonView = [[TripReasonView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateView.frame), trip_width, 430)];
        _reasonView.reasonDelegate = self;
    }
    return _reasonView;
}




- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[ super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self addSubViews];
    }
    
    return self;
}

- (void)addSubViews{
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.basicInfoView];
    [self addSubview:self.czView];
    [self addSubview:self.payView];
    [self addSubview:self.dateView];
    [self addSubview:self.reasonView];
    [self creatTableView];
    //设置 contentView 的 frame
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
}



#pragma mark - TripCommonInfoViewDelegate

- (void)commonInfoView:(TripCommonInfoView *)aView selcted:(TripCommonInfoViewSelectedType)type{
    
    if (type == TripCommonInfoViewSelectedTypeApplyPerson) {
        //选择申请人
        NSString *str = @"赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩赵倩";
        self.basicInfoView.applyPerson = str;
        [self firstUpdateFrameWithApplyPerson:str];
    }else if (type == TripCommonInfoViewSelectedTypeTbsj){
        //填表时间
        _dateTag = 2;
        [self.pickerDate show];
        
    }else if (type == TripCommonInfoViewSelectedTypeBxbm){
        //报销部门
        self.bxbmArray = @[@"人事部",@"总务处",@"董事长办公室",@"北京分公司"];
        self.bxbmSheet = [[UIActionSheet alloc]initWithTitle:@"请选择报销部门" delegate: self cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:nil, nil];
        
        for (int i = 0; i < self.bxbmArray.count; i ++) {
            [self.bxbmSheet addButtonWithTitle:[self.bxbmArray objectAtIndex:i]];
        }
        [self.bxbmSheet showInView:self.superview];
    }
}


#pragma mark - 第一次更改 frame

- (void)firstUpdateFrameWithApplyPerson:(NSString *)applyPerson{
    
    CGRect basicInfoFrame = self.basicInfoView.frame;
    
    CGRect changeFrame = [applyPerson boundingRectWithSize:CGSizeMake(trip_width - 120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    basicInfoFrame.size.height = basicInfoFrame.size.height + changeFrame.size.height - _selectedApplyPersonHeihgt;
    _selectedApplyPersonHeihgt = changeFrame.size.height;
    self.basicInfoView.frame = basicInfoFrame;
    
    CGRect czframe = self.czView.frame;
    czframe.origin.y = CGRectGetMaxY(self.basicInfoView.frame);
    self.czView.frame = czframe;
     
    
    //XTODO:: 第 1 次更改 frame
    
    /** 付款方式 View 的 frame */
    CGRect payViewFrame = self.payView.frame;
    payViewFrame.origin.y = CGRectGetMaxY(self.czView.frame);
    self.payView.frame = payViewFrame;
    
    /** 出差日期 View 的 frame */
    CGRect dateViewFrame = self.dateView.frame;
    dateViewFrame.origin.y = CGRectGetMaxY(self.payView.frame);
    self.dateView.frame = dateViewFrame;
    
    /** 意见 View 的 frame */
    CGRect  reasonViewFrame = self.reasonView.frame;
    reasonViewFrame.origin.y = CGRectGetMaxY(self.dateView.frame);
    self.reasonView.frame = reasonViewFrame;
    
    /** tableView 的 frame */
    CGRect  tableViewFrame = self.tablView.frame;
    tableViewFrame.origin.y = CGRectGetMaxY(self.reasonView.frame);
    self.tablView.frame = tableViewFrame;
    
    /** 合计金额 的 frame */
    CGRect hjjeFrame = self.hjjeLabel.frame;
    hjjeFrame.origin.y = CGRectGetMaxY(self.tablView.frame) + 10;
    self.hjjeLabel.frame = hjjeFrame;
    
    //scrollView 的 contentSize
    self.contentSize=CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
    
}



#pragma mark - TripCzDelegate 冲账 View 的 delegate

- (void)czView:(TripCzView *)aView sfcz:(BOOL)isSfcz{
    CGRect frame = self.czView.frame;
    if (isSfcz) {
        //冲账
        frame.size.height = 190;
        self.czView.frame = frame;
    }else{
        frame.size.height = 110;
        self.czView.frame = frame;
    }
    
    //XTODO:: 第 2 次更改 frame
    
    /** 付款方式 View 的 frame */
    CGRect payViewFrame = self.payView.frame;
    payViewFrame.origin.y = CGRectGetMaxY(self.czView.frame);
    self.payView.frame = payViewFrame;
    
    /** 出差日期 View 的 frame */
    CGRect dateViewFrame = self.dateView.frame;
    dateViewFrame.origin.y = CGRectGetMaxY(self.payView.frame);
    self.dateView.frame = dateViewFrame;
    
    /** 意见 View 的 frame */
    CGRect  reasonViewFrame = self.reasonView.frame;
    reasonViewFrame.origin.y = CGRectGetMaxY(self.dateView.frame);
    self.reasonView.frame = reasonViewFrame;
    
    /** tableView 的 frame */
    CGRect  tableViewFrame = self.tablView.frame;
    tableViewFrame.origin.y = CGRectGetMaxY(self.reasonView.frame);
    self.tablView.frame = tableViewFrame;
    
    /** 合计金额 的 frame */
    CGRect hjjeFrame = self.hjjeLabel.frame;
    hjjeFrame.origin.y = CGRectGetMaxY(self.tablView.frame) + 10;
    self.hjjeLabel.frame = hjjeFrame;
    
    

    //设置 contentView 的 frame
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
}

//XTODO:: 选择冲账科目
- (void)chooseCZKWWithCzView:(TripCzView *)aView{
    
    self.czkmArray = @[@"冲账科目 - 1",@"冲账科目 - 2",@"冲账科目 - 3",@"冲账科目 - 4",@"冲账科目 - 5"];
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:nil, nil];
    for (int i = 0; i < self.czkmArray.count; i ++) {
        [sheet addButtonWithTitle:[self.czkmArray objectAtIndex:i]];
    }
    self.czkmSheet = sheet;
    [self.czkmSheet showInView:self.superview];
}

#pragma mark - TripPayViewDelegate 付款方式 View 的 frame

//XTODO:: 选择付款方式
- (void)choosePayStyleWithTripView:(TripPayView *)aView{
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:nil message:@"请选择付款方式" preferredStyle:UIAlertControllerStyleActionSheet];
    //网银
    UIAlertAction *wyAction = [UIAlertAction actionWithTitle:@"网银" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        aView.fkfsStyle = TripPayStyleWy;
        [weakSelf thirdUpdateFrameWithSyle:TripPayStyleWy];
    }];
    
    //对外转账
    UIAlertAction *dwzzAction = [UIAlertAction actionWithTitle:@"对外转账" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        aView.fkfsStyle = TripPayStyleDwzz;
        [weakSelf thirdUpdateFrameWithSyle:TripPayStyleDwzz];
    }];
    UIAlertAction *canceleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertvc addAction:wyAction];
    [alertvc addAction:dwzzAction];
    [alertvc addAction:canceleAction];
    [self.parentViewController presentViewController:alertvc animated:YES completion:nil];
}

//XTODO:: 第3次更新 frame
- (void)thirdUpdateFrameWithSyle:(TripPayStyle)style{
    
    //更新付款情况（含付款情况）一下的视图的 frame
    
    CGRect payFrame = self.payView.frame;
    if (style == TripPayStyleWy) {
        //网银
        payFrame.size.height = 70;
    }else if (style == TripPayStyleDwzz){
        payFrame.size.height = 470;
    }
    self.payView.frame = payFrame;
    
    
    /** 出差日期 View 的 frame */
    CGRect dateViewFrame = self.dateView.frame;
    dateViewFrame.origin.y = CGRectGetMaxY(self.payView.frame);
    self.dateView.frame = dateViewFrame;
    
    /** 意见 View 的 frame */
    CGRect  reasonViewFrame = self.reasonView.frame;
    reasonViewFrame.origin.y = CGRectGetMaxY(self.dateView.frame);
    self.reasonView.frame = reasonViewFrame;
    
    /** tableView 的 frame */
    CGRect  tableViewFrame = self.tablView.frame;
    tableViewFrame.origin.y = CGRectGetMaxY(self.reasonView.frame);
    self.tablView.frame = tableViewFrame;
    
    /** 合计金额 的 frame */
    CGRect hjjeFrame = self.hjjeLabel.frame;
    hjjeFrame.origin.y = CGRectGetMaxY(self.tablView.frame) + 10;
    self.hjjeLabel.frame = hjjeFrame;
    
    //设置 contentView 的 frame
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
}


#pragma mark - TripDateViewDelegate 出差日期的代理

- (void)dateView:(TripDateView *)aView startOrEndTag:(NSInteger)tag{
    _dateTag = tag;
    [self.pickerDate show];
}


#pragma mark - 选择日期
- (STPickerDate *)pickerDate{
    
    if (!_pickerDate) {
        _pickerDate = [[STPickerDate alloc]init];
        _pickerDate.delegate = self;
    }
    return _pickerDate;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSString *time = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
    if (_dateTag == 0) {
        self.dateView.startTime = time;
        //NSLog(@"\n开始时间 == %@\n结束时间 == %@",self.dateView.startTime,self.dateView.endTime);
        self.dateView.gj = [self dayCountWithDataFrom:self.dateView.startTime toDate:self.dateView.endTime];
        
    }else if (_dateTag == 1){
        self.dateView.endTime = time;
        //NSLog(@"\n开始时间 == %@\n结束时间 == %@",self.dateView.startTime,self.dateView.endTime);
        self.dateView.gj = [self dayCountWithDataFrom:self.dateView.startTime toDate:self.dateView.endTime];
        
    }else if (_dateTag == 2){
        //选择填表时间
        self.basicInfoView.tbsj = time;
    }
}


#pragma mark - 计算两个时间段内的天数

- (NSString *)dayCountWithDataFrom:(NSString *)dataFromString toDate:(NSString*)toDateString{
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:dataFromString];
    
    NSDate *toDate = [dateFormatter dateFromString:toDateString];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return [NSString stringWithFormat:@"%ld",dayComponents.day+1];
}


#pragma mark - 选择常用意见

- (NSArray *)reasonArray{
    return @[@"请选择常用意见",@"请修改",@"同意",@"已修改"];
}

- (void)chooseCommonReasonWithTripReasonView:(TripReasonView *)aView{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:nil, nil];
    for (int i = 0; i < self.reasonArray.count; i ++) {
        [sheet addButtonWithTitle:[self.reasonArray objectAtIndex:i]];
    }
    self.reasonSheet = sheet;
    [self.reasonSheet showInView:self.superview];
}



#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex != 0) {
        if (actionSheet == self.reasonSheet) {//选择常用意见
            NSString *str = [self.reasonArray objectAtIndex:buttonIndex - 1];
            self.reasonView.cyyj = str;
            self.reasonView.gryj = [NSString stringWithFormat:@"%@",self.reasonView.cyyj]; //[NSString stringWithFormat:@"%@%@",self.reasonView.gryj,self.reasonView.cyyj]
            
        }else if (actionSheet == self.bxbmSheet){//选择报销部门
            NSString *bxbm = [self.bxbmArray objectAtIndex:buttonIndex - 1];
            self.basicInfoView.bxbm = bxbm;
            
        }else if (actionSheet == self.czkmSheet){//选择冲账科目
            NSString *czkm = [self.czkmArray objectAtIndex:buttonIndex - 1];
            self.czView.czkm = czkm;
            
        }else if (actionSheet == self.ccmxSheet){
            //选择出差明细的科目类型
            NSDictionary *selctedDic = [self.ccmxKmlxArray objectAtIndex:buttonIndex - 1];
            CCMXModel *model = [self.ccmxData objectAtIndex:_ccmxKmlxIndexPath.row];
            model.kmlx = [NSDictionary dictionaryWithDictionary:selctedDic];
            
            [self.ccmxData replaceObjectAtIndex:_ccmxKmlxIndexPath.row withObject:model];
            [self.tablView reloadData];
            
        }
    }
}


#pragma mark - 出差明细

- (void)creatTableView{
    self.tablView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.reasonView.frame), trip_width, 415 + 40) style:UITableViewStyleGrouped];
    self.tablView.delegate = self;
    self.tablView.dataSource = self;
    self.tablView.scrollEnabled = NO;
    self.tablView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tablView];
    [self.tablView registerNib:[UINib nibWithNibName:@"TripCCMXCell" bundle:nil] forCellReuseIdentifier:@"TripCCMXCell"];
    

    CCMXModel *model = [[CCMXModel alloc]init];
    model.showBtn = NO;
    self.ccmxData = [NSMutableArray arrayWithArray:@[model]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hjjeChanged) name:@"TripHjjeAddNotificationName" object:nil];
    
    //合计金额
    self.hjjeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.tablView.frame), trip_width, 30)];
    self.hjjeLabel.text = @"合计金额：0.00 元";
    self.hjjeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.hjjeLabel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 415;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ccmxData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripCCMXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCCMXCell"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
    [cell.contentView addGestureRecognizer:tap];
    
    cell.contentView.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CCMXModel *model = [self.ccmxData objectAtIndex:indexPath.row];
    model.indexPath = indexPath;
    cell.model = model;
    cell.delegate = self;
    return cell;
}

//设置表尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    static NSString *footSectionID = @"footSectionID";
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footSectionID];
    footerView.contentView.backgroundColor=[UIColor whiteColor];
    
    UIButton *add;
    
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footSectionID];
        add = [UIButton buttonWithType:UIButtonTypeCustom];
        add.frame = CGRectMake(10, 10, trip_width - 20, 30);
        add.layer.cornerRadius = 5;
        add.layer.masksToBounds = YES;
        [footerView addSubview:add];
        
        [add setTitle:@"+ 添加差旅明细" forState:UIControlStateNormal];
        [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [add setBackgroundColor:[UIColor colorWithRed:46/255.0 green:126/255.0 blue:251/255.0 alpha:1]];
        [add addTarget:self action:@selector(CreatNew) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return footerView;
}

-(void)CreatNew
{
    
    CCMXModel *addModel = [[CCMXModel alloc]init];
    addModel.showBtn = YES;
    [self.ccmxData addObject:addModel];
   
    [self.tablView reloadData];
    
    //MARK: 第四次更新 frame
    self.tablView.frame=CGRectMake(0, CGRectGetMaxY(self.reasonView.frame), trip_width, self.tablView.contentSize.height);

    CGRect hjjeFrame = self.hjjeLabel.frame;
    hjjeFrame.origin.y = CGRectGetMaxY(self.tablView.frame) + 10;
    self.hjjeLabel.frame = hjjeFrame;
    
    self.contentSize=CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
}
- (void)touch{
    [self.tablView endEditing:YES];
}

- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你确定要删除出差明细（%ld）吗？",indexPath.row + 1] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        if (indexPath.row < self.ccmxData.count) {
            CCMXModel *deleteModel =  [self.ccmxData objectAtIndex:indexPath.row];
            
            [self.ccmxData removeObject:deleteModel]; 
        }
     
        [self.tablView reloadData];
        [self hjjeChanged];
        
        //MARK: 第5次更新 frame
        self.tablView.frame=CGRectMake(0, CGRectGetMaxY(self.reasonView.frame), trip_width, self.tablView.contentSize.height);
        
        CGRect hjjeFrame = self.hjjeLabel.frame;
        hjjeFrame.origin.y = CGRectGetMaxY(self.tablView.frame) + 10;
        self.hjjeLabel.frame = hjjeFrame;
        
        self.contentSize=CGSizeMake(0, CGRectGetMaxY(self.tablView.frame) + 80);
        
    }];
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction:ok];
    [alert addAction:no];
    
    [self.parentViewController presentViewController:alert animated:YES completion:nil];
}

- (void)chooseKmlxWithCell:(TripCCMXCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    _ccmxKmlxIndexPath = indexPath;
    self.ccmxKmlxArray = @[@{@"name":@"科目类型1",@"id":@"1"},
  @{@"name":@"科目类型2",@"id":@"2"},
  @{@"name":@"科目类型3",@"id":@"3"},
  @{@"name":@"科目类型4",@"id":@"4"},
  @{@"name":@"科目类型5",@"id":@"5"},
  @{@"name":@"科目类型6",@"id":@"6"},
  @{@"name":@"科目类型7",@"id":@"7"}];
    
    self.ccmxSheet = [[UIActionSheet alloc]initWithTitle:@"请选择出差明细的科目类型" delegate: self cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:nil, nil];
    for (int i = 0;  i < self.ccmxKmlxArray.count; i++) {
        NSString *title = [[self.ccmxKmlxArray objectAtIndex:i] valueForKey:@"name"];
        [self.ccmxSheet addButtonWithTitle:title];
    }
    
    [self.ccmxSheet showInView:self.superview];
}


#pragma mark - 计算合计金额

- (void)hjjeChanged{
    
    CGFloat hjje = 0.00;
    
    for (CCMXModel *model in self.ccmxData) {
        hjje += model.je.floatValue;
    }
    
    NSString *hjjeStr = [NSString stringWithFormat:@"合计金额：%.2f 元",hjje];
    
    self.hjjeLabel.text = hjjeStr;
    NSLog(@"hjje === %@", hjjeStr);
}
@end
