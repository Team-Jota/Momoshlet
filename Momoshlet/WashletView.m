//
//  WashletView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "WashletView.h"
#define maxSpeed 0.1

@implementation WashletView

@synthesize img;

- (id)initWithDelegate:(id)_delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor blackColor];
        
        currentSpeed = 0;
        
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
        img.frame = CGRectMake(50,50,100,100);
        [self addSubview:img];
        ballRadius = img.frame.size.width/2;
        delta = CGPointMake(12.0, 4.0);
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


-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    //NSLog(@"x: %g",acceleration.x);
    //NSLog(@"y: %g",acceleration.y);
    //NSLog(@"z: %g",acceleration.z);
    
    if(acceleration.x>0) delta.x=5;else delta.x=-5;
    if(acceleration.y>0) delta.y=-5;else delta.y=5;
    
    [UIView beginAnimations:@"translate" context:nil];
    img.transform =
    CGAffineTransformMakeTranslation(translation.x, translation.y);
    translation.x = translation.x + delta.x;
    translation.y = translation.y + delta.y;
    [UIView commitAnimations];
    
    if (img.center.x + translation.x > 320 - ballRadius ||
        img.center.x + translation.x < ballRadius) {
        translation.x -= delta.x;
    }
    if (img.center.y + translation.y > 460 - ballRadius ||
        img.center.y + translation.y < ballRadius) {
        translation.y -= delta.y;
    }
}

-(float) calcNewSpeed{
    
    
    
    return currentSpeed;
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
