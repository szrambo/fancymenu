//
//  FAFancyButton.m
//  TestAnimation
//
//  Created by Ben Xu on 12-11-21.
//  Copyright (c) 2012年 Fancy App. All rights reserved.
//
#define DegreesToRadians(degrees) (degrees * M_PI / 180.f)
#import "FAFancyButton.h"
#import <QuartzCore/QuartzCore.h>
@interface FAFancyButton ()

@end
@implementation FAFancyButton
@synthesize state = _state;
@synthesize degree = _degree;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.layer.anchorPoint = CGPointMake(0.5,1.f);
        self.layer.position = CGPointMake(frame.size.width/2 + frame.origin.x, frame.size.height);
    }
    return self;
}

- (void)show{
    self.hidden = NO;
    [self.layer addAnimation:[self fadeInAnimation] forKey:@"FancyButtonFadeIn"];
}

- (void)hide{
    [self.layer addAnimation:[self rotateAnimationFromDegree:self.degree toDegree:0 delegate:self] forKey:@"FancyButtonRotationBack"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"] && flag){
        switch (self.state) {
            case FAFancyButtonFadeIn:
                [self.layer addAnimation:[self rotateAnimationFromDegree:0 toDegree:self.degree delegate:nil] forKey:@"FancyButtonRotation"];
                self.transform = CGAffineTransformMakeRotation(DegreesToRadians(self.degree));
                break;
            case FAFancyButtonFadeOut:
                self.hidden = YES;
                break;
            default:
                break;
        }
    }else if ([animation.keyPath isEqualToString:@"transform.rotation.z"] && flag){
        [self.layer addAnimation:[self fadeOutAnimation] forKey:@"FancyButtonFadeOut"];
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(self.degree));
    }
}

- (CABasicAnimation *)fadeInAnimation{
    self.state = FAFancyButtonFadeIn;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, .1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}

- (CABasicAnimation *)fadeOutAnimation{
    self.state = FAFancyButtonFadeOut;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, .1)];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}

- (CABasicAnimation *)rotateAnimationFromDegree:(CGFloat)from toDegree:(CGFloat)to delegate:(id)delegate{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat: DegreesToRadians(from)];
    rotationAnimation.toValue = [NSNumber numberWithFloat: DegreesToRadians(to)];
    rotationAnimation.duration = 0.3f;
    rotationAnimation.delegate = delegate;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    return rotationAnimation;
}

@end
