//
//  CustomButton.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

CustomButton *cb = nil;
id delegate;

+ (id)initWithDelegate:(id)_delegate
{
    if (cb == nil) {
        cb = [[CustomButton alloc] init];
    }
    
    delegate = _delegate;
    
    return cb;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIButton *)makeButton:(CGRect)frame:(SEL)selector:(int)tag:(NSString *)imgName
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.exclusiveTouch = YES;
    btn.tag = tag;
    
    if (imgName!=nil) {
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    
    btn.backgroundColor = [UIColor clearColor];
    
    [btn addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
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
