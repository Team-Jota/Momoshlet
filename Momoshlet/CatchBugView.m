//
//  CatchBugView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CatchBugView.h"

@implementation CatchBugView

- (id)initWithDelegate:(id)_delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if(self){
        cb = [CustomButton initWithDelegate:self];
        delegate = _delegate;
        self.backgroundColor = [UIColor blackColor];

        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveCatchBugView) :100 :nil];
        rmButton.backgroundColor = [UIColor blueColor];
        [self addSubview:rmButton];
    }
    return self;
}


- (void) callRemoveCatchBugView
{
    [delegate removeCatchBugView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
