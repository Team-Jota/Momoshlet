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

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        saveData = [SaveData initSaveData];
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor whiteColor];
        
        index = _index;
        NSDictionary *status = [saveData.statusArray objectAtIndex:index];
        dirtyLevel = [[status objectForKey:@"dirty_level"] intValue];
        
        isFinish = NO;
        isAnimation = YES;
        isWaterAnimation = YES;
        isAccelerometer = NO;
        
        start = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"wash_start" ofType:@"m4a"]] error:nil];
        
        washing = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"washing" ofType:@"m4a"]] error:nil];
        washing.numberOfLoops = -1;
        
        end = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"wash_end" ofType:@"m4a"]] error:nil];
        
        junny = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"junney2" ofType:@"m4a"]] error:nil];
        
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wc.png"]];
        bgImg.frame = CGRectMake(0, 0, 320, 480);
        [self addSubview:bgImg];
        
        //桃
        momoView = [[UIView alloc] initWithFrame:CGRectMake(BETWEEN, 30, 250, 250)];
        momoView.backgroundColor = [UIColor clearColor];
        [self addSubview:momoView];
        
        momoNotHitImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-2.png",[[status objectForKey:@"id"] intValue]/100]]];
        momoNotHitImg.frame = CGRectMake(0, 0, 250, 250);
        [momoView addSubview:momoNotHitImg];
        
        momoHitImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-3.png",[[status objectForKey:@"id"] intValue]/100]]];
        momoHitImg.frame = CGRectMake(0, 0, 250, 250);
        momoHitImg.hidden = YES;
        [momoView addSubview:momoHitImg];
        
        moveView = [[UIView alloc] initWithFrame:CGRectMake(110,350, 100, 100)];
        [self addSubview:moveView];
        imgRadius = moveView.frame.size.width/2;
        delta = CGPointMake(0.0, 0.0);
        translation = moveView.center;
        
        waterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"water.png"]];
        waterView.frame = CGRectMake(0, -150, 100, 300);
        waterView.transform = CGAffineTransformMakeScale(0.001, 0.25);
        waterPoint = waterView.center;
        [moveView addSubview:waterView];
        
        //汚れの反映
        [self setStateEffect];
        
        UIGraphicsBeginImageContext(CGSizeMake(400, 400));
        for (int i=1; i<=[[status objectForKey:@"injury_level"] integerValue]; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"bug%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *injury = [[UIImageView alloc] initWithImage:img];
        injury.frame = CGRectMake(0, 0, 250, 250);
        [momoView addSubview:injury];
        
        //ノズル
        UIImageView *nozzleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nozzle.png"]];
        nozzleImg.frame = CGRectMake(0, 0, 100, 100);
        [moveView addSubview:nozzleImg];

        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 1.0f/60.0f;
    }
    return self;
}

- (void)startWater
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    BOOL injury_zero = [[status objectForKey:@"injury_zero"] boolValue];
    int injury_level = [[status objectForKey:@"injury_level"] intValue];
    
    if (dirtyLevel==5 && (injury_zero==YES || injury_level==5))
    {
        [saveData setHeaven:index :YES :injury_zero];
    }
    
    [saveData resetDirty:index];
    
    [washing play];
    [self waterAnimation];
    isAccelerometer = YES;
}

- (void)setNozzle
{
    if ([start isPlaying] == YES){
        [start stop];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(startWater)];
    }
    
    waterView.center = CGPointMake(waterPoint.x, waterPoint.y);
    waterView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView commitAnimations];
}

- (void)startWashlet
{
    moveView.center = CGPointMake(moveView.center.x, moveView.center.y+100);
    waterView.center = CGPointMake(waterPoint.x, waterPoint.y+200);
    
    [start play];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(setNozzle)];
    }
    
    moveView.center = CGPointMake(moveView.center.x, moveView.center.y-100);
    
    [UIView commitAnimations];
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
}

- (void)sayHoh
{
    if ([junny isPlaying] == NO) {
        [junny play];
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    if (isAccelerometer == YES) {
        
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
        dirty5.alpha -= 0.02;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
        [self sayHoh];
    }
    else if (moveView.center.x > 98+BETWEEN && moveView.center.x <= 117+BETWEEN && dirty3!=nil && dirty3.alpha > 0) {
        dirty3.alpha -= 0.02;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
        [self sayHoh];
    }
    else if (moveView.center.x > 117+BETWEEN && moveView.center.x <= 137+BETWEEN && dirty1!=nil && dirty1.alpha > 0) {
        dirty1.alpha -= 0.02;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
        [self sayHoh];
    }
    else if (moveView.center.x > 137+BETWEEN && moveView.center.x <= 160+BETWEEN && dirty2!=nil && dirty2.alpha > 0) {
        dirty2.alpha -= 0.02;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
        [self sayHoh];
    }
    else if (moveView.center.x > 160+BETWEEN && moveView.center.x <= 184+BETWEEN && dirty4!=nil && dirty4.alpha > 0) {
        dirty4.alpha -= 0.02;
        momoHitImg.hidden = NO;
        momoNotHitImg.hidden = YES;
        [self sayHoh];
    }
    else {
        momoHitImg.hidden = YES;
        momoNotHitImg.hidden = NO;
    }
    
    //NSLog(@"1 = %f, 2 = %f, 3 = %f, 4 = %f, 5 = %f",dirty1.alpha,dirty2.alpha,dirty3.alpha,dirty4.alpha,dirty5.alpha);
    
    if (isFinish==NO) {
        if (dirtyLevel==1) {
            if (dirty1.alpha<0) {
                isFinish = YES;
                [self stopWater];
            }
        }
        else if (dirtyLevel==2) {
            if (dirty1.alpha<0 && dirty2.alpha<0) {
                isFinish = YES;
                [self stopWater];
            }
        }
        else if (dirtyLevel==3) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0) {
                isFinish = YES;
                [self stopWater];
            }
        }
        else if (dirtyLevel==4) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0 && dirty4.alpha<0) {
                isFinish = YES;
                [self stopWater];
            }
        }
        else if (dirtyLevel==5) {
            if (dirty1.alpha<0 && dirty2.alpha<0 && dirty3.alpha<0 && dirty4.alpha<0 && dirty5.alpha<0) {
                isFinish = YES;
                [self stopWater];
            }
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
    [UIView setAnimationDelegate:self];
    if (isWaterAnimation) {
        [UIView setAnimationDidStopSelector:@selector(waterAnimation)];
    }
        
    waterView.center = CGPointMake(waterPoint.x, waterPoint.y+25);
    
    [UIView commitAnimations];
}

- (void)waterAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    if (isWaterAnimation) {
        [UIView setAnimationDidStopSelector:@selector(waterAnimation2)];
    }
        
    waterView.center = CGPointMake(waterPoint.x, waterPoint.y-25);
    
    
    [UIView commitAnimations];
}

- (void)finishAnimation2
{
    [end play];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //[UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(callRemoveWashletView)];
    }
    
    moveView.center = CGPointMake(moveView.center.x, moveView.center.y+100);
    
    [UIView commitAnimations];
}

- (void)finishAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(finishAnimation2)];
    }
    
    moveView.center = CGPointMake(160, moveView.center.y);
    waterView.center = CGPointMake(waterPoint.x, waterPoint.y+200);
    waterView.transform = CGAffineTransformMakeScale(0.001, 0.25);
    
    [UIView commitAnimations];
}

- (void)stopWater
{
    [washing stop];
    isAccelerometer = NO;
    isWaterAnimation = NO;
    //[waterView stopAnimating];
    
    [self performSelector:@selector(finishAnimation) withObject:nil afterDelay:1.0];
}

- (void)callRemoveWashletView
{
    isAnimation = NO;
    if ([end isPlaying] == YES) {
        [end stop];
    }
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
