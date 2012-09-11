//
//  MainViewController.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BreedView.h"
#import "MomoAnimationView.h"
#import "SaveData.h"

@interface MainViewController : UIViewController<BreedViewDelegate>{
    BreedView *breed;
    CustomButton *cb;
    SaveData *saveData;
    UIView *momoView;
    UIView *fadeView;
}

- (void) removeBreedView;
- (void)setMomoButton;
- (void)setBack;

@end