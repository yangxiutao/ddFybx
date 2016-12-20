//
//  TripCommanInfoView.h
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TripCommonInfoViewSelectedType) {
    
    TripCommonInfoViewSelectedTypeApplyPerson, //选择申请人
    TripCommonInfoViewSelectedTypeTbsj,//填表时间
    TripCommonInfoViewSelectedTypeBxbm //报销部门
};

@protocol TripCommonInfoViewDelegate;

@interface TripCommonInfoView : UIView

@property (nonatomic, weak) id<TripCommonInfoViewDelegate>commonInfoDelegate;

@property (nonatomic, strong)  NSString *applyPerson;//申请人

@property (nonatomic, strong) NSString *tbsj;//填表时间

@property (nonatomic, strong) NSString *bxbm;//报销部门


@end


@protocol TripCommonInfoViewDelegate <NSObject>

/** 选择申请人 */
- (void)commonInfoView:(TripCommonInfoView *)aView selcted:(TripCommonInfoViewSelectedType)type;

@end