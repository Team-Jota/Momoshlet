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
        
        effectView = nil;
        
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
        UIButton *catchBugBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :@selector(catchBugView:) :2000 :[NSString stringWithFormat:@"momo_shade.png"]];
        catchBugBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
        catchBugBtn.center = CGPointMake(100, 50);
        [self addSubview:catchBugBtn];
        
        //WashetButton
        UIButton *washletBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :@selector(washletView:) :3000 :[NSString stringWithFormat:@"momo_shade.png"]];
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
    momoIV.frame = CGRectMake(70,120,250,250);
    
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
    
    NSDictionary *status = [[saveData statusArray] objectAtIndex:index];
    
    for (int i=1; i<=[[status objectForKey:@"dirty_level"]integerValue]; i++) {
        [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
    }

    for (int i=1; i<=[[status objectForKey:@"injury_level"]integerValue]; i++) {
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
    catchBug = [[CatchBugView alloc]initWithDelegate:self];
    [self addSubview:catchBug];
}

- (void)washletView:(UIButton*)btn
{
    washlet = [[WashletView alloc]initWithDelegate:self];
    [self addSubview:washlet];
}


- (void)removeShipmentView{
    if(shipment){
        [shipment removeFromSuperview];
    }
}

- (void)removeCatchBugView{
    if(catchBug){
        [catchBug removeFromSuperview];
    }
}

- (void)removeWashletView{
    if(washlet){
        [washlet removeFromSuperview];
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
