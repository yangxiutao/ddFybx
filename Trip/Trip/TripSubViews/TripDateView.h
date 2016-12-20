//
//  TirpDateView.h
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//  出差日期

#import <UIKit/UIKit.h>

@protocol TripDateViewDelegate;

@interface TripDateView : UIView

@property (nonatomic, weak) id<TripDateViewDelegate>dateDelegate;

@property (nonatomic, strong)  NSString *startTime;//开始时间

@property (nonatomic, strong)  NSString *endTime;//结束时间

@property (nonatomic, strong)  NSString *gj;//共计（天）

@property (nonatomic, strong)  NSString *djzs;//单据张数

@end

@protocol TripDateViewDelegate <NSObject>

/** 
 *  选择开始时间 or 结束时间
 *
 *  @pram aView TripDateView
 *
 *  @pram tag: 0-开始时间，1-结束时间
 */
- (void)dateView:(TripDateView *)aView startOrEndTag:(NSInteger)tag;

@end
