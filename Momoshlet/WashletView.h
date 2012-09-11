//
//  WashletView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"


@protocol WashletViewDelegate;

@interface WashletView : UIView <UIAccelerometerDelegate>{
    CustomButton *cb;
    id<WashletViewDelegate> delegate;
    
    UIImageView *img;
    CGPoint delta;
    CGPoint translation;
    float ballRadius;
    
    
    float currentSpeed;
}

@property(nonatomic,retain) UIImageView *img;

-(id)initWithDelegate:(id)_delegate;

@end

@protocol WashletViewDelegate
- (void) removeWashletView;
@end
