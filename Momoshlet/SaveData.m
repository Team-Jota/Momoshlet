//
//  SaveData.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "SaveData.h"
#import "AppDelegate.h"

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
            [dic setValue:[NSNumber numberWithFloat:(float)(i+1)/30] forKey:@"hours"];
            [dic setValue:[NSDate date] forKey:@"created_at"];
            [dic setValue:[NSNumber numberWithInt:2] forKey:@"injury_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:2] forKey:@"dirty_level"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_resistance"];//5段階
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_resistance"];//5段階
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"dirty_zero"];
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"injury_zero"];
            
            [statusArray addObject:dic];
        }
        
        [self saveSaveData:STATUS];
    }
}

- (void)setNewMomo:(int)index
{
    
    int random = arc4random()%1128 + 1;
    int momo_id = 100;
    int injury_resistance = 0;
    int dirty_resistance = 0;
    float time = arc4random()%1 + ((float)(arc4random()%6) / 6);
    
    if (random>500 && random<=800) {
        momo_id = 200;
        injury_resistance = 1;
        dirty_resistance = 5;
    }
    else if (random>800 && random<=950) {
        momo_id = 300;
        injury_resistance = 2;
        dirty_resistance = 1;
    }
    else if (random>950 && random<=1050) {
        momo_id = 400;
        injury_resistance = 5;
        dirty_resistance = 5;
    }
    else if (random>1050 && random<=1125) {
        momo_id = 500;
        injury_resistance = 5;
        dirty_resistance = 0;
    }
    else if (random>1125 && random<=1128) {
        momo_id = 600;
        injury_resistance = 2;
        dirty_resistance = 2;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInt:momo_id] forKey:@"id"];
    [dic setValue:[NSNumber numberWithFloat:time] forKey:@"hours"];
    [dic setValue:[NSDate date] forKey:@"created_at"];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
    [dic setValue:[NSNumber numberWithInt:injury_resistance] forKey:@"injury_resistance"];//5段階
    [dic setValue:[NSNumber numberWithInt:dirty_resistance] forKey:@"dirty_resistance"];//5段階
    [dic setValue:[NSNumber numberWithBool:NO] forKey:@"dirty_zero"];
    [dic setValue:[NSNumber numberWithBool:NO] forKey:@"injury_zero"];
    
    [statusArray replaceObjectAtIndex:index withObject:dic];
    
    [self saveSaveData:STATUS];
}

- (void)countUpInjuryLevel:(NSNumber *)number
{
    //@synchronized(self){
        int index = [number intValue];
    
        NSMutableDictionary *dic = [statusArray objectAtIndex:index];
        int injury_level = [[dic objectForKey:@"injury_level"] intValue];
    
        if (injury_level < 5){
            injury_level++;
    
            [dic setValue:[NSNumber numberWithInt:injury_level] forKey:@"injury_level"];
            [statusArray replaceObjectAtIndex:index withObject:dic];
    
            [self saveSaveData:STATUS];
        }
    //}
}

- (void)countUpDirtyLevel:(NSNumber *)number
{
    //@synchronized(self){
        int index = [number intValue];
    
        NSMutableDictionary *dic = [statusArray objectAtIndex:index];
        int dirty_level = [[dic objectForKey:@"dirty_level"] intValue];
    
        if (dirty_level < 5){
            dirty_level++;
    
            [dic setValue:[NSNumber numberWithInt:dirty_level] forKey:@"dirty_level"];
            [statusArray replaceObjectAtIndex:index withObject:dic];
    
            [self saveSaveData:STATUS];
        }
    //}
}

- (void)resetDirty:(int)index
{
    NSMutableDictionary *dic = [statusArray objectAtIndex:index];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty_level"];//5段階
    
    [statusArray replaceObjectAtIndex:index withObject:dic];
    
    [self saveSaveData:STATUS];
}

- (void)resetInjury:(int)index
{
    NSMutableDictionary *dic = [statusArray objectAtIndex:index];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury_level"];//5段階
    
    [statusArray replaceObjectAtIndex:index withObject:dic];
    
    [self saveSaveData:STATUS];
}

- (void)setHeaven:(int)_index:(BOOL)_dirty_zero:(BOOL)_injury_zero
{
    NSMutableDictionary *dic = [statusArray objectAtIndex:_index];
    
    [dic setValue:[NSNumber numberWithBool:_dirty_zero] forKey:@"dirty_zero"];
    [dic setValue:[NSNumber numberWithBool:_injury_zero] forKey:@"injury_zero"];
    
    [statusArray replaceObjectAtIndex:_index withObject:dic];
    
    [self saveSaveData:STATUS];
}

- (void)addCollection:(int)_index
{
    NSDictionary *dic = [statusArray objectAtIndex:_index];
    
    int c_index = ([[dic objectForKey:@"id"] intValue]/100 - 1) * 5;
    int dirty_level = [[dic objectForKey:@"dirty_level"] intValue];
    int injury_level = [[dic objectForKey:@"injury_level"] intValue];
    BOOL dirty_zero = [[dic objectForKey:@"dirty_zero"] boolValue];
    BOOL injury_zero = [[dic objectForKey:@"injury_zero"] boolValue];
    
    if (injury_level==0 && dirty_level==0){
        if (injury_zero==YES && dirty_zero==YES) {
            c_index += 4;
        }
        else {
            c_index += 0;
        }
    }
    else if (injury_level==5 && dirty_level==5) {
        c_index += 3;
    }
    else if (dirty_level >= injury_level) {
        c_index += 1;
    }
    else {
        c_index += 2;
    }
    
    BOOL isCollection = [[collectionArray objectAtIndex:c_index] boolValue];

    if (isCollection==NO) {
        isCollection = YES;
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app setHasChangedCollection:YES];
        
        [collectionArray replaceObjectAtIndex:c_index withObject:[NSNumber numberWithBool:isCollection]];
        [self saveSaveData:COLLECTION];
    }
}

@end