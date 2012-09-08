//
//  MomoAnimationView.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/08.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomoAnimationView : UIView{
    BOOL isAnimation;
}

- (id)initWithMomoButton:(UIButton *)btn;
- (void)statAniamtion;
- (void)stopAniamtion;

@end
