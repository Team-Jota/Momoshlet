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
    
    CustomButton *cb = [CustomButton initWithDelegate:self];
    
    for(int i=0;i<6;i++){
        
        UIButton *btn = [cb makeButton:CGRectMake(0, 0, 250, 200) :nil :10*(i+1) :img];
        btn.transform = CGAffineTransformMakeScale(0.25, 0.25);
        
        if(i<3)
            btn.center = CGPointMake(110*i, 120);
        else
            btn.center = CGPointMake(110*(i-3), 240);
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
