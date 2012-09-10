//
//  MomoAnimationView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/08.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveData.h"

@interface MomoAnimationView : UIView{
    BOOL isAnimation;
    SaveData *saveData;
    UIView *scaleView;
    UIImageView *stateEffectView;
    int index;
    UIButton *button;
}

- (id)initWithMomoButton:(UIButton *)btn;
- (void)statAniamtion;
- (void)stopAniamtion;
- (void)growMomo;
- (void)setStateEffect;
- (void)calucDirtyState;
- (void)calucInjuryState;

@end
