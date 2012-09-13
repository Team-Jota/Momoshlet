//
//  BreedView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "BreedView.h"
#import "AppDelegate.h"

@implementation BreedView

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if (self){
        cb = [CustomButton initWithDelegate:self];
        saveData = [SaveData initSaveData];
        
        delegate = _delegate;
        index = _index;
        
        catchBug = nil;
        shipment = nil;
        washlet = nil;
        effectView = nil;
        
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"breedtree2.png"]];
        bgImg.frame = CGRectMake(0, 0, 320, 480);
        [self addSubview:bgImg];
        
        
        //ShipmentButton
        shipmentBtn = [cb makeButton:CGRectMake(100, 275, 50, 50) :@selector(shipmentView:) :1000 :[NSString stringWithFormat:@"button2.png"]];
        
        //CatchBugButton
        catchBugBtn = [cb makeButton:CGRectMake(25, 335, 50, 50) :@selector(catchBugView:) :2000 :[NSString stringWithFormat:@"button1.png"]];
        
        //WashetButton
        washletBtn = [cb makeButton:CGRectMake(100, 335, 50, 50) :@selector(washletView:) :3000 :[NSString stringWithFormat:@"button3.png"]];
        
        [self updateStatus];
        
        UIButton *rmButton = [cb makeButton:CGRectMake(25, 275, 50, 50) :@selector(callRemoveBreedView) :100 :@"button4.png"];
        [self addSubview:rmButton];
        
        [self addSubview:shipmentBtn];
        [self addSubview:catchBugBtn];
        [self addSubview:washletBtn];
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app tabBatItemCollectionEnabled:NO];
    
    return self;
}


- (void)updateStatus
{
    if(momoIV){
        [momoIV removeFromSuperview];
        momoIV = nil;
    }
    
    NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
    if ([[status objectForKey:@"injury_zero"] boolValue]==YES && [[status objectForKey:@"dirty_zero"] boolValue]==YES) {
        momoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-3.png",[[status objectForKey:@"id"] intValue]/100]]];
    }
    else if(0<[[status objectForKey:@"injury_level"] intValue] || 0<[[status objectForKey:@"dirty_level"] intValue]) {
        momoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-2.png",[[status objectForKey:@"id"] intValue]/100]]];
    }
    else {
        momoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-1.png",[[status objectForKey:@"id"] intValue]/100]]];
    }
    
    momoIV.frame = CGRectMake(0,0,250,250);
    momoIV.center = CGPointMake(160, momoIV.center.y-20);
    
    [self setStateEffect];
    [self addSubview:momoIV];
}


- (void)setStateEffect
{
    if (effectView) {
        [effectView removeFromSuperview];
        effectView = nil;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(400, 400));
    
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    int dirty_level = [[status objectForKey:@"dirty_level"] intValue];
    int injury_level = [[status objectForKey:@"injury_level"] intValue];
    float since = [[NSDate date] timeIntervalSinceDate:[status objectForKey:@"created_at"]];
    float finishTime = [[status objectForKey:@"hours"] floatValue]*60*60;
    float size = since / finishTime;
    
    if (size >= 1.0) {
        shipmentBtn.enabled = YES;
    }
    else {
        shipmentBtn.enabled = NO;
    }
    
    if (dirty_level > 0) {
        washletBtn.enabled = YES;
    }
    else {
        washletBtn.enabled = NO;
    }
    
    if (injury_level > 0) {
        catchBugBtn.enabled = YES;
    }
    else {
        catchBugBtn.enabled = NO;
    }
    
    for (int i=1; i<=dirty_level; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }

    for (int i=1; i<=injury_level; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"bug%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    effectView = [[UIImageView alloc] initWithImage:img];
    effectView.frame = CGRectMake(0, 0, 250, 250);
    
    [momoIV addSubview:effectView];
}


- (void)shipmentView:(UIButton*)btn
{
    shipment = [[ShipmentView alloc]initWithDelegate:self:index];
    [self addSubview:shipment];
    [shipment startShipment];
}

- (void)catchBugView:(UIButton*)btn
{
    catchBug = [[CatchBugView alloc]initWithDelegate:self:index];
    [self addSubview:catchBug];
    [catchBug startCatchBug];
}

- (void)washletView:(UIButton*)btn
{
    washlet = [[WashletView alloc]initWithDelegate:self:index];
    [self addSubview:washlet];
    [washlet startWashlet];
}


- (void)removeShipmentView{
    if(shipment){
        [shipment removeFromSuperview];
        shipment = nil;
        [delegate resetMomoButton:index];
        [self callRemoveBreedView];
    }
}

- (void)removeCatchBugView{
    if(catchBug){
        [self updateStatus];
        [delegate resetMomoButton:index];
        [catchBug removeFromSuperview];
        catchBug = nil;
    }
}

- (void)removeWashletView{
    if(washlet){
        [self updateStatus];
        [delegate resetMomoButton:index];
        [washlet removeFromSuperview];
        washlet = nil;
    }
}

- (void)callRemoveBreedView{
    [delegate removeBreedView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
