//
//  CustomButton.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

+ (id)initWithDelegate:(id)_delegate;
- (UIButton *)makeButton:(CGRect)frame:(SEL)selector:(int)tag:(NSString *)imgName;

@end
