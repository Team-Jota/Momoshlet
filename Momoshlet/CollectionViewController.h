//
//  CollectionViewController.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "SaveData.h"

@interface CollectionViewController : UIViewController <UIScrollViewDelegate>{
    CustomButton *cb;
    SaveData *saveData;
    UIView *detail;
    UILabel *pageLagel;
    UIView *stage;
    int page;
    int pages;
    float scrollXPoint;
}

- (void)makeScrollView;

@end
