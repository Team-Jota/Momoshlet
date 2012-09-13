//
//  CatchBugView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "SaveData.h"
#import <AVFoundation/AVFoundation.h>

@protocol CatchBugViewDelegate;

@interface CatchBugView : UIView{
    CustomButton *cb;
    SaveData *saveData;
    int index;
    id<CatchBugViewDelegate> delegate;
    UIView *momoView;
    
    UIImageView *spray;
    UIView *sprayView;
    CGPoint sprayPoint;
    
    UIImageView *injury1;
    UIImageView *injury2;
    UIImageView *injury3;
    UIImageView *injury4;
    UIImageView *injury5;
    
    UIImageView *mist;
    CGPoint mistPoint;
    UIImageView *momoImg;
    UIImageView *momoImg2;
    
    int selectedInjury;
    int injury_level;
    
    BOOL isMoveMist;
    
    AVAudioPlayer *sprayAudio;
}

-(id)initWithDelegate:(id)_delegate:(int)_index;
- (void)startCatchBug;

@end

@protocol CatchBugViewDelegate
- (void) removeCatchBugView;
@end