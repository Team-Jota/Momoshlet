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
        
        momoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo_shade.png"]];
        momoImg.frame = CGRectMake(0, 0, 125, 100);
        momoImg.center = CGPointMake(160, 100);
        [self addSubview:momoImg];
        
        boxIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo_shade.png"]];
        boxIV.frame = CGRectMake(0, 0, 125, 100);
        boxIV.center = CGPointMake(-100,300);
        [self addSubview:boxIV];
        
        //最後消す
        displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 270, 30)];
        displayLabel.backgroundColor = [UIColor whiteColor];
        displayLabel.text=@"coordinate";
        [self addSubview:displayLabel];
        
        isAnimation = YES;
        [self animation];
    }
    
    return self;
}


- (void)animation{
    boxIV.center = CGPointMake(-100,300);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    
    if (isAnimation == YES)
        [UIView setAnimationDidStopSelector:@selector(animation)];
        
    boxIV.center = CGPointMake(420,300);
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self fallAnimation];
    CALayer *boxLayer = [boxIV.layer presentationLayer];
    if(140<boxLayer.position.x&&boxLayer.position.x<180){
        displayLabel.text = [NSString stringWithFormat:@"OK"];
        
        }else{
        displayLabel.text = [NSString stringWithFormat:@"OUT"];
    }
}

- (void)fallAnimation
{
    [UIView beginAnimations:nil context:nil];
    {
        momoImg.center = CGPointMake(160,100);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        momoImg.center = CGPointMake(160,300);
    }
}

- (void)resultView:(BOOL)flag
{
    if(flag)
        NSLog(@"a");
    else
        NSLog(@"b");
    
    resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    resultView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,0 , 100, 50)];
    [label setText:[NSString stringWithFormat:@"success"]];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(160,240,100, 50)];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(removeSuccessView) forControlEvents:UIControlEventTouchDown];
    
    [resultView addSubview:label];
    [resultView addSubview:btn];
    [self addSubview:resultView];
}


- (void)removeResultView{
    if(resultView){
        [resultView removeFromSuperview];
    }
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
