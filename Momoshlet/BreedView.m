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

    if (self){
        cb = [CustomButton initWithDelegate:self];
        
        self.backgroundColor = [UIColor brownColor];
        
        delegate = _delegate;
        index = _index;
        
        UIButton *rmButton = [cb makeButton:CGRectMake(0, 0, 50, 50) :@selector(callRemoveBreedView) :100 :nil];
        rmButton.backgroundColor = [UIColor redColor];
        [self addSubview:rmButton];
        
        //ShipmentButton
        NSString *img;
        img= @"momo_shade.png";
        UIButton *shipmentBtn = [cb makeButton:CGRectMake(0, 0, 250, 200) :@selector(shipmentView:) :1000 :img];
        shipmentBtn.transform = CGAffineTransformMakeScale(0.5, 0.5);
        shipmentBtn.center = CGPointMake(80, 240);
        [self addSubview:shipmentBtn];
        
    }
        
    return self;
}

-(void)shipmentView:(UIButton*)btn
{
    shipment = [[ShipmentView alloc]initWithDelegate:self];
    [self addSubview:shipment];
}

-(void)removeShipmentView{
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
