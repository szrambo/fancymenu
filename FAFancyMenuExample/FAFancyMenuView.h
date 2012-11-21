//
//  FAFancyMenuView.h
//  TestAnimation
//
//  Created by Ben Xu on 12-11-21.
//  Copyright (c) 2012年 Fancy App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFancyButton.h"
@class FAFancyMenuView;
@protocol FAFancyMenuViewDelegate <NSObject>
- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index;
@end

@interface FAFancyMenuView : UIView
@property (nonatomic, assign) id<FAFancyMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *buttonImages;
@property (nonatomic) BOOL onScreen;
- (void)show;
- (void)hide;
@end
