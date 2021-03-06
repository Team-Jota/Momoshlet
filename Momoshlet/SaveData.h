//
//  SaveData.h
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveData : NSObject {
    NSMutableArray *collectionArray;
    NSMutableArray *statusArray;
    int money;
    BOOL tutorial;
}

@property (readonly, retain) NSMutableArray *collectionArray;
@property (readonly, retain) NSMutableArray *statusArray;
@property (readonly) int money;
@property (readonly) BOOL tutorial;

+ (id)initSaveData;
- (void)loadSaveData;
- (void)countUpInjuryLevel:(NSNumber *)number;
- (void)countUpDirtyLevel:(NSNumber *)number;
- (void)resetDirty:(int)_index;
- (void)resetInjury:(int)index;
- (void)setNewMomo:(int)index;
- (void)setHeaven:(int)_index:(BOOL)_dirty_zero:(BOOL)_injury_zero;
- (void)addCollection:(int)_index;
- (void)updateInjury:(int)_index;
- (void)updateDirty:(int)_index;
- (void)tutorialOff;

@end
