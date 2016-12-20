//
//  ViewController.m
//  Trip
//
//  Created by YXT on 2016/12/19.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "ViewController.h"
#import "TripScrollView.h"

@interface ViewController ()

@property (nonatomic, strong) TripScrollView *tripView;

@end


@implementation ViewController

- (TripScrollView *)tripView{
    
    if (!_tripView) {
        _tripView = [[TripScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _tripView;
}

- (void)loadView{
    [super loadView];
    self.view = self.tripView;
    self.tripView.parentViewController = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
