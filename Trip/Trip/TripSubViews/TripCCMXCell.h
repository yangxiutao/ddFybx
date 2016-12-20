//
//  TripCCMXCell.h
//  gdoaDemo
//
//  Created by YXT on 2016/12/16.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMXModel.h"

@protocol TripCCMXCellDelegate;

@interface TripCCMXCell : UITableViewCell

@property (nonatomic, strong) CCMXModel *model;

@property (nonatomic, weak) id<TripCCMXCellDelegate>delegate;

@end

@protocol TripCCMXCellDelegate <NSObject>

//删除数据
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;

//选择科目类型
- (void)chooseKmlxWithCell:(TripCCMXCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
