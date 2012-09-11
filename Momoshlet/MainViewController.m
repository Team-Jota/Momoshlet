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
    
    cb = [CustomButton initWithDelegate:self];
    saveData = [SaveData initSaveData];
    momoView = nil;
    
    [self setMomoButton];
    
    fadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    fadeView.backgroundColor = [UIColor blackColor];
    fadeView.alpha = 0;
    fadeView.userInteractionEnabled = NO;
    [self.view addSubview:fadeView];
    
    [self setBack];
    
    //self.view.backgroundColor = [UIColor colorWithRed:0.690 green:0.886 blue:1.000 alpha:1.0];
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
    breed = [[BreedView alloc] initWithDelegate:self :(btn.tag/10)-1];
    [self.view addSubview:breed];
}

-(void) removeBreedView
{
    if(breed){
        [breed removeFromSuperview];
        breed = nil;
    }
}

- (void)setMomoButton
{
    if (momoView) {
        [momoView removeFromSuperview];
        momoView = nil;
    }
    
    momoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    momoView.backgroundColor = [UIColor clearColor];
    
    CGPoint point[6] = {CGPointMake(100, 90),
        CGPointMake(160, 160),
        CGPointMake(240, 90),
        CGPointMake(180, 250),
        CGPointMake(260, 170),
        CGPointMake(70, 210)};
    
    for(int i=0;i<6;i++){        
        UIButton *btn = [cb makeButton:CGRectMake(0, 0, 100, 100) :@selector(breedView:) :10*(i+1) :nil];
        
        MomoAnimationView *momoBtn = [[MomoAnimationView alloc] initWithMomoButton:btn];
        [momoBtn growMomo];
        [momoBtn calucDirtyState];
        [momoBtn calucInjuryState];
        [momoBtn setStateEffect];
        [momoBtn performSelector:@selector(statAniamtion) withObject:nil afterDelay:0.5*i];
        momoBtn.center = point[i];
        
        [momoView addSubview:momoBtn];
    }
    
    [self.view insertSubview:momoView atIndex:1];
}

- (void)setBack
{
    NSDate *now =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"kk"];
    int now_h = [[formatter stringFromDate:now] intValue];
 
    NSLog(@"hour = %d",now_h);
    
    UIColor *color;
    if (now_h >= 7 && now_h <=16) {
        color = [UIColor colorWithRed:0.690 green:0.886 blue:1.000 alpha:1.0];
        fadeView.alpha = 0;
    }
    else if ((now_h >= 19 && now_h <=24) || (now_h >= 1 && now_h <=5)) {
        color = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.0];
        fadeView.alpha = 0.5;
    }
    else {
        color = [UIColor colorWithRed:0.973 green:0.690 blue:0.141 alpha:1.0];
        fadeView.alpha = 0.3;
    }
    
    self.view.backgroundColor = color;
}


@end
