//
//  LoadingView.m
//  Animation
//
//  Created by 李礼光 on 2017/8/22.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "ChartView.h"

@interface ChartView()<CAAnimationDelegate>
@property (nonatomic, strong) NSArray *dataArr;
@end
@implementation ChartView {
    UIBezierPath *_path;
    CAShapeLayer *_layer;
}

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [self chartViewDataSource];
    }
    return _dataArr;
}


- (instancetype)initWithFrame:(CGRect)frame
                    ChartType:(ChartType)type
                   DataSource:(id<ChartViewDataSourceDelegate>)dataSource {

    NSAssert(dataSource != nil, @"请设置数据源代理");
    _dataSource = dataSource;
    if (self = [super initWithFrame:frame]) {
        switch (type) {
            case kLineChart:[self buildLineChart];break;
            case kCircleChart:[self buildCircleChart];break;
            case kColumnarChart:[self buildColumnarChart];break;
            default:
                break;
        }
    }
    return self;
}




//柱状图
- (void)buildColumnarChart {
    for (int i = 0; i<self.dataArr.count; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint: CGPointMake(i * 40 + 20, self.bounds.size.height - 5)];
        NSNumber *y = (NSNumber *)self.dataArr[i];
        [path addLineToPoint:CGPointMake(i * 40 + 20 , self.bounds.size.height - y.floatValue)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = 5;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:layer];
        [self strokeEndAni:layer];

    }
}

//折线图
- (void)buildLineChart {
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSNumber *firstY = (NSNumber *)self.dataArr[0];
    [path moveToPoint: CGPointMake(20, self.bounds.size.height - firstY.floatValue )];
    for (int i = 1; i<self.dataArr.count; i++) {
        NSNumber *y = (NSNumber *)self.dataArr[i];
        [path addLineToPoint:CGPointMake(i * 40 + 20 , self.bounds.size.height - y.floatValue)];
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 5;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:layer];
    [self strokeEndAni:layer];
}

- (void)buildCircleChart{
    CGFloat radius = self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height * 0.15 : self.bounds.size.width * 0.15 ;
    CGFloat totalValue = 0;
    for (int i =0 ; i<self.dataArr.count; i++) {
        NSNumber *value = (NSNumber *)self.dataArr[i];
        totalValue += value.floatValue;
    }
    CGFloat lastAngle =0;

    for (int i = 0; i<self.dataArr.count; i++) {
        NSNumber *per = (NSNumber *)self.dataArr[i];
        CGFloat startAngle = lastAngle ;
        CGFloat endAngle = lastAngle + 2 * M_PI * (per.floatValue / totalValue);
        lastAngle = endAngle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y)
                                                            radius:radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                          green:arc4random_uniform(255)/255.0
                                           blue:arc4random_uniform(255)/255.0
                                          alpha:1].CGColor;
        layer.lineWidth = radius * 2;   //这里为什么是半径的2倍?因为描绘的直线是从线的正中心点经过的.
        [self.layer addSublayer:layer];
        [self strokeEndAni:layer];
    }
    
}

- (CABasicAnimation *)strokeEndAni:(CAShapeLayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:nil];
    return animation;
}


- (NSArray *)chartViewDataSource {
    if (self.dataSource == nil) {
        NSLog(@"数据源为空");
    }
    if ([self.dataSource respondsToSelector:@selector(chartViewDataSource)]) {
        return [NSArray arrayWithArray:[self.dataSource chartViewDataSource]];
    }
    return nil;
}



@end
