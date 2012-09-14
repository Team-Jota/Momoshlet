//
//  MomoAnimationView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/08.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "MomoAnimationView.h"
#define INTERVAL 1
#define INJURY_INTERVAL 3
#define DIRTY_INTERVAL 5

@implementation MomoAnimationView

- (id)initWithMomoButton:(UIButton *)btn
{
    self = [super initWithFrame:btn.frame];
    if (self) {
        isAnimation = YES;
        saveData = [SaveData initSaveData];
        button = btn;
        index = (btn.tag/10)-1;
        self.tag = btn.tag * 10;
        
        scaleView = [[UIView alloc] initWithFrame:button.frame];
        scaleView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        [scaleView addSubview:button];
        
        stateEffectView = nil;
        
        [self addSubview:scaleView];
    }
    return self;
}

- (void)animation4{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(statAniamtion)];
    }
        
    self.center = CGPointMake(self.center.x+10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, -0.25);
    
    [UIView commitAnimations];
}

- (void)animation3{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(animation4)];
    }
        
    self.center = CGPointMake(self.center.x-10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, 0.25);
    
    [UIView commitAnimations];
}

- (void)animation2{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(animation3)];
    }
    
    self.center = CGPointMake(self.center.x-10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, 0.25);
    
    [UIView commitAnimations];
}

- (void)statAniamtion{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(animation2)];
    }
        
    self.center = CGPointMake(self.center.x+10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, -0.25);
    
    [UIView commitAnimations];
}

- (void)stopAniamtion{
    isAnimation = NO;
}

- (void)growMomo{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
    float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
    float size = (since * 0.75) / finishTime;
    
    if (size < 0.75){
        scaleView.transform = CGAffineTransformMakeScale(0.25 + size, 0.25 + size);
        [self performSelector:@selector(growMomo) withObject:nil afterDelay:INTERVAL*1];
    }
    else {
        scaleView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
}

- (void)setStateEffect
{
    //@synchronized(self){
    if (stateEffectView) {
        [stateEffectView removeFromSuperview];
        stateEffectView = nil;
    }
    
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    
    NSString *imgName;
    if ([[status objectForKey:@"injury_zero"] boolValue]==YES && [[status objectForKey:@"dirty_zero"] boolValue]==YES) {
        imgName = [NSString stringWithFormat:@"momo%d-3.png",[[status objectForKey:@"id"] intValue]/100];
    }
    else if ([[status objectForKey:@"injury_level"] intValue] > 0 || [[status objectForKey:@"dirty_level"] intValue] > 0) {
        imgName = [NSString stringWithFormat:@"momo%d-2.png",[[status objectForKey:@"id"] intValue]/100];
    }
    else {
        imgName = [NSString stringWithFormat:@"momo%d-1.png",[[status objectForKey:@"id"] intValue]/100];
    }
    
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    UIGraphicsBeginImageContext(CGSizeMake(400, 400));
    
    for (int i=1; i<=[[status objectForKey:@"dirty_level"] intValue]; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }
    
    for (int i=1; i<=[[status objectForKey:@"injury_level"] integerValue]; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"bug%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    stateEffectView = [[UIImageView alloc] initWithImage:img];
    stateEffectView.frame = button.frame;
    
    [scaleView addSubview:stateEffectView];
    //}
}

- (void)setInjury
{
    NSLog(@"call setInjury");
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"injury_updated_time"]];
    int count = since / (60 * INJURY_INTERVAL);
    
    BOOL isUpdated = NO;
    if ([[status objectForKey:@"injury_level"] intValue] < 5) {
        for (int i =0; i<count; i++) {
            float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
            float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
            float size = (since * 0.75) / finishTime;
            
            double dirty_l;
            double dirty_r;
            
            if (size < 1.0) {
                dirty_l = (double)(72 - ([[status objectForKey:@"injury_resistance"] intValue] * 12)) / 72;
                dirty_r = (double)[[status objectForKey:@"injury_resistance"] intValue] / 8;
            }
            else {
                dirty_l = (double)(72 - ([[status objectForKey:@"injury_resistance"] intValue] * 12)) / 72;
                dirty_r = (double)[[status objectForKey:@"injury_resistance"] intValue] / 8;
            }
            
            int range = (dirty_l - dirty_r) * 100;
            int random = arc4random()%100 + 1;
            
            if (range>100) {
                range = 100;
            }
            
            if (random <= range && [[status objectForKey:@"injury_level"] intValue] < 5) {
                [saveData countUpInjuryLevel:[NSNumber numberWithInt:index]];
                [saveData setHeaven:index :NO :NO];
                isUpdated = YES;
            }
            
            if ([[status objectForKey:@"injury_level"] intValue] >= 5) {
                break;
            }
        }
        
        if (isUpdated == YES) {
            [saveData updateInjury:index];
            [self setStateEffect];
        }
        
        [self performSelector:@selector(calucInjuryState) withObject:nil afterDelay:INJURY_INTERVAL*60];
    }
}

- (void)calucInjuryState
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
    float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
    float size = (since * 0.75) / finishTime;
    
    double injury_l;
    double injury_r;
    
    if (size < 1.0) {
        injury_l = (double)(72 - ([[status objectForKey:@"injury_resistance"] intValue] * 12)) / 72;
        injury_r = (double)[[status objectForKey:@"injury_resistance"] intValue] / 8;
    }
    else {
        injury_l = (double)(72 - ([[status objectForKey:@"injury_resistance"] intValue] * 12)) / 72;
        injury_r = (double)[[status objectForKey:@"injury_resistance"] intValue] / 8;
    }
    
    int range = (injury_l - injury_r) * 100;
    int random = arc4random()%100 + 1;
    
    if (range>100) {
        range = 100;
    }
    
    if (random <= range && [[status objectForKey:@"injury_level"] intValue] < 5) {
        /*@autoreleasepool {
            [NSThread detachNewThreadSelector:@selector(countUpInjuryLevel:) toTarget:saveData withObject:[NSNumber numberWithInt:index]];
            [NSThread detachNewThreadSelector:@selector(setStateEffect) toTarget:self withObject:nil];
        }*/
        [saveData countUpInjuryLevel:[NSNumber numberWithInt:index]];
        [saveData setHeaven:index :NO :NO];
        [self setStateEffect];
    }
    
    [self performSelector:@selector(calucInjuryState) withObject:nil afterDelay:INJURY_INTERVAL*60];
}

- (void)setDirty
{
    NSLog(@"call setDirty");
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"dirty_updated_time"]];
    int count = since / (60 * DIRTY_INTERVAL);
    
    BOOL isUpdated = NO;
    if ([[status objectForKey:@"dirty_level"] intValue] < 5) {
        for (int i =0; i<count; i++) {
            float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
            float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
            float size = (since * 0.75) / finishTime;
        
            double dirty_l;
            double dirty_r;
        
            if (size < 1.0) {
                dirty_l = (double)(72 - ([[status objectForKey:@"dirty_resistance"] intValue] * 12)) / 72;
                dirty_r = (double)[[status objectForKey:@"dirty_resistance"] intValue] / 8;
            }
            else {
                dirty_l = (double)(72 - ([[status objectForKey:@"dirty_resistance"] intValue] * 12)) / 72;
                dirty_r = (double)[[status objectForKey:@"dirty_resistance"] intValue] / 8;
            }
        
            int range = (dirty_l - dirty_r) * 100;
            int random = arc4random()%100 + 1;
        
            if (range>100) {
                range = 100;
            }
        
            if (random <= range && [[status objectForKey:@"dirty_level"] intValue] < 5) {
                [saveData countUpDirtyLevel:[NSNumber numberWithInt:index]];
                [saveData setHeaven:index :NO :NO];
                isUpdated = YES;
            }
            
            if ([[status objectForKey:@"dirty_level"] intValue] >= 5) {
                break;
            }
        }
    
        if (isUpdated == YES) {
            [saveData updateDirty:index];
            [self setStateEffect];
        }
        
        [self performSelector:@selector(calucDirtyState) withObject:nil afterDelay:DIRTY_INTERVAL*60];
    }
}

- (void)calucDirtyState
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
    float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
    float size = (since * 0.75) / finishTime;
    
    double dirty_l;
    double dirty_r;
    
    if (size < 1.0) {
        dirty_l = (double)(72 - ([[status objectForKey:@"dirty_resistance"] intValue] * 12)) / 72;
        dirty_r = (double)[[status objectForKey:@"dirty_resistance"] intValue] / 8;
    }
    else {
        dirty_l = (double)(72 - ([[status objectForKey:@"dirty_resistance"] intValue] * 12)) / 72;
        dirty_r = (double)[[status objectForKey:@"dirty_resistance"] intValue] / 8;
    }
    
    int range = (dirty_l - dirty_r) * 100;
    int random = arc4random()%100 + 1;
    
    if (range>100) {
        range = 100;
    }
    
    if (random <= range && [[status objectForKey:@"dirty_level"] intValue] < 5) {
        /*@autoreleasepool {
            [NSThread detachNewThreadSelector:@selector(countUpDirtyLevel:) toTarget:saveData withObject:[NSNumber numberWithInt:index]];
            [NSThread detachNewThreadSelector:@selector(setStateEffect) toTarget:self withObject:nil];
        }*/
        [saveData countUpDirtyLevel:[NSNumber numberWithInt:index]];
        [saveData setHeaven:index :NO :NO];
        [self setStateEffect];
    }
    
    [self performSelector:@selector(calucDirtyState) withObject:nil afterDelay:DIRTY_INTERVAL*60];
}

- (void)stopPerformSelector
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
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
