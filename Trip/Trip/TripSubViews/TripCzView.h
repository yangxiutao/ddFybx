//
//  TripCzView.h
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//  冲账 View

#import <UIKit/UIKit.h>

@protocol TripCzViewDelegate;

@interface TripCzView : UIView

@property (nonatomic, weak) id<TripCzViewDelegate>delegate;

@property (nonatomic, strong)  NSString *sfcz;// 是否冲账

@property (nonatomic, strong)  NSString *czkm;// 冲账科目

@property (nonatomic, strong)  NSString *yjk;// 原借款

@property (nonatomic, strong)  NSString *ytbce;// 应退补差额

- (instancetype)initWithFrame:(CGRect)frame sfcz:(BOOL)sfcz;

@end

@protocol TripCzViewDelegate <NSObject>

/** 是否冲账 */
- (void)czView:(TripCzView *)aView sfcz:(BOOL)isSfcz;

/** 选择冲账科目 */
- (void)chooseCZKWWithCzView:(TripCzView *)aView;
@end