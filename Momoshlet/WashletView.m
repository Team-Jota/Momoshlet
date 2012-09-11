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

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        saveData = [SaveData initSaveData];
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor blackColor];
        
        index = _index;
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveWashletView) :100 :nil];
        rmButton.backgroundColor = [UIColor blueColor];
        [self addSubview:rmButton];
        
        //桃
        momoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-1.png"]];
        momoImg.frame = CGRectMake(35, 30, 250, 250);
        [self addSubview:momoImg];
        
        //汚れの反映
        [self setStateEffect];
        
        //ノズル
        nozzleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
        nozzleImg.frame = CGRectMake(110,350,100,100);
        [self addSubview:nozzleImg];
        imgRadius = nozzleImg.frame.size.width/2;
        delta = CGPointMake(0.0, 0.0);
        translation = nozzleImg.center;
        
        UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
        accel.delegate = self;
        accel.updateInterval = 1.0f/60.0f;
    }
    return self;
}


- (void)setStateEffect
{
    //汚れUIImageViewの保管
    effectImg = [[UIImageView alloc]init];
    dirtyIVArray = [NSMutableArray array];
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    for (int i=1; i<=[[status objectForKey:@"dirty_level"]integerValue]; i++) {
        UIImageView *imgViewTmp = [[UIImageView alloc]initWithImage:
                                   [UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]]];
        imgViewTmp.frame = CGRectMake(0, 0, 250, 250);
        [dirtyIVArray insertObject:imgViewTmp atIndex:i-1];
        [effectImg addSubview:[dirtyIVArray objectAtIndex:i-1]];
    }
    effectImg.frame = CGRectMake(0,0,250,250);
    [momoImg addSubview:effectImg];
}

/*
- (void)washMomo
{
    for(int i=0;i<dirtyIVArray.count;i++){
        if((dirtyIVArray[i].center.x-50<translation.x)&&(translation.x<dirtyIVArray[i].center.x+50)){
        }
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
    
    //[UIView beginAnimations:@"translate" context:nil];
    //nozzleImg.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    nozzleImg.center = CGPointMake(translation.x , translation.y);
    //translation.x = translation.x + delta.x;
    //[UIView commitAnimations];
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
