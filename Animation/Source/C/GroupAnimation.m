//
//  GroupAnimation.m
//  Animation
//
//  Created by 李礼光 on 2017/8/21.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "GroupAnimation.h"

@interface GroupAnimation ()
@property (nonatomic, strong) UIBezierPath *rectPath;
@property (nonatomic, strong) CAShapeLayer *layer;
@end

@implementation GroupAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRect];
    
    
    
}

- (void)addRect{
    _rectPath = [UIBezierPath bezierPathWithRect:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 100,
                                                            [UIScreen mainScreen].bounds.size.height * 0.5 - 100 - 32,
                                                            200,
                                                            200)];
    _layer = [CAShapeLayer layer];
    _layer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    _layer.path = _rectPath.CGPath;
    _layer.fillColor = [UIColor redColor].CGColor;
    _layer.lineCap = kCALineCapRound;
    _layer.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_layer];
}


- (IBAction)groupAnimation:(id)sender {
    
    CABasicAnimation *aniA = [CABasicAnimation animation];
    aniA.keyPath = @"transform.rotation.z";
    aniA.fromValue = @0;
    aniA.toValue = @M_PI_4;


    CAKeyframeAnimation *aniB = [CAKeyframeAnimation animation];
    aniB.keyPath = @"transform.scale";
    aniB.values = @[@1.0,@0.5,@1.0,@1.5,@1.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[aniA,aniB];
    group.removedOnCompletion = NO;
    group.duration = 2;
    group.fillMode = kCAFillModeForwards;
    [_layer addAnimation:group forKey:nil];

}


@end
