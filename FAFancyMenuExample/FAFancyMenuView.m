//
//  FAFancyMenuView.m
//  TestAnimation
//
//  Created by Ben Xu on 12-11-21.
//  Copyright (c) 2012年 Fancy App. All rights reserved.
//

#import "FAFancyMenuView.h"
#import "FAFancyButton.h"
@implementation FAFancyMenuView
- (void)addButtons{
    self.frame = CGRectMake(100, 100, ((UIImage *)[self.buttonImages lastObject]).size.height * 2, ((UIImage *)[self.buttonImages lastObject]).size.height * 2);
    if (self.subviews.count > 0)
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger i = 0;
    CGFloat degree = 360.f/self.buttonImages.count;
    for (UIImage *image in self.buttonImages){
        FAFancyButton *fancyButton = [[FAFancyButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - image.size.width/2, 0, image.size.width, image.size.height)];
        [fancyButton setBackgroundImage:image forState:UIControlStateNormal];
        fancyButton.degree = i*degree;
        fancyButton.hidden = YES;
        fancyButton.tag = i + 292;
        [fancyButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fancyButton];
        i++;
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    if (self.onScreen) return;
    UIView *superView = [sender view];
    CGPoint pressedPoint = [sender locationInView:superView];
    CGPoint newCenter = pressedPoint;
    if ((pressedPoint.x - self.frame.size.width/2) < 0){
        newCenter.x = self.frame.size.width/2;
    }
    if ((pressedPoint.x + self.frame.size.width/2) > superView.frame.size.width){
        newCenter.x = superView.frame.size.width - self.frame.size.width/2;
    }
    if ((pressedPoint.y - self.frame.size.height/2) <0){
        newCenter.y = self.frame.size.height/2;
    }
    if ((pressedPoint.y + self.frame.size.height/2) > superView.frame.size.height){
        newCenter.y = superView.frame.size.height - self.frame.size.height/2;
    }
    self.center = newCenter;
    [self show];
}

- (void)handleTap:(UITapGestureRecognizer *)tap{
    if (!self.onScreen) return;
    [self hide];
}

- (void)addGestureRecognizerForView:(UIView *)view{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [view addGestureRecognizer:longPress];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [view addGestureRecognizer:tap];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self addGestureRecognizerForView:newSuperview];
}


- (void)buttonPressed:(FAFancyButton *)button{
//    NSLog(@"%i",button.tag - 292);
    if (self.delegate){
        if ([self.delegate respondsToSelector:@selector(fancyMenu:didSelectedButtonAtIndex:)]){
            [self.delegate fancyMenu:self didSelectedButtonAtIndex:button.tag - 292];
        }
    }
}

- (void)showButton:(FAFancyButton *)button{
    [button show];
}

- (void)hideButton:(FAFancyButton *)button{
    [button hide];
}

- (void)hide{
    for (FAFancyButton *button in self.subviews){
        [button hide];
    }
    self.onScreen = NO;
}

- (void)show{
    self.onScreen = YES;
    float delay = 0.f;
    for (FAFancyButton *button in self.subviews){
        [self performSelector:@selector(showButton:) withObject:button afterDelay:delay];
        delay += 0.05;
    }
}

- (void)setButtonImages:(NSArray *)buttonImages{
    if (_buttonImages != buttonImages){
        _buttonImages = buttonImages;
        [self addButtons];
    }
}
@end
