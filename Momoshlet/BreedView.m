//
//  BreedView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "BreedView.h"

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
        
        dirtyView = nil;
        injuryView = nil;
        
        [self updateStatus];
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveBreedView) :100 :nil];
        rmButton.backgroundColor = [UIColor redColor];
        [self addSubview:rmButton];
        
                
        //ShipmentButton
        UIButton *shipmentBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :@selector(shipmentView:) :1000 :[NSString stringWithFormat:@"momo_shade.png"]];
        shipmentBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
        shipmentBtn.center = CGPointMake(180, 50);
        [self addSubview:shipmentBtn];
        
        //CatchBugButton
        UIButton *catchBugBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :nil :2000 :[NSString stringWithFormat:@"momo_shade.png"]];
        catchBugBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
        catchBugBtn.center = CGPointMake(100, 50);
        [self addSubview:catchBugBtn];
        
        //WashetButton
        UIButton *washletBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :nil :3000 :[NSString stringWithFormat:@"momo_shade.png"]];
        washletBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
        washletBtn.center = CGPointMake(50, 240);
        [self addSubview:washletBtn];
    }
    return self;
}

- (void)updateStatus
{
    NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
    if(0<[[status objectForKey:@"injury_level"]integerValue]||0<[[status objectForKey:@"dirty_level"]integerValue])
        momoIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-2.png"]];
    else
        momoIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"momo1-1.png"]];
    momoIV.transform = CGAffineTransformMakeScale(0.6, 0.6);
    momoIV.center = CGPointMake(200, 240);
    
    [self setDirtyView];
    [self setInjuryView];
    [self addSubview:momoIV];
}

- (void)setDirtyView
{
    if(dirtyView){
        [dirtyView removeFromSuperview];
        dirtyView = nil;
    }
    dirtyView = [[UIView alloc]init];
    NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
    for(int i=0;i<[[status objectForKey:@"dirty_level"]integerValue];i++){
        UIImageView *dirty = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:
                                                                                    @"dirty%d.png",i+1]]];
        [dirtyView addSubview:dirty];
    }
    [momoIV addSubview:dirtyView];
}

- (void)setInjuryView
{
    if(injuryView){
        [injuryView removeFromSuperview];
        injuryView = nil;
    }
    injuryView = [[UIView alloc]init];
    NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
    for(int i=0;i<[[status objectForKey:@"injury_level"]integerValue];i++){
        UIImageView *bug = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:
                                                                                  @"bug%d.png",i+1]]];
        [injuryView addSubview:bug];
    }
    [momoIV addSubview:injuryView];
}


- (void)shipmentView:(UIButton*)btn
{
    shipment = [[ShipmentView alloc]initWithDelegate:self];
    [self addSubview:shipment];
}

- (void)catchBugView:(UIButton*)btn
{
    
}

- (void)washletView:(UIButton*)btn
{
    
}



- (void)removeShipmentView{
    if(shipment){
        [shipment removeFromSuperview];
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
