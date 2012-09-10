//
//  CatchBugView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol CatchBugViewDelegate;

@interface CatchBugView : UIView{
    CustomButton *cb;
    id<CatchBugViewDelegate> delegate;
}

-(id)initWithDelegate:(id)_delegate;

@end

@protocol CatchBugViewDelegate
- (void) removeCatchBugView;
@end