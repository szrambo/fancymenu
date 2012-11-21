FancyMenu
===========================

FancyMenu is A popup menu that similar to the share menu in Summly App.

How to use:
--------
Long Press on the screen show
Tap on the screen to hide
Create the menu by setting up the item array
	
	NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
	self.menu = [[FAFancyMenuView alloc] init];
	self.menu.delegate = self;
	self.menu.buttonImages = images;
	[self.view addSubview:self.menu];
	
Configure your viewController and conform to the FAFancyMenuViewDelegate
	
	- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    	NSLog(@"%i",index);
	}


About me:
--------

	Twitter: [@szrambo](http://twitter.com/szrambo) 

	Sina Weibo: [@82010292](http://weibo.com/82010292) 