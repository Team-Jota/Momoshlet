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
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    int indexCount = [[status objectForKey:@"dirty_level"]integerValue];
    
    effectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
    
    if(indexCount>=1){
        dirty1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty1.png"]];
        dirty1.frame = effectView.frame;
        [effectView addSubview:dirty1];
    }
    if(indexCount>=2){
        dirty2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty2.png"]];
        dirty2.frame = effectView.frame;
        [effectView addSubview:dirty2];
    }
    if(indexCount>=3){
        dirty3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty3.png"]];
        dirty3.frame = effectView.frame;
        [effectView addSubview:dirty3];
    }
    if(indexCount>=4){
        dirty4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty4.png"]];
        dirty4.frame = effectView.frame;
        [effectView addSubview:dirty4];
    }
    if(indexCount==5){
        dirty5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dirty5.png"]];
        dirty5.frame = effectView.frame;
        [effectView addSubview:dirty5];
    }
    
    [momoImg addSubview:effectView];
    
    dirty3.alpha = 0.2;
    NSLog(@"dirty1 coordinate:%f",dirty5.center.x);
}
    

- (void)washMomo
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    int indexCount = [[status objectForKey:@"dirty_level"]integerValue];
    
    if(indexCount>=1){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=2){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=3){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=4){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    if(indexCount>=5){
        if(dirty1.alpha==0){
            [self callRemoveWashletView];
        }
    }
    
    
    if((35<=translation.x)&&(translation.x<85)){
        
    }
    if((85<=translation.x)&&(translation.x<135)){
        
    }
    if((135<=translation.x)&&(translation.x<185)){
        
    }
    if((185<=translation.x)&&(translation.x<235)){
        
    }
    if((235<=translation.x)&&(translation.x<285)){
        
    }
}


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
