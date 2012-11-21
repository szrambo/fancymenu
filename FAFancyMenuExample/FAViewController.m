//
//  FAViewController.m
//  FAFancyMenuExample
//
//  Created by Ben Xu on 12-11-21.
//  Copyright (c) 2012年 Fancy App. All rights reserved.
//

#import "FAViewController.h"

@interface FAViewController ()
@property (nonatomic, strong) FAFancyMenuView *menu;
@end

@implementation FAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
    self.menu = [[FAFancyMenuView alloc] init];
    self.menu.delegate = self;
    self.menu.buttonImages = images;
    [self.view addSubview:self.menu];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%i",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
