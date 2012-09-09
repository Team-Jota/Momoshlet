//
//  MomoAnimationView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/08.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "MomoAnimationView.h"
#define INTERVAL 1

@implementation MomoAnimationView

- (id)initWithMomoButton:(UIButton *)btn
{
    self = [super initWithFrame:btn.frame];
    if (self) {
        isAnimation = YES;
        saveData = [SaveData initSaveData];
        buttonSize = btn.frame.size;
        index = (btn.tag/10)-1;
        
        scaleView = [[UIView alloc] initWithFrame:btn.frame];
        scaleView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        [scaleView addSubview:btn];
        
        [self addSubview:scaleView];
    }
    return self;
}

- (void)animation4{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(statAniamtion)];
    
    self.center = CGPointMake(self.center.x+10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, -0.25);
    
    [UIView commitAnimations];
}

- (void)animation3{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animation4)];
    
    self.center = CGPointMake(self.center.x-10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, 0.25);
    
    [UIView commitAnimations];
}

- (void)animation2{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.01];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animation3)];
    
    self.center = CGPointMake(self.center.x-10, self.center.y);
    self.transform = CGAffineTransformRotate(self.transform, 0.25);
    
    [UIView commitAnimations];
}

- (void)statAniamtion{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationsEnabled:isAnimation];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animation2)];
    
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
    
    if (size < 1.0){
        scaleView.transform = CGAffineTransformMakeScale(0.25 + size, 0.25 + size);
        [self performSelector:@selector(growMomo) withObject:nil afterDelay:INTERVAL];
    }
    else {
        scaleView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
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
