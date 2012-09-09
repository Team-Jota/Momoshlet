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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    NSString *img;
    img = @"momo1-2.png";
    
    cb = [CustomButton initWithDelegate:self];
    
    CGPoint point[6] = {CGPointMake(100, 90),
                        CGPointMake(160, 160),
                        CGPointMake(240, 90),
                        CGPointMake(180, 250),
                        CGPointMake(260, 170),
                        CGPointMake(70, 210)};
    
    for(int i=0;i<6;i++){
        UIButton *btn = [cb makeButton:CGRectMake(0, 0, 100, 100) :@selector(breedView:) :10*(i+1) :img];
        
        MomoAnimationView *momoBtn = [[MomoAnimationView alloc] initWithMomoButton:btn];
        [momoBtn growMomo];
        [momoBtn performSelector:@selector(statAniamtion) withObject:nil afterDelay:0.5*i];
        momoBtn.center = point[i];
        
        [self.view addSubview:momoBtn];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:0.690 green:0.886 blue:1.000 alpha:1.0];
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

-(void) breedView:(UIButton *)btn
{
    NSLog(@"fdashgkjlfhgjklfhlkjghdflk");
    breed = [[BreedView alloc] initWithDelegate:self :(btn.tag/10)-1];
    [self.view addSubview:breed];
}

-(void) removeBreedView
{
    NSLog(@"remove BreedView");
    if(breed){
        [breed removeFromSuperview];
    }
}




@end
