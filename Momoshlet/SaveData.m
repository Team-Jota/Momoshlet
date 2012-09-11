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
            [dic setValue:[NSNumber numberWithFloat:0.03] forKey:@"hours"];
            [dic setValue:[NSDate date] forKey:@"created_at"];
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_resistance"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_resistance"];//5段階
            
            [statusArray addObject:dic];
        }
        
        [self saveSaveData:STATUS];
    }
}

- (void)makeNewMomo:(int)index
{
    //[statusArray insertObject:nil atIndex:index];
    
    int random1 = rand()%5 + 1;
    int random2 = rand()%10;
    
    int number = 100;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInt:100*number] forKey:@"id"];
    [dic setValue:[NSNumber numberWithFloat:0.5] forKey:@"hours"];
    [dic setValue:[NSDate date] forKey:@"created_at"];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
    
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_resistance"];//5段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_resistance"];//5段階
    
    //[statusArray insertObject:dic atIndex:index];
    [statusArray replaceObjectAtIndex:index withObject:dic];
    
    [self saveSaveData:STATUS];
}

- (void)countUpInjuryLevel:(NSNumber *)number
{
    int index = [number intValue];
    
    @synchronized(self){
        NSMutableDictionary *dic = [statusArray objectAtIndex:index];
        int injury_level = [[dic objectForKey:@"injury_level"] intValue];
    
        if (injury_level < 5){
            injury_level++;
    
            [dic setValue:[NSNumber numberWithInt:injury_level] forKey:@"injury_level"];
            [statusArray replaceObjectAtIndex:index withObject:dic];
    
            [self saveSaveData:STATUS];
        }
    
        NSLog(@"index = %d, injury_level = %d",index, [[[statusArray objectAtIndex:index] objectForKey:@"injury_level"] intValue]);
    }
}

- (void)countUpDirtyLevel:(NSNumber *)number
{
    int index = [number intValue];
    
    @synchronized(self){
        NSMutableDictionary *dic = [statusArray objectAtIndex:index];
        int dirty_level = [[dic objectForKey:@"dirty_level"] intValue];
    
        if (dirty_level < 5){
            dirty_level++;
    
            [dic setValue:[NSNumber numberWithInt:dirty_level] forKey:@"dirty_level"];
            [statusArray replaceObjectAtIndex:index withObject:dic];
    
            [self saveSaveData:STATUS];
        }
    
        NSLog(@"index = %d, dirty_level = %d",index ,[[[statusArray objectAtIndex:index] objectForKey:@"dirty_level"] intValue]);
    }
}

@end