//
//  MomoAnimationView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/08.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "MomoAnimationView.h"

@implementation MomoAnimationView

- (id)initWithMomoButton:(UIButton *)btn
{
    self = [super initWithFrame:btn.frame];
    if (self) {
        isAnimation = YES;
        [self addSubview:btn];
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
    self.transform = CGAffineTransformMakeRotation(0.0);
    
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
    self.transform = CGAffineTransformMakeRotation(0.25);
    
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
    self.transform = CGAffineTransformMakeRotation(0.0);
    
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
    self.transform = CGAffineTransformMakeRotation(-0.25);
    
    [UIView commitAnimations];
}

- (void)stopAniamtion{
    isAnimation = NO;
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
