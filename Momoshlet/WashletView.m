//
//  WashletView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "WashletView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WashletView

@synthesize nozzleImg;

- (id)initWithDelegate:(id)_delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor blackColor];
        
        currentSpeed = 0;
        
        nozzleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
        nozzleImg.frame = CGRectMake(110,350,100,100);
        [self addSubview:nozzleImg];
        imgRadius = nozzleImg.frame.size.width/2;
        
        delta = CGPointMake(0.0, 0.0);
        translation = CGPointMake(0.0, 0.0);
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveWashletView) :100 :nil];
        rmButton.backgroundColor = [UIColor blueColor];
        [self addSubview:rmButton];
        
        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 1.0f/60.0f;
    }
    return self;
}


- (void)judge:(float)imgCenter{
    
}




- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    //delta.x = 30 * acceleration.x;
    
    if(nozzleImg.center.x==320-imgRadius||nozzleImg.center.x==imgRadius){
        delta.x = 0;
        //NSLog(@"Reset");
    }else if((-30<=delta.x)&(delta.x<=30)){
        delta.x += acceleration.x*2;
        //NSLog(@"currentSpeed : %f : %f",delta.x,nozzleImgLayer.position.x);
    }else if(delta.x<-30){
        delta.x = -30;
        //NSLog(@"currentSpeed : %f : %f",delta.x,nozzleImgLayer.position.x);
    }else{
        delta.x = 30;
        //NSLog(@"currentSpeed : %f : %f",delta.x,nozzleImgLayer.position.x);
    }
    
    [UIView beginAnimations:@"translate" context:nil];
    nozzleImg.transform =
    CGAffineTransformMakeTranslation(translation.x, translation.y);
    translation.x = translation.x + delta.x;
    [UIView commitAnimations];
    
    if (nozzleImg.center.x + translation.x > 320 - imgRadius ||
        nozzleImg.center.x + translation.x < imgRadius) {
        translation.x -= delta.x;
    }
}

- (void)callRemoveWashletView
{
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
