//
//  TabBarController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/11.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "TabBarController.h"
#import "AppDelegate.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSArray *viewControllers = self.viewControllers;
    UIViewController *main = [viewControllers objectAtIndex:0];
    UIViewController *collection = [viewControllers objectAtIndex:1];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app setTabBarItemMain:main.tabBarItem];
    [app setTabBarItemCollection:collection.tabBarItem];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
