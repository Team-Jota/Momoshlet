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
    
    UIImageView *momoImg;
    UIImageView *boxIV;
    UILabel *displayLabel;
    UIView *resultView;
    BOOL isAnimation;
}

- (id)initWithDelegate:(id)_delegate;
- (void)animation;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@protocol ShipmentViewDelegate
-(void)removeShipmentView;
@end
