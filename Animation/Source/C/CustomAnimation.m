//
//  CustomAnimation.m
//  Animation
//
//  Created by 李礼光 on 2017/8/22.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "CustomAnimation.h"
#import "ChartView.h"
#import "ChartMapView.h"

#define ANIVIEW_FRAME CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,self.aniView.bounds.size.height)

@interface CustomAnimation ()<ChartViewDataSourceDelegate>
@property (strong, nonatomic) IBOutlet UIView *aniView;

@property (nonatomic, strong) ChartView *chartV;
@property (nonatomic, strong) ChartMapView *mapV;

@end

@implementation CustomAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapV = [[ChartMapView alloc]initWithFrame:ANIVIEW_FRAME WithLayerCount:10];

    
    [self.aniView addSubview:_mapV];

}

- (IBAction)columnarChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:ANIVIEW_FRAME ChartType:kColumnarChart DataSource:self];
    [self.aniView addSubview:_chartV];
}

- (IBAction)lineChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:ANIVIEW_FRAME ChartType:kLineChart DataSource:self];
    [self.aniView addSubview:_chartV];
}

- (IBAction)circularChart:(id)sender {
    if (_chartV) {
        [_chartV removeFromSuperview];
    }
    _chartV = [[ChartView alloc]initWithFrame:ANIVIEW_FRAME ChartType:kCircleChart DataSource:self];
    [self.aniView addSubview:_chartV];
    
}


#pragma mark - chartViewDataSource;
- (NSArray *)chartViewDataSource {
    return @[@31,@22,@13,@4,@43,@6,@1,@3,@13];
}

@end
