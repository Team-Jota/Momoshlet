//
//  MainViewController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    NSString *img;
    
    img = @"momo_shade.png";
    
    UIImage *image = [UIImage imageNamed:img];
    int count;
    for(count=0;count<6;count++){
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        if(count<3)
            btn.center = CGPointMake(160, 120);
        else
            btn.center = CGPointMake(160, 120);
            
        [self.view addSubview:btn];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
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
