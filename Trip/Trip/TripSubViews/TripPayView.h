//
//  TripPayView.h
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TripPayViewDelegate;

typedef NS_ENUM(NSInteger, TripPayStyle) {
    TripPayStyleWy,     //网银
    TripPayStyleDwzz    //对外转账
};

@interface TripPayView : UIView

@property (nonatomic, weak) id<TripPayViewDelegate>payDelegate;

@property(nonatomic, assign) TripPayStyle fkfsStyle;

- (instancetype)initWithFrame:(CGRect)frame fkfsSytle:(TripPayStyle)fkfs;

@end

@protocol TripPayViewDelegate <NSObject>

- (void)choosePayStyleWithTripView:(TripPayView *)aView;//选择付款方式

@end
