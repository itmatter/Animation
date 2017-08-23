//
//  LoadingView.h
//  Animation
//
//  Created by 李礼光 on 2017/8/22.
//  Copyright © 2017年 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChartType) {
    kColumnarChart = 0,
    kLineChart,
    kCircleChart
};


@protocol ChartViewDataSourceDelegate <NSObject>
@required
- (NSArray *)chartViewDataSource;
@end

@interface ChartView : UIView


@property (nonatomic, weak) id<ChartViewDataSourceDelegate>dataSource;
@property (nonatomic, assign) ChartType type;

- (instancetype)initWithFrame:(CGRect)frame
                    ChartType:(ChartType)type
                   DataSource:(id<ChartViewDataSourceDelegate>)dataSource;

@end
