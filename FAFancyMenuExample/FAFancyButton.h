//
//  FAFancyButton.h
//  TestAnimation
//
//  Created by Ben Xu on 12-11-21.
//  Copyright (c) 2012年 Fancy App. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    FAFancyButtonFadeIn,
    FAFancyButtonFadeOut
} FAFancyButtonState;
@interface FAFancyButton : UIButton
@property (nonatomic) CGFloat degree;
@property (nonatomic) FAFancyButtonState state;
- (void)show;
- (void)hide;
@end
