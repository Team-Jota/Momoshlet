//
//  BreedView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveData.h"
#import "ShipmentView.h"
#import "CatchBugView.h"
#import "WashletView.h"
#import "CustomButton.h"

@protocol BreedViewDelegate;

@interface BreedView : UIView<ShipmentViewDelegate>{
    SaveData *saveData;
    UIImageView *momoIV;
    UIImageView *effectView;
    ShipmentView *shipment;
    CatchBugView *catchBug;
    WashletView *washlet;
    CustomButton *cb;
    id<BreedViewDelegate> delegate;
    int index;
    
    UIButton *shipmentBtn;
    UIButton *washletBtn;
    UIButton *catchBugBtn;
}

- (id)initWithDelegate:(id)_delegate:(int)_index;
- (void)updateStatus;

@end

@protocol BreedViewDelegate
- (void)removeBreedView;
- (void)resetMomoButton:(int)index;
@end