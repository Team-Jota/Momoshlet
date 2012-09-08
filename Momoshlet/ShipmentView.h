//
//  ShipmentView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol ShipmentViewDelegate;

@interface ShipmentView : UIView{
    CustomButton *cb;
    id<ShipmentViewDelegate> delegate;
}

- (id)initWithDelegate:(id)_delegate;

@end

@protocol ShipmentViewDelegate
-(void)removeShipmentView;
@end
