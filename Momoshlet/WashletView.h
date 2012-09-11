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
    UIImageView *nozzleImg;
    
    UIImageView *dirty1;
    UIImageView *dirty2;
    UIImageView *dirty3;
    UIImageView *dirty4;
    UIImageView *dirty5;
    
    NSMutableArray *dirtyIVArray;
    
    CGPoint delta;
    CGPoint translation;
    float imgRadius;
    int index;
    
    BOOL isAnimation;
    int dirtyLevel;
}

@property(nonatomic,retain) UIImageView *nozzleImg;

-(id)initWithDelegate:(id)_delegate:(int)_index;

@end

@protocol WashletViewDelegate
- (void) removeWashletView;
@end
