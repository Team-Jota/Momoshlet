//
//  ShipmentView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "ShipmentView.h"

@implementation ShipmentView


- (id)initWithDelegate:(id)_delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if (self) {
        cb = [CustomButton initWithDelegate:self];
        
        delegate =_delegate;
        
        self.backgroundColor = [UIColor blueColor];
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveShipmentView) :100 :nil];
        rmButton.backgroundColor = [UIColor redColor];
        [self addSubview:rmButton];
        
        boxIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo_shade.png"]];
        boxIV.frame = CGRectMake(0, 0, 125, 100);
        boxIV.center = CGPointMake(-100,300);
        
        CALayer *layer;
        layer = boxIV.layer;
        
        displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 270, 30)];
        displayLabel.backgroundColor = [UIColor whiteColor];
        displayLabel.text=@"coordinate";
        
        [self addSubview:boxIV];
        [self addSubview:displayLabel];
        
        isAnimation = YES;
        [self animation];
    }
    
    return self;
}

- (void)animation{
    boxIV.center = CGPointMake(-100,300);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    if (isAnimation == YES)
        [UIView setAnimationDidStopSelector:@selector(animation)];
    
    displayLabel.text = [NSString stringWithFormat:@"x:%f,y:%f",boxIV.layer];
    
    boxIV.center = CGPointMake(420,300);
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
