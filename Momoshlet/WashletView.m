//
//  WashletView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "WashletView.h"
#import <QuartzCore/QuartzCore.h>

#define BETWEEN 35

@implementation WashletView

@synthesize nozzleImg;

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        saveData = [SaveData initSaveData];
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor whiteColor];
        
        NSDictionary *status = [saveData.statusArray objectAtIndex:index];
        dirtyLevel = [[status objectForKey:@"dirty_level"]intValue];
        index = _index;
        
        isFinish = NO;
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveWashletView) :100 :nil];
        rmButton.backgroundColor = [UIColor blueColor];
        [self addSubview:rmButton];
        
        //桃
        momoView = [[UIView alloc] initWithFrame:CGRectMake(BETWEEN, 30, 250, 250)];
        momoView.backgroundColor = [UIColor clearColor];
        [self addSubview:momoView];
        
        momoNotHitImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
        momoNotHitImg.frame = CGRectMake(0, 0, 250, 250);
        [momoView addSubview:momoNotHitImg];
        
        momoHitImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-3.png"]];
        momoHitImg.frame = CGRectMake(0, 0, 250, 250);
        momoHitImg.hidden = YES;
        [momoView addSubview:momoHitImg];
        
        moveView = [[UIView alloc] initWithFrame:CGRectMake(110,350, 100, 100)];
        [self addSubview:moveView];
        imgRadius = nozzleImg.frame.size.width/2;
        delta = CGPointMake(0.0, 0.0);
        translation = moveView.center;
        
        waterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"water.png"]];
        waterView.frame = CGRectMake(0, -150, 100, 300);
        [moveView addSubview:waterView];
        
        isAnimation = YES;
        [self waterAnimation];
        
        //汚れの反映
        [self setStateEffect];
        
        //ノズル
        nozzleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"momo1-1.png"]];
        nozzleImg.frame = CGRectMake(0, 0, 100, 100);
        [moveView addSubview:nozzleImg];
        //nozzleImg.frame = CGRectMake(110,350,100,100);
        //[self addSubview:nozzleImg];
        //imgRadius = nozzleImg.frame.size.width/2;
        //delta = CGPointMake(0.0, 0.0);
        //translation = nozzleImg.center;
        
        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 1.0f/60.0f;
    }
    return self;
}


- (void)setStateEffect
{
    CGRect rect = CGRectMake(0, 0, 250, 250);
    dirty1 = nil;
    dirty2 = nil;
    dirty3 = nil;
    dirty4 = nil;
    dirty5 = nil;

    
    if(dirtyLevel>=1){
        dirty1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty1.png"]];
        dirty1.frame = rect;
        [momoView addSubview:dirty1];
    }
    if(dirtyLevel>=2){
        dirty2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty2.png"]];
        dirty2.frame = rect;
        [momoView addSubview:dirty2];
    }
    if(dirtyLevel>=3){
        dirty3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty3.png"]];
        dirty3.frame = rect;
        [momoView addSubview:dirty3];
    }
    if(dirtyLevel>=4){
        dirty4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty4.png"]];
        dirty4.frame = rect;
        [momoView addSubview:dirty4];
    }
    if(dirtyLevel==5){
        dirty5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty5.png"]];
        dirty5.frame = rect;
        [momoView addSubview:dirty5];
    }
    
    //dirty3.alpha = 0.2;
    NSLog(@"dirty1 coordinate:%f",dirty5.center.x);
}
    

/*- (void)washMomo
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    int indexCount = [[status objectForKey:@"dirty_level"]integerValue];
    
    if(indexCount>=1){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=2){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=3){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=4){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=5){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    
    
    if((35<=translation.x)&&(translation.x<85)){
        
    }
    if((85<=translation.x)&&(translation.x<135)){
        
    }
    if((135<=translation.x)&&(translation.x<185)){
        
    }
    if((185<=translation.x)&&(translation.x<235)){
        
    }
    if((235<=translation.x)&&(translation.x<285)){
        
    }
}*/


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    //delta.x = 30 * acceleration.x;
        
    if ((translation.x==320-imgRadius||translation.x==imgRadius)&&delta.x!=0)
        delta.x = 0;
    else if((-30<=delta.x)&(delta.x<=30))
        delta.x += acceleration.x*2;
    else if(delta.x<-30)
        delta.x = -30;
    else
        delta.x = 30;
    
    translation.x = translation.x + delta.x;
    if (translation.x + imgRadius > 320) {
        translation.x = 320 - imgRadius;
    }
    else if (translation.x - imgRadius < 0) {
        translation.x = imgRadius;
    }
    
    moveView.center = CGPointMake(translation.x , translation.y);
    
    if (moveView.center.x > 73+BETWEEN && moveView.center.x <= 98+BETWEEN && dirty5!=nil && dirty5.alpha > 0) {
        dirty5.alpha -= 0.005;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
    }
    else if (moveView.center.x > 98+BETWEEN && moveView.center.x <= 117+BETWEEN && dirty3!=nil && dirty3.alpha > 0) {
        dirty3.alpha -= 0.005;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
    }
    else if (moveView.center.x > 117+BETWEEN && moveView.center.x <= 137+BETWEEN && dirty1!=nil && dirty1.alpha > 0) {
        dirty1.alpha -= 0.005;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
    }
    else if (moveView.center.x > 137+BETWEEN && moveView.center.x <= 160+BETWEEN && dirty2!=nil && dirty2.alpha > 0) {
        dirty2.alpha -= 0.005;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
    }
    else if (moveView.center.x > 160+BETWEEN && moveView.center.x <= 184+BETWEEN && dirty4!=nil && dirty4.alpha > 0) {
        dirty4.alpha -= 0.005;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
    }
    else {
        momoHitImg.hidden = YES;
        momoNotHitImg.hidden = NO;
    }
    
    NSLog(@"1 = %f, 2 = %f, 3 = %f, 4 = %f, 5 = %f"
          ,dirty1.alpha,dirty2.alpha,dirty3.alpha,dirty4.alpha,dirty5.alpha);
    
    if (isFinish==NO) {
        if (dirtyLevel==1) {
            if (dirty1.alpha<0) {
                isFinish = YES;
                [self callRemoveWashletView];
            }
        }
        else if (dirtyLevel==2) {
            if (dirty1.alpha<0 && dirty2.alpha<0) {
                isFinish = YES;
                [self callRemoveWashletView];
            }
        }
        else if (dirtyLevel==3) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0) {
                isFinish = YES;
                [self callRemoveWashletView];
            }
        }
        else if (dirtyLevel==4) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0 && dirty4.alpha<0) {
                isFinish = YES;
                [self callRemoveWashletView];
            }
        }
        else if (dirtyLevel==5) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0 && dirty4.alpha<0 && dirty5.alpha<0) {
                isFinish = YES;
                [self callRemoveWashletView];
            }
        }
    }
}

- (void)waterAnimation2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:0.5];
    //[UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(waterAnimation)];
    }
        
    waterView.center = CGPointMake(waterView.center.x, waterView.center.y+25);
    
    [UIView commitAnimations];
}

- (void)waterAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:0.5];
    //[UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(waterAnimation2)];
    }
        
    waterView.center = CGPointMake(waterView.center.x, waterView.center.y-25);
    
    
    [UIView commitAnimations];
}

- (void)callRemoveWashletView
{
    isAnimation = NO;
    [saveData resetDirty:index];
    [[UIAccelerometer sharedAccelerometer]setDelegate:nil];
    [delegate removeWashletView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
