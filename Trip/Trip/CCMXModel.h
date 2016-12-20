//
//  CCMXModel.h
//  gdoaDemo
//
//  Created by YXT on 2016/12/17.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMXModel : NSObject

@property (nonatomic, strong) NSDictionary *kmlx;//科目类型

@property (nonatomic, strong) NSString *fphm;//发票号码

@property (nonatomic, strong) NSString *je;//金额

@property (nonatomic, strong) NSString *qsdd;//起始地点

@property (nonatomic, strong) NSString *djzs;//单据张数

@property (nonatomic, strong) NSString *fpdm;//发票代码

@property (nonatomic, strong) NSString *day;//日

@property (nonatomic, strong) NSString *ts;//天数

@property (nonatomic, strong) NSString *bz;//补助

@property (nonatomic, strong) NSString *month;//月

@property (nonatomic, strong) NSString *mdd;//目的地



@property (nonatomic, strong) NSIndexPath *indexPath;//表示

@property (nonatomic, assign) BOOL showBtn;//是否显示 deletebtn


@end
