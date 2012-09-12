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
    saveData = [SaveData initSaveData];
    
    if (self){
        cb = [CustomButton initWithDelegate:self];
        
        self.backgroundColor = [UIColor brownColor];
        
        delegate = _delegate;
        index = _index;
        
        catchBug = nil;
        shipment = nil;
        washlet = nil;
        effectView = nil;
        
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"breedtree.png"]];
        bgImg.frame = CGRectMake(0, 0, 320, 480);
        [self addSubview:bgImg];
        
        [self updateStatus];
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 200, 50, 50) :@selector(callRemoveBreedView) :100 :nil];
        rmButton.backgroundColor = [UIColor redColor];
        [self addSubview:rmButton];
        
        //TODO 修正する
        //ShipmentButton
        UIButton *shipmentBtn = [cb makeButton:CGRectMake(100, 200, 50, 50) :@selector(shipmentView:) :1000 :[NSString stringWithFormat:@"momo_shade.png"]];
        [self addSubview:shipmentBtn];
        
        //CatchBugButton
        UIButton *catchBugBtn = [cb makeButton:CGRectMake(0, 280, 50, 50) :@selector(catchBugView:) :2000 :[NSString stringWithFormat:@"momo_shade.png"]];
        [self addSubview:catchBugBtn];
        
        //WashetButton
        UIButton *washletBtn = [cb makeButton:CGRectMake(100, 280, 50, 50) :@selector(washletView:) :3000 :[NSString stringWithFormat:@"momo_shade.png"]];
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
    if(0<[[status objectForKey:@"injury_level"] intValue] || 0<[[status objectForKey:@"dirty_level"] intValue]) {
        momoIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
    }
    else {
        momoIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-1.png"]];
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
    
    for (int i=1; i<=[[status objectForKey:@"dirty_level"] intValue]; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }

    for (int i=1; i<=[[status objectForKey:@"injury_level"] intValue]; i++) {
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
    shipment = [[ShipmentView alloc]initWithDelegate:self];
    [self addSubview:shipment];
}

- (void)catchBugView:(UIButton*)btn
{
    catchBug = [[CatchBugView alloc]initWithDelegate:self:index];
    [self addSubview:catchBug];
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
