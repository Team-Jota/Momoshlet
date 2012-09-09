//
//  BreedView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipmentView.h"
#import "CustomButton.h"

@protocol BreedViewDelegate;

@interface BreedView : UIView<ShipmentViewDelegate>{
    ShipmentView *shipment;
    CustomButton *cb;
    id<BreedViewDelegate> delegate;
    int index;
}

- (id)initWithDelegate:(id)_delegate:(int)_index;

@end

@protocol BreedViewDelegate
- (void) removeBreedView;
@end