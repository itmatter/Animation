//
//  AdvancedAnimation.m
//  Animation
//
//  Created by 李礼光 on 2017/8/21.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "AdvancedAnimation.h"

#define LAYER_WIDTH 66
#define LAYER_HEIGHT 100
#define LAYER_FRAME CGRectMake((self.view.bounds.size.width-LAYER_WIDTH)* 0.5,(self.view.bounds.size.height-LAYER_HEIGHT)*0.5,LAYER_WIDTH,LAYER_HEIGHT)
#define LINE_COLOR [UIColor redColor].CGColor
#define LINE_WIDTH 10

typedef NS_ENUM(NSInteger, buttonState) {
    kPlay = 0,
    kPause
};


@interface AdvancedAnimation ()<CAAnimationDelegate>

@property (nonatomic, strong) UIBezierPath *leftLine;
@property (nonatomic, strong) UIBezierPath *rightLine;
@property (nonatomic, strong) UIBezierPath *triangle;
@property (nonatomic, strong) UIBezierPath *circle;


@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, assign) BOOL isPlay;
@end

@implementation AdvancedAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    _leftLayer.backgroundColor = [UIColor blueColor].CGColor;
}

#pragma mark - UI
- (void)setupUI {
    [self addLeftLine];
    [self addRightLine];
    [self addTriangle];
    [self addCircle];
}

- (void)addLeftLine{

    _leftLine = [UIBezierPath bezierPath];
    [_leftLine moveToPoint:CGPointMake(LAYER_WIDTH * 0.23, LAYER_HEIGHT * 0.2)];
    [_leftLine addLineToPoint:CGPointMake(LAYER_WIDTH * 0.23, LAYER_HEIGHT * 0.8)];
    
    _leftLayer = [CAShapeLayer layer];
    _leftLayer.frame = LAYER_FRAME;
    _leftLayer.path = _leftLine.CGPath;
    _leftLayer.strokeColor = LINE_COLOR;
    _leftLayer.lineWidth = LINE_WIDTH;
    _leftLayer.lineCap = kCALineCapRound;
    _leftLayer.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_leftLayer];
}

- (void)addRightLine{

    _rightLine = [UIBezierPath bezierPath];
    [_rightLine moveToPoint:CGPointMake(LAYER_WIDTH * 0.77, LAYER_HEIGHT * 0.8)];
    [_rightLine addLineToPoint:CGPointMake(LAYER_WIDTH * 0.77, LAYER_HEIGHT * 0.2)];
    
    _rightLayer = [CAShapeLayer layer];
    _rightLayer.path = _rightLine.CGPath;
    _rightLayer.frame = LAYER_FRAME;
    _rightLayer.strokeColor = LINE_COLOR;
    _rightLayer.lineWidth = LINE_WIDTH;
    _rightLayer.lineCap = kCALineCapRound;
    _rightLayer.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_rightLayer];
}

- (void)addTriangle {
    //画三角
    _triangle = [UIBezierPath bezierPath];
    [_triangle moveToPoint:CGPointMake(LAYER_WIDTH * 0.23, LAYER_HEIGHT * 0.2)];
    [_triangle addLineToPoint:CGPointMake(LAYER_WIDTH * 0.77, LAYER_HEIGHT * 0.5)];
    [_triangle addLineToPoint:CGPointMake(LAYER_WIDTH * 0.23, LAYER_HEIGHT * 0.8)];
    [_triangle addLineToPoint:CGPointMake(LAYER_WIDTH * 0.23, LAYER_HEIGHT * 0.2)];
    
    _triangleLayer = [CAShapeLayer layer];
    _triangleLayer.path = _triangle.CGPath;
    _triangleLayer.frame = LAYER_FRAME;
    _triangleLayer.strokeColor = LINE_COLOR;
    _triangleLayer.fillColor = [UIColor clearColor].CGColor;
    _triangleLayer.lineWidth = LINE_WIDTH;
    _triangleLayer.lineCap = kCALineCapRound;
    _triangleLayer.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_triangleLayer];
}

- (void)addCircle {
    //画三角
    _circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(LAYER_WIDTH * 0.5, LAYER_HEIGHT * 0.8)
                                             radius:LAYER_WIDTH * 0.27
                                         startAngle:0
                                           endAngle:M_PI
                                          clockwise:YES];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = _circle.CGPath;
    _circleLayer.frame = LAYER_FRAME;
    _circleLayer.strokeColor = LINE_COLOR;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = LINE_WIDTH;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_circleLayer];
}




#pragma mark - 动画

- (void)play {
    NSLog(@"Play");
    _isAnimating = YES;
    _isPlay = YES;
    
    [self lineAnimation:@"strokeEnd" fromValue:@1 toValue:@0 duration:0.5 layer:_leftLayer delayTime:0];
    [self lineAnimation:@"strokeEnd" fromValue:@1 toValue:@0 duration:0.5 layer:_rightLayer delayTime:0];
    
    [self triangleAnimation:@"strokeEnd" fromValue:@0 toValue:@1 duration:1 layer:_triangleLayer delayTime:0.5];
    [self circleAnimationfromValue:@0 toValue:@1 duration:0.3 layer:_circleLayer type:kPlay delayTime:0.5];

}

- (void)pause {
    NSLog(@"pause");
    _isPlay = NO;
    _isAnimating = YES;
    
    [self circleAnimationfromValue:@1 toValue:@0 duration:1 layer:_circleLayer type:kPause delayTime:0];

    [self triangleAnimation:@"strokeEnd" fromValue:@1 toValue:@0 duration:0.5 layer:_triangleLayer delayTime:0];
    
    [self lineAnimation:@"strokeEnd" fromValue:@0 toValue:@1 duration:0.5 layer:_leftLayer delayTime:0.5];
    [self lineAnimation:@"strokeEnd" fromValue:@0 toValue:@1 duration:0.5 layer:_rightLayer delayTime:0.5];


}

//直线动画
- (void)lineAnimation:(NSString *)keyPath
            fromValue:(id)fromValue
              toValue:(id)toValue
             duration:(NSTimeInterval)duration
                layer:(CAShapeLayer *)layer
            delayTime:(NSTimeInterval)delayTime{
    
    
        //抖动
//        CABasicAnimation *linePositionAni = [CABasicAnimation animation];
//        linePositionAni.keyPath = @"position.y";
//        linePositionAni.fromValue = @(_leftLayer.position.y);
//        linePositionAni.toValue = @(_leftLayer.position.y + 0.1 * _leftLayer.bounds.size.width);
//        linePositionAni.fillMode = kCAFillModeForwards;
//        linePositionAni.duration = 0.1;
//        linePositionAni.autoreverses = YES;
//        [layer addAnimation:linePositionAni forKey:nil];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 + delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _leftLayer.lineCap = kCALineCapRound;
            _rightLayer.lineCap = kCALineCapRound;
            CABasicAnimation *lineAni = [CABasicAnimation animation];
            lineAni.keyPath = keyPath;
            lineAni.fromValue = fromValue;
            lineAni.toValue = toValue;
            lineAni.fillMode = kCAFillModeForwards;
            lineAni.duration = duration;
            lineAni.removedOnCompletion = NO;
            lineAni.delegate = self;
            [layer addAnimation:lineAni forKey:nil];
        });

    
}

//三角形动画
- (void)triangleAnimation:(NSString *)keyPath
                fromValue:(id)fromValue
                  toValue:(id)toValue
                 duration:(NSTimeInterval)duration
                    layer:(CAShapeLayer *)layer
                delayTime:(NSTimeInterval)delayTime{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *triangleAni = [CABasicAnimation animation];
        triangleAni.keyPath = keyPath;
        triangleAni.fromValue = fromValue;
        triangleAni.toValue = toValue;
        triangleAni.fillMode = kCAFillModeForwards;
        triangleAni.duration = duration;
        triangleAni.removedOnCompletion = NO;
        triangleAni.delegate = self;
        [layer addAnimation:triangleAni forKey:nil];
    });
    
   
    
}

//圆底动画
- (void)circleAnimationfromValue:(id)fromValue
                         toValue:(id)toValue
                        duration:(NSTimeInterval)duration
                           layer:(CAShapeLayer *)layer
                            type:(buttonState)state
                       delayTime:(NSTimeInterval)delayTime{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *keyPath1,*keyPath2;
        switch (state) {
            case kPlay:keyPath1 = @"strokeEnd";keyPath2 = @"strokeStart";;break;
            case kPause:keyPath1 = @"strokeStart";keyPath2 = @"strokeEnd";;break;
            default:break;
        }
        
        //圆底
        CABasicAnimation *circleStrokeStartAni = [CABasicAnimation animation];
        circleStrokeStartAni.keyPath = keyPath1;
        circleStrokeStartAni.duration = duration * 0.5;
        circleStrokeStartAni.fromValue = fromValue;
        circleStrokeStartAni.toValue = toValue;
        circleStrokeStartAni.fillMode = kCAFillModeForwards;
        circleStrokeStartAni.removedOnCompletion = NO;
        [layer addAnimation:circleStrokeStartAni forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *circleStrokeStartAni = [CABasicAnimation animation];
            circleStrokeStartAni.keyPath = keyPath2;
            circleStrokeStartAni.duration = duration;
            circleStrokeStartAni.fromValue = fromValue;
            circleStrokeStartAni.toValue = toValue;
            circleStrokeStartAni.fillMode = kCAFillModeForwards;
            circleStrokeStartAni.removedOnCompletion = NO;
            circleStrokeStartAni.delegate = self;
            [layer addAnimation:circleStrokeStartAni forKey:nil];
        });
    });
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isAnimating == NO) {
        if (_isPlay == NO) {
            [self play];
        }else {
            [self pause];
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _isAnimating = NO;
    if (_isPlay == YES) {
        _leftLayer.lineCap = kCALineCapButt;
        _rightLayer.lineCap = kCALineCapButt;
    }
   
}

@end
