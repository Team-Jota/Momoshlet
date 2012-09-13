//
//  AppDelegate.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UITabBarItem *main;
    UITabBarItem *collection;
    BOOL hasChangedCollection;
}

@property (strong, nonatomic) UIWindow *window;

- (void)setTabBarItemMain:(UITabBarItem *)item;
- (void)setTabBarItemCollection:(UITabBarItem *)item;
- (void)tabBatItemMainEnabled:(BOOL)enabled;
- (void)tabBatItemCollectionEnabled:(BOOL)enabled;
- (void)setHasChangedCollection:(BOOL)flag;
- (BOOL)getHasChangedCollection;

@end
