//
//  WashletView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveData.h"
#import "CustomButton.h"
#import <AVFoundation/AVFoundation.h>

@protocol WashletViewDelegate;

@interface WashletView : UIView <UIAccelerometerDelegate>{
    SaveData *saveData;
    CustomButton *cb;
    id<WashletViewDelegate> delegate;
    
    UIView *momoView;
    UIImageView *momoHitImg;
    UIImageView *momoNotHitImg;
    
    UIView *moveView;
    UIImageView *waterView;
    //UIImageView *nozzleImg;
    
    UIImageView *dirty1;
    UIImageView *dirty2;
    UIImageView *dirty3;
    UIImageView *dirty4;
    UIImageView *dirty5;
    
    NSMutableArray *dirtyIVArray;
    
    CGPoint delta;
    CGPoint translation;
    CGPoint waterPoint;
    float imgRadius;
    int index;
    
    int dirtyLevel;
    BOOL isAnimation;
    BOOL isWaterAnimation;
    BOOL isFinish;
    BOOL isAccelerometer;
    
    AVAudioPlayer *start;
    AVAudioPlayer *washing;
    AVAudioPlayer *end;
    AVAudioPlayer *junny;
}

-(id)initWithDelegate:(id)_delegate:(int)_index;
- (void)startWashlet;

@end

@protocol WashletViewDelegate
- (void) removeWashletView;
@end
