//
//  ShipmentView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "ShipmentView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShipmentView

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if (self) {
        cb = [CustomButton initWithDelegate:self];
        saveData = [SaveData initSaveData];
        delegate =_delegate;
        index = _index;

        isAnimation = YES;
        
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"breedtree.png"]];
        bgImg.frame = CGRectMake(0, 0, 320, 480);
        [self addSubview:bgImg];

        beltImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"belt.png"]];
        beltImg.frame = CGRectMake(-20, 294, 340, 50);
        beltPoint = beltImg.center;
        [self addSubview:beltImg];
        [self beltAnimation];
        
        moveStage = [[UIView alloc] initWithFrame:CGRectMake(-150, 250, 150, 75)];
        [self addSubview:moveStage];
        
        UIImageView *bb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box_back.png"]];
        bb.frame = CGRectMake(0, 0, 150, 75);
        [moveStage addSubview:bb];
        
        NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
        UIGraphicsBeginImageContext(CGSizeMake(400, 400));
        if(0<[[status objectForKey:@"injury_level"] intValue] || 0<[[status objectForKey:@"dirty_level"] intValue]) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-2.png",[[status objectForKey:@"id"] intValue]/100]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        else {
            [[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-1.png",[[status objectForKey:@"id"] intValue]/100]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        for (int i=1; i<=[[status objectForKey:@"dirty_level"] integerValue]; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        for (int i=1; i<=[[status objectForKey:@"injury_level"] integerValue]; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"bug%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        momoImg = [[UIImageView alloc] initWithImage:img];
        momoImg.frame = CGRectMake(0, 0, 150, 150);
        momoImg.center = CGPointMake(158, -600);
        momoPoint = CGPointMake(75, 20);
        [moveStage addSubview:momoImg];
        
        UIImageView *bf = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box_front.png"]];
        bf.frame = CGRectMake(0, 0, 150, 75);
        [moveStage addSubview:bf];
    }
    
    return self;
}

- (void)startShipment
{
    [saveData addCollection:index];
    [saveData setNewMomo:index];
    
    [self boxGoToCenter];
    [self fallAnimation];
}

- (void)beltAnimation
{
    beltImg.center = beltPoint;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(beltAnimation)];
    }
    
    beltImg.center = CGPointMake(beltPoint.x+20, beltPoint.y);
    
    [UIView commitAnimations];
}

- (void)boxGoOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:2.9375];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(endAniamtion)];
    }
    
    moveStage.center = CGPointMake(moveStage.center.x+235, moveStage.center.y);
    
    [UIView commitAnimations];
}

- (void)endAniamtion
{
    [self performSelector:@selector(callRemoveShipmentView) withObject:nil afterDelay:2.0];
}

- (void)boxGoToCenter
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:2.9375];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(boxGoOut)];
    }
    
    moveStage.center = CGPointMake(moveStage.center.x+235, moveStage.center.y);
    
    [UIView commitAnimations];
}

-(void)bound4
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    
    momoImg.center = CGPointMake(momoImg.center.x, momoImg.center.y+15);
    
    [UIView commitAnimations];
}

-(void)bound3
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(bound4)];
    }
    
    momoImg.center = CGPointMake(momoImg.center.x, momoImg.center.y-15);
    
    [UIView commitAnimations];
}

-(void)bound2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
     [UIView setAnimationDidStopSelector:@selector(bound3)];
    }
    
    momoImg.center = CGPointMake(momoImg.center.x, momoImg.center.y+30);
    
    [UIView commitAnimations];
}

-(void)bound1
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
     [UIView setAnimationDidStopSelector:@selector(bound2)];
    }
    
    momoImg.center = CGPointMake(momoImg.center.x, momoImg.center.y-30);
    
    [UIView commitAnimations];
}

- (void)fallAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:2.9];
    [UIView setAnimationDuration:1.0375];
    [UIView setAnimationDelegate:self];
    if (isAnimation) {
        [UIView setAnimationDidStopSelector:@selector(bound1)];
    }
    
    momoImg.center = momoPoint;
    
    [UIView commitAnimations];
}

-(void)callRemoveShipmentView
{
    isAnimation = NO;
    [delegate removeShipmentView];
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
