//
//  MainViewController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

#define INTERVAL_DIRTY 3
#define INTERVAL_INJURY 5

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
    
    point[0] = CGPointMake(100, 90);
    point[1] = CGPointMake(160, 160);
    point[2] = CGPointMake(240, 90);
    point[3] = CGPointMake(180, 250);
    point[4] = CGPointMake(260, 170);
    point[5] = CGPointMake(70, 210);
    
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 160)];
    backImg.backgroundColor = [UIColor clearColor];
    backImgPoint = backImg.center;
    [self.view addSubview:backImg];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    cb = [CustomButton initWithDelegate:self];
    saveData = [SaveData initSaveData];
    
    [self setMomoButton];
    
    fadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    fadeView.backgroundColor = [UIColor blackColor];
    fadeView.alpha = 0;
    fadeView.userInteractionEnabled = NO;
    [self.view addSubview:fadeView];
    
    [self setBack];
    
    isAnimation = YES;
    [self backAnimation];
    
    if (saveData.tutorial == YES) {
        tutorial = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorial1.png"]];
        tutorial.frame = CGRectMake(0, 0, 320, 480);
        tutorial.userInteractionEnabled = NO;
        [self.view addSubview:tutorial];
    }
    else {
        tutorial = nil;
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app setMVC:self];
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
    
    if (tutorial) {
        [tutorial removeFromSuperview];
        tutorial = nil;
    }
    
    if (saveData.tutorial == YES) {
        [saveData tutorialOff];
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app tabBatItemCollectionEnabled:YES];
    [app tabBatItemMainEnabled:YES];
}

- (void)setMomoButton
{    
    momoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    momoView.backgroundColor = [UIColor clearColor];
    
    cb = [CustomButton initWithDelegate:self];
    
    for(int i=0;i<6;i++){        
        UIButton *btn = [cb makeButton:CGRectMake(0, 0, 100, 100) :@selector(breedView:) :10*(i+1) :nil];
        
        MomoAnimationView *momoBtn = [[MomoAnimationView alloc] initWithMomoButton:btn];
        momoBtn.tag = 100*(i+1);
        [momoBtn growMomo];
        //[momoBtn performSelector:@selector(calucDirtyState) withObject:nil afterDelay:INTERVAL_DIRTY*60];
        //[momoBtn performSelector:@selector(calucInjuryState) withObject:nil afterDelay:INTERVAL_INJURY*60];
        [momoBtn setDirty];
        [momoBtn setInjury];
        [momoBtn setStateEffect];
        [momoBtn performSelector:@selector(statAniamtion) withObject:nil afterDelay:0.5*i];
        momoBtn.center = point[i];
        
        [momoView addSubview:momoBtn];
    }
    
    [self.view insertSubview:momoView atIndex:2];
}

- (void)resetMomoButton:(int)index
{    
    MomoAnimationView *momoBtn = (MomoAnimationView *)[momoView viewWithTag:(index+1)*100];
    [momoBtn stopAniamtion];
    [momoBtn stopPerformSelector];
    [momoBtn removeFromSuperview];
    momoBtn = nil;
    
    cb = [CustomButton initWithDelegate:self];
    UIButton *btn = [cb makeButton:CGRectMake(0, 0, 100, 100) :@selector(breedView:) :10*(index+1) :nil];
        
    MomoAnimationView *newMomoBtn = [[MomoAnimationView alloc] initWithMomoButton:btn];
    momoBtn.tag = 100*(index+1);
    [newMomoBtn growMomo];
    [newMomoBtn performSelector:@selector(calucDirtyState) withObject:nil afterDelay:INTERVAL_DIRTY*60];
    [newMomoBtn performSelector:@selector(calucInjuryState) withObject:nil afterDelay:INTERVAL_INJURY*60];
    [newMomoBtn setStateEffect];
    [newMomoBtn performSelector:@selector(statAniamtion) withObject:nil afterDelay:0.5];
    newMomoBtn.center = point[index];
    
    [momoView addSubview:newMomoBtn];
}

- (void)setBack
{
    NSDate *now =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"kk"];
    int now_h = [[formatter stringFromDate:now] intValue];

    UIColor *color;
    if (now_h >= 7 && now_h <=16) {
        color = [UIColor colorWithRed:0.690 green:0.886 blue:1.000 alpha:1.0];
        fadeView.alpha = 0;
        [backImg setImage:[UIImage imageNamed:@"day.png"]];
    }
    else if ((now_h >= 19 && now_h <=24) || (now_h >= 1 && now_h <=5)) {
        color = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.0];
        fadeView.alpha = 0.2;
        [backImg setImage:[UIImage imageNamed:@"night.png"]];
    }
    else {
        color = [UIColor colorWithRed:0.973 green:0.690 blue:0.141 alpha:1.0];
        fadeView.alpha = 0.1;
        [backImg setImage:[UIImage imageNamed:@"night.png"]];
    }
    
    self.view.backgroundColor = color;
    
    [self performSelector:@selector(setBack) withObject:nil afterDelay:60*60];
}

- (void)backAnimation
{
    backImg.center = backImgPoint;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:30.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(backAnimation)];
    }
    
    backImg.center = CGPointMake(backImgPoint.x - 160, backImgPoint.y);
    
    [UIView commitAnimations];
}

- (void)recallMomoState
{
    for (int i=0; i<6; i++) {
        MomoAnimationView *momoBtn = (MomoAnimationView *)[momoView viewWithTag:(i+1)*100];
        [momoBtn stopPerformSelector];
        [momoBtn growMomo];
        [momoBtn setDirty];
        [momoBtn setInjury];
    }
    
    [self setBack];
    [self backAnimation];
}

@end
