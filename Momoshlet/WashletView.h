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
    
    UIImageView *momoImg;
    UIImageView *effectImg;
    UIImageView *nozzleImg;
    CGPoint delta;
    CGPoint translation;
    float imgRadius;
    int index;
}

@property(nonatomic,retain) UIImageView *nozzleImg;

-(id)initWithDelegate:(id)_delegate:(int)_index;

@end

@protocol WashletViewDelegate
- (void) removeWashletView;
@end
