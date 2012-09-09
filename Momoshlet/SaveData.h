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
}

@property (readonly, retain) NSMutableArray *collectionArray;
@property (readonly, retain) NSMutableArray *statusArray;
@property (readonly) int money;

+ (id)initSaveData;
- (void)loadSaveData;

@end
