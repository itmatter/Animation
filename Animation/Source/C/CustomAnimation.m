//
//  CustomAnimation.m
//  Animation
//
//  Created by 李礼光 on 2017/8/22.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "CustomAnimation.h"
#import "ChartView.h"
@interface CustomAnimation ()<ChartViewDataSourceDelegate>
@property (strong, nonatomic) IBOutlet UIView *aniView;

@property (nonatomic, strong) ChartView *chartV;

@end

@implementation CustomAnimation

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)columnarChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:self.aniView.bounds ChartType:kColumnarChart DataSource:self];
    [self.aniView addSubview:_chartV];
}

- (IBAction)lineChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:self.aniView.bounds ChartType:kLineChart DataSource:self];
    [self.aniView addSubview:_chartV];
}

- (IBAction)circularChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:self.aniView.bounds ChartType:kCircleChart DataSource:self];
    [self.aniView addSubview:_chartV];
    
}


#pragma mark - chartViewDataSource;
- (NSArray *)chartViewDataSource {
    return @[@31,@22,@13,@4,@43,@6,@1,@3,@13];
}

@end
