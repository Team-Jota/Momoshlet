//
//  SaveData.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "SaveData.h"

#define COLLECTION 0
#define STATUS 1
#define MONEY 2

@implementation SaveData

@synthesize collectionArray;
@synthesize statusArray;
@synthesize money;

SaveData *saveData = nil;

+ (id)initSaveData
{
    if (saveData == nil) {
        saveData = [[SaveData alloc] init];
    }
    
    return saveData;
}

- (void)saveSaveData:(int)status
{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
    if (status==COLLECTION) {
        [nud setObject:collectionArray forKey:@"collection"];
    }
    else if (status==STATUS){
        [nud setObject:statusArray forKey:@"status"];
    }
    else if (status==MONEY){
        [nud setObject:[NSNumber numberWithInt:money] forKey:@"money"];
    }
    
    [nud synchronize];
}

- (void)loadSaveData
{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
    if ([nud objectForKey:@"money"]!=NULL) {
        money = [[nud objectForKey:@"money"] intValue];
    }
    else {
        money = 1000;
        
        [self saveSaveData:MONEY];
    }
    
    if ([nud objectForKey:@"collection"]!=NULL) {
        collectionArray = [[NSMutableArray alloc] initWithArray:[nud objectForKey:@"collection"]];
    }
    else {
        collectionArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<30; i++) {
            [collectionArray addObject:[NSNumber numberWithBool:NO]];
        }
        
        [self saveSaveData:COLLECTION];
    }
    
    if ([nud objectForKey:@"status"]!=NULL) {
        statusArray = [[NSMutableArray alloc] initWithArray:[nud objectForKey:@"status"]];
    }
    else {
        statusArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<6; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[NSNumber numberWithInt:100] forKey:@"id"];
            [dic setValue:[NSNumber numberWithFloat:0.5] forKey:@"hours"];
            [dic setValue:[NSDate date] forKey:@"created_at"];
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:5] forKey:@"moisture_level"];//10段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_resistance"];//5段階
            [dic setValue:[NSNumber numberWithInt:5] forKey:@"moisture_resistance"];//10段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_resistance"];//5段階
            
            [statusArray addObject:dic];
        }
        
        [self saveSaveData:STATUS];
    }
}

- (void)makeNewMomo:(int)index
{
    [statusArray insertObject:nil atIndex:index];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInt:100] forKey:@"id"];
    [dic setValue:[NSNumber numberWithFloat:0.5] forKey:@"hours"];
    [dic setValue:[NSDate date] forKey:@"created_at"];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
    [dic setValue:[NSNumber numberWithInt:5] forKey:@"moisture_level"];//10段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_resistance"];//5段階
    [dic setValue:[NSNumber numberWithInt:5] forKey:@"moisture_resistance"];//10段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_resistance"];//5段階
    
    [statusArray insertObject:dic atIndex:index];
    
    [self saveSaveData:STATUS];
}

@end