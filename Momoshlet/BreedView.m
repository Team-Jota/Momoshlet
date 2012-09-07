//
//  BreedView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "BreedView.h"

@implementation BreedView

BreedView *bv = nil;
id delegate;

+ (id)initWithDelegate:(id)_delegate
{
    if (bv == nil) {
        bv = [[BreedView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    
    delegate = _delegate;
    
    return bv;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)callRemoveBreedView{
    //[delegate ]
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
