//
//  RJBWaterView.m
//  RJBWaterWaveView
//
//  Created by ru on 2018/6/4.
//  Copyright © 2018年 ru. All rights reserved.
//

#import "RJBWaterView.h"

@interface RJBWaterView ()

@property (nonatomic, strong) CADisplayLink         *dispalayLink;
@property (nonatomic, strong) CAShapeLayer         *shape1;
@property (nonatomic, strong) CAShapeLayer         *shape2;
@property (nonatomic, strong) CAShapeLayer         *shape3;


@end
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation RJBWaterView

{
    CGFloat _waveAmplitude;      //!< 振幅
    CGFloat _waveCycle;          //!< 周期
    CGFloat _waveSpeed;          //!< 速度
    CGFloat _waterWaveHeight;
    CGFloat _waterWaveWidth;
    CGFloat _wavePointY;
    CGFloat _waveOffsetX;            //!< 波浪x位移
    UIColor *_waveColor;             //!< 波浪颜色
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configParam];
        self.backgroundColor = rgba(251, 91, 91,1);
        [self.layer addSublayer:self.shape1];
        [self.layer addSublayer:self.shape2];
        [self.layer addSublayer:self.shape3];
        [self.dispalayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

//配置参数
- (void)configParam {
    _waterWaveWidth = self.frame.size.width;
    _waveColor =  rgba(255, 255, 255,0.1);
    _waveSpeed = 0.15/M_PI;
    _waveOffsetX = 0;
    _wavePointY = self.frame.size.height - 50;
    _waveAmplitude = 10;
    _waveCycle =  1.2* M_PI / _waterWaveWidth;
}

//绘制shapelayer
- (void)setupSawe {
    _waveOffsetX += _waveSpeed;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    UIBezierPath *path3 = [UIBezierPath bezierPath];

    
    CGFloat W = self.frame.size.width;
    for (CGFloat i = 0.0; i < W; i++) {
        CGFloat x = i;
        CGFloat y = _waveAmplitude * sin(_waveCycle * x + _waveOffsetX - 10) + _wavePointY + 10;
        CGFloat y2 = (_waveAmplitude -2) * sin(_waveCycle * x + _waveOffsetX ) + _wavePointY ;
        CGFloat y3 = (_waveAmplitude +2)* sin(_waveCycle * x + _waveOffsetX + 20) + _wavePointY -10;
        if (i == 0) {
            [path moveToPoint:CGPointMake(x, y)];
            [path2 moveToPoint:CGPointMake(x, y2)];
            [path3 moveToPoint:CGPointMake(x, y3)];
            
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
            [path2 addLineToPoint:CGPointMake(x, y2)];
            [path3 addLineToPoint:CGPointMake(x, y3)];
        }
    }
    
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    [path2 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path2 addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path2 closePath];
    
    [path3 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path3 addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path3 closePath];
    
    self.shape1.path = path.CGPath;
    self.shape2.path = path2.CGPath;
    self.shape3.path = path3.CGPath;

    
    _waveOffsetX += 0.25 / M_PI;
}

#pragma mark - lazy
- (CADisplayLink *)dispalayLink {
    if (!_dispalayLink) {
        _dispalayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setupSawe)];
    }
    return _dispalayLink;
}

- (CAShapeLayer *)shape1 {
    if (!_shape1) {
        _shape1 = [CAShapeLayer layer];
        _shape1.fillColor = _waveColor.CGColor;
//        _shape1.fillColor = [UIColor clearColor].CGColor;
    }
    return _shape1;
}

- (CAShapeLayer *)shape2 {
    if (!_shape2) {
        _shape2 = [CAShapeLayer layer];
        _shape2.fillColor = _waveColor.CGColor;
//        _shape2.fillColor = [UIColor clearColor].CGColor;
    }
    return _shape2;
}

- (CAShapeLayer *)shape3 {
    if (!_shape3) {
        _shape3 = [CAShapeLayer layer];
        _shape3.fillColor = _waveColor.CGColor;
//        _shape3.fillColor = [UIColor clearColor].CGColor;
    }
    return _shape3;
}

@end
