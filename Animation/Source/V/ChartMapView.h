//
//  ChartMapView.h
//  Animation
//
//  Created by 李礼光 on 2017/8/23.
//  Copyright © 2017年 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartMapView : UIView


@property (nonatomic, strong) NSArray *dataSource;

- (instancetype)initWithFrame:(CGRect)frame WithLayerCount:(NSInteger)count;


@end
