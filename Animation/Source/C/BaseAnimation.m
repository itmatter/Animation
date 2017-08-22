//
//  BaseAnimation.m
//  Animation
//
//  Created by 李礼光 on 2017/8/21.
//  Copyright © 2017年 LG. All rights reserved.
//

#import "BaseAnimation.h"

@interface BaseAnimation ()<CAAnimationDelegate>
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (nonatomic, strong) CAShapeLayer *layer1;
@property (nonatomic, strong) CAShapeLayer *layer2;
@property (nonatomic, strong) CABasicAnimation *anim;
@end

@implementation BaseAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Line Animation";
    self.info.text = @"";
    [self addLine1];
    [self addLine2];
    
    
}

#pragma mark - UI
- (void)addLine1 {
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(100, 200)];
    [line addLineToPoint:CGPointMake(100, 400)];
    
    _layer1 = [CAShapeLayer layer];
    _layer1.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    _layer1.path = line.CGPath;
    _layer1.lineWidth = 15;
    _layer1.fillColor = [UIColor clearColor].CGColor;
    _layer1.strokeColor = [UIColor blueColor].CGColor;
    _layer1.lineCap = kCALineCapRound;
    _layer1.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_layer1];
}

- (void)addLine2 {
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(300, 200)];
    [line addLineToPoint:CGPointMake(300, 400)];
    
    _layer2 = [CAShapeLayer layer];
    _layer2.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    _layer2.path = line.CGPath;
    _layer2.lineWidth = 15;
    _layer2.fillColor = [UIColor clearColor].CGColor;
    _layer2.strokeColor = [UIColor redColor].CGColor;
    _layer2.lineCap = kCALineCapRound;
    _layer2.lineJoin = kCALineJoinRound;
    [self.view.layer addSublayer:_layer2];
}

#pragma mark - 添加动画
- (CABasicAnimation *)addAnimation:(CAShapeLayer *)layer
                           keyPath:(NSString *)keyPath
                              From:(id)fromValue
                                To:(id)toValue
                          Duration:(NSTimeInterval)duration
                          FillMode:(NSString *)fillMode
                          Delegate:(id)delegate {
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = keyPath;
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    animation.fillMode = fillMode;
    animation.delegate = delegate;
    animation.removedOnCompletion = YES;
    [layer addAnimation:animation forKey:nil];
    return animation;
}

//颜色从有到无
- (void)lineStrokeStart {
    self.info.text = @"颜色从有到无";
    [self addAnimation:_layer1 keyPath:@"strokeStart" From:@0 To:@1 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
    [self addAnimation:_layer2 keyPath:@"strokeStart" From:@1 To:@0 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}

//颜色从无到有
- (void)lineStrokeEnd {
    self.info.text = @"颜色从无到有";
    [self addAnimation:_layer1 keyPath:@"strokeEnd" From:@0 To:@1 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
    [self addAnimation:_layer2 keyPath:@"strokeEnd" From:@1 To:@0 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}

//透明度
- (void)lineOpacity {
    [self addAnimation:_layer1 keyPath:@"opacity" From:@0 To:@1 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
    [self addAnimation:_layer2 keyPath:@"opacity" From:@1 To:@0 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}

//位置
- (void)positionX {
    [self addAnimation:_layer1 keyPath:@"position.x"
                  From:[NSValue valueWithCGPoint:CGPointMake(100, 0)]
                    To:[NSValue valueWithCGPoint:CGPointMake(400, 0)]
              Duration:1
              FillMode:kCAFillModeForwards
              Delegate:self];
    
    [self addAnimation:_layer2 keyPath:@"position.x"
                  From:[NSValue valueWithCGPoint:CGPointMake(100, 0)]
                    To:[NSValue valueWithCGPoint:CGPointMake(400, 0)]
              Duration:1
              FillMode:kCAFillModeForwards
              Delegate:self];
    
}
- (void)positionY {
    [self addAnimation:_layer1 keyPath:@"position.y"
                  From:[NSValue valueWithCGPoint:CGPointMake(350, 0)]
                    To:[NSValue valueWithCGPoint:CGPointMake(350, 0)]
              Duration:1
              FillMode:kCAFillModeForwards
              Delegate:self];
    
    [self addAnimation:_layer2 keyPath:@"position.y"
                  From:[NSValue valueWithCGPoint:CGPointMake(350, 0)]
                    To:[NSValue valueWithCGPoint:CGPointMake(350, 0)]
              Duration:1
              FillMode:kCAFillModeForwards
              Delegate:self];
}


- (void)scaleX {
    [self addAnimation:_layer1 keyPath:@"transform.scale.x" From:@1 To:@0.5 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}
- (void)scaleY {
    [self addAnimation:_layer1 keyPath:@"transform.scale.y" From:@1 To:@0.5 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}
- (void)scaleZ {
    [self addAnimation:_layer1 keyPath:@"transform.scale.z" From:@1 To:@0.5 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}

- (void)rotationX {
    [self addAnimation:_layer1 keyPath:@"transform.rotation.x" From:@0 To:@M_PI_2 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}
- (void)rotationY {
    [self addAnimation:_layer1 keyPath:@"transform.rotation.y" From:@0 To:@M_PI_2 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}

- (void)rotationZ {
    [self addAnimation:_layer1 keyPath:@"transform.rotation.z" From:@0 To:@M_PI_2 Duration:1 FillMode:kCAFillModeForwards Delegate:self];
}




#pragma mark - 按钮方法

- (IBAction)rotationX:(id)sender {
    [self rotationX];
}
- (IBAction)rotationY:(id)sender {
    [self rotationY];
}
- (IBAction)rotationZ:(id)sender {
    [self rotationZ];
}
- (IBAction)scaleX:(id)sender {
    [self scaleX];
}
- (IBAction)scaleY:(id)sender {
    [self scaleY];
}
- (IBAction)scaleZ:(id)sender {
    [self scaleZ];
}
- (IBAction)positionX:(id)sender {
    [self positionX];
}
- (IBAction)positionY:(id)sender {
    [self positionY];
}
- (IBAction)opacity:(id)sender {
    [self lineOpacity];
}
- (IBAction)strokeStart:(id)sender {
    [self lineStrokeStart];
}
- (IBAction)strokeEnd:(id)sender {
    [self lineStrokeEnd];
}

#pragma mark - delegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画结束");
    
}







@end



/***
 
 附录 :
 transform.rotation：旋转动画。
 transform.rotation.x：按x轴旋转动画。
 transform.rotation.y：按y轴旋转动画。
 transform.rotation.z：按z轴旋转动画。
 transform.scale：按比例放大缩小动画。
 transform.scale.x：在x轴按比例放大缩小动画。
 transform.scale.y：在y轴按比例放大缩小动画。
 transform.scale.z：在z轴按比例放大缩小动画。
 position：移动位置动画。
 opacity：透明度动画
 strokeEnd :颜色从有到无
 strokeStart :颜色从无到有
 */










