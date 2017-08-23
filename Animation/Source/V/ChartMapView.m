//
//  ChartMapView.m
//  Animation
//
//  Created by 李礼光 on 2017/8/23.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "ChartMapView.h"

#define BOUNDS_WIDTH self.bounds.size.width
#define BOUNDS_HEIGHT self.bounds.size.height

#define CENTER_X (BOUNDS_WIDTH * 0.5)
#define CENTER_Y (BOUNDS_HEIGHT * 0.5)

#define THIRTYDGREE atan(0.5)

@implementation ChartMapView {
    CGFloat _dgree;
}


- (instancetype)initWithFrame:(CGRect)frame WithLayerCount:(NSInteger)count {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self radarMap:count];
        
        self.dataSource = @[@44,@11,@44,@11,@44,@11];
        [self dataMap:[self mapAlgorithm:self.dataSource]];
        
    }
    return self;
}



- (void)buildUI {
    self.alpha = 0.5;
}

- (void)radarMap:(NSInteger)count {
    
    CGFloat margin = 1.0/(count + 1) * BOUNDS_HEIGHT * 0.4;
    
    
    for (int i = 1; i < (count+1); i++) {
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:   CGPointMake(CENTER_X               ,CENTER_Y - i * margin      )];
        
        [path addLineToPoint:CGPointMake(CENTER_X + i * margin  ,CENTER_Y - i * margin * 0.5)];
        [path addLineToPoint:CGPointMake(CENTER_X + i * margin  ,CENTER_Y + i * margin * 0.5)];
        
        [path addLineToPoint:CGPointMake(CENTER_X               ,CENTER_Y + i * margin      )];
        
        [path addLineToPoint:CGPointMake(CENTER_X - i * margin  ,CENTER_Y + i * margin * 0.5)];
        [path addLineToPoint:CGPointMake(CENTER_X - i * margin  ,CENTER_Y - i * margin * 0.5)];
        [path closePath];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor colorWithRed:0 green:0 blue:112/255.0 alpha:0.3].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = 2;
        layer.path = path.CGPath;
    
        [self.layer addSublayer:layer];
    }
    
}

- (void)dataMap:(NSArray *)arr {

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:   CGPointMake(CENTER_X,
                                     CENTER_Y - ((NSNumber *)arr[0]).floatValue)];

    [path addLineToPoint:CGPointMake(CENTER_X + cos(THIRTYDGREE) * ((NSNumber *)arr[1]).floatValue,
                                     CENTER_Y - sin(THIRTYDGREE) * ((NSNumber *)arr[1]).floatValue)];

    [path addLineToPoint:CGPointMake(CENTER_X + cos(THIRTYDGREE) * ((NSNumber *)arr[2]).floatValue,
                                     CENTER_Y + sin(THIRTYDGREE) * ((NSNumber *)arr[2]).floatValue)];


    [path addLineToPoint:CGPointMake(CENTER_X,
                                     CENTER_Y + ((NSNumber *)arr[3]).floatValue)];

    [path addLineToPoint:CGPointMake(CENTER_X - cos(THIRTYDGREE) * ((NSNumber *)arr[4]).floatValue,
                                     CENTER_Y + sin(THIRTYDGREE) * ((NSNumber *)arr[4]).floatValue)];

    [path addLineToPoint:CGPointMake(CENTER_X - cos(THIRTYDGREE) * ((NSNumber *)arr[5]).floatValue,
                                     CENTER_Y - sin(THIRTYDGREE) * ((NSNumber *)arr[5]).floatValue)];
    [path closePath];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 2;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
}

- (NSArray *)mapAlgorithm:(NSArray *)arr  {
    //第一步 : 遍历数组求出最大值
    
    CGFloat max = 0;
    for (NSNumber *num in arr) {
        max = max > num.floatValue ? max : num.floatValue;
    }
    
    if (max < CENTER_Y) {
        NSMutableArray *newArr = [NSMutableArray array];
        for (NSNumber *num in arr) {
            [newArr addObject:@(num.floatValue * CENTER_Y/100 )];
        }
        return newArr;
    }
    
    //第二步 : 求出最大值比边缘值大多少?
    int flag = 0;
    while (max / 2 > 100) {
        max = max / 2;
        flag++;
    }
    //第三部 : 缩放原来的值
    NSMutableArray *newArr = [NSMutableArray array];
    for (NSNumber *num in arr) {
        [newArr addObject:@(num.floatValue / (flag * 2))];
    }
    return newArr;
}


@end
