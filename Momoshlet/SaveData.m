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

@implementation SaveData

@synthesize collectionArray;
@synthesize statusArray;

SaveData *saveData = nil;

const int nomal = 0;
const int dry = 1;
const int wet = 2;
const int injury = 3;

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
    
    [nud synchronize];
}

- (void)loadSaveData
{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
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
            NSDictionary *dic = [[NSDictionary alloc] init];
            [dic setValue:[NSNumber numberWithInt:nomal] forKey:@"status"];
            [dic setValue:[NSDate date] forKey:@"created_at"];
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"injury"];
            [dic setValue:[NSNumber numberWithInt:5] forKey:@"moisture"];
            [dic setValue:[NSNumber numberWithInt:0] forKey:@"dirty"];
            
            [statusArray addObject:dic];
        }
        
        [self saveSaveData:STATUS];
    }
}

@end
