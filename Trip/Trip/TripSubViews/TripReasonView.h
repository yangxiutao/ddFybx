//
//  TripReasonView.h
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//  意见 View

#import <UIKit/UIKit.h>

@protocol TripReasonViewDelegate;

@interface TripReasonView : UIView

@property (nonatomic, strong)  NSString *ccsy;//出差事由

@property (nonatomic, strong)  NSString *gryj;//个人意见

@property (nonatomic, strong)  NSString *cyyj;//常用意见

@property (nonatomic, weak) id<TripReasonViewDelegate>reasonDelegate;

@end

@protocol TripReasonViewDelegate <NSObject>

- (void)chooseCommonReasonWithTripReasonView:(TripReasonView *)aView;

@end