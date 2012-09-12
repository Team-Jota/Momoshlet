//
//  CatchBugView.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/07.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CatchBugView.h"

@implementation CatchBugView

- (id)initWithDelegate:(id)_delegate:(int)_index
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    saveData = [SaveData initSaveData];
    
    if(self){
        cb = [CustomButton initWithDelegate:self];
        saveData = [SaveData initSaveData];
        delegate = _delegate;
        self.backgroundColor = [UIColor brownColor];
        index = _index;
        isMoveMist = YES;
        NSDictionary *status = [saveData.statusArray objectAtIndex:index];
        
        momoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        momoView.center = CGPointMake(momoView.center.x, 215.5);
        [self addSubview:momoView];
        
        momoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-2.png",[[status objectForKey:@"id"] intValue]/100]]];
        momoImg.frame = CGRectMake(0, 0, 200, 200);
        [momoView addSubview:momoImg];
        
        momoImg2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-3.png",[[status objectForKey:@"id"] intValue]/100]]];
        momoImg2.frame = CGRectMake(0, 0, 200, 200);
        momoImg2.hidden = YES;
        [momoView addSubview:momoImg2];
        
        UIGraphicsBeginImageContext(CGSizeMake(400, 400));
        for (int i=1; i<=[[status objectForKey:@"dirty_level"] integerValue]; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *dirty = [[UIImageView alloc] initWithImage:img];
        dirty.frame = CGRectMake(0, 0, 200, 200);
        [momoView addSubview:dirty];
        
        [self setBugImage];
        
        sprayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        sprayView.center = CGPointMake(270, 215.5);
        sprayPoint = sprayView.center;
        spray = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spray1.png"]];
        spray.frame = CGRectMake(0, 0, 100, 100);
        [sprayView addSubview:spray];
        
        UIImageView *spray2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spray2.png"]];
        spray2.frame = CGRectMake(0, 0, 100, 100);
        [sprayView addSubview:spray2];
        [self addSubview:sprayView];
        
        mist = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mist.png"]];
        mist.frame = CGRectMake(-58, -40, 100, 100);
        mistPoint = mist.center;
        mist.center = CGPointMake(mistPoint.x+50, mistPoint.y);
        mist.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [sprayView addSubview:mist];
        
        selectedInjury = 1;
        [self startSprayAnimation];
    }
    return self;
}

- (void)setBugImage
{
    CGRect rect = CGRectMake(0, 0, 200, 200);
    injury1 = nil;
    injury2 = nil;
    injury3 = nil;
    injury4 = nil;
    injury5 = nil;
    
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    int injury_level = [[status objectForKey:@"injury_level"] intValue];
    
    if (injury_level >= 1) {
        injury1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug1.png"]];
        injury1.frame = rect;
        [momoView addSubview:injury1];
    }
        
    if (injury_level >= 2) {
        injury2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug2.png"]];
        injury2.frame = rect;
        [momoView addSubview:injury2];
    }
    
    if (injury_level >= 3) {
        injury3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug3.png"]];
        injury3.frame = rect;
        [momoView addSubview:injury3];
    }
    
    if (injury_level >= 4) {
        injury4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug4.png"]];
        injury4.frame = rect;
        [momoView addSubview:injury4];
    }
    
    if (injury_level == 5) {
        injury5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug5.png"]];
        injury5.frame = rect;
        [momoView addSubview:injury5];
    }
}

- (void)finishBugFall
{
    NSDictionary *status = [saveData.statusArray objectAtIndex:index];
    
    if (selectedInjury<[[status objectForKey:@"injury_level"] intValue]) {
        selectedInjury++;
        [self startBugFall];
    }
    else {
        [self endSprayAnimation];
    }
}

- (void)bugFall4
{
    UIImageView *temp;
    if (selectedInjury == 1)
        temp = injury1;
    else if (selectedInjury == 2)
        temp = injury2;
    else if (selectedInjury == 3)
        temp = injury3;
    else if (selectedInjury == 4)
        temp = injury4;
    else
        temp = injury5;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishBugFall)];
    
    temp.center = CGPointMake(temp.center.x, temp.center.y+5);
    
    [UIView commitAnimations];
}

- (void)bugFall3
{
    UIImageView *temp;
    if (selectedInjury == 1)
        temp = injury1;
    else if (selectedInjury == 2)
        temp = injury2;
    else if (selectedInjury == 3)
        temp = injury3;
    else if (selectedInjury == 4)
        temp = injury4;
    else
        temp = injury5;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bugFall4)];
    
    temp.center = CGPointMake(temp.center.x, temp.center.y-5);
    
    [UIView commitAnimations];
}

- (void)bugFall2
{
    UIImageView *temp;
    if (selectedInjury == 1)
        temp = injury1;
    else if (selectedInjury == 2)
        temp = injury2;
    else if (selectedInjury == 3)
        temp = injury3;
    else if (selectedInjury == 4)
        temp = injury4;
    else
        temp = injury5;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bugFall3)];
    
    temp.center = CGPointMake(temp.center.x, temp.center.y+15);
    
    [UIView commitAnimations];
}

- (void)bugFall1
{
    UIImageView *temp;
    if (selectedInjury == 1)
        temp = injury1;
    else if (selectedInjury == 2)
        temp = injury2;
    else if (selectedInjury == 3)
        temp = injury3;
    else if (selectedInjury == 4)
        temp = injury4;
    else
        temp = injury5;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bugFall2)];
    
    temp.center = CGPointMake(temp.center.x, temp.center.y-15);
    
    [UIView commitAnimations];
}

- (void)startBugFall
{
    if (selectedInjury == 1)
        [self moveMist];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (selectedInjury == 1)
        [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bugFall1)];

    if (selectedInjury == 1)
        injury1.center = CGPointMake(injury1.center.x, injury1.center.y+180);
    else if (selectedInjury == 2)
        injury2.center = CGPointMake(injury2.center.x, injury2.center.y+225);
    else if (selectedInjury == 3)
        injury3.center = CGPointMake(injury3.center.x, injury3.center.y+170);
    else if (selectedInjury == 4)
        injury4.center = CGPointMake(injury4.center.x, injury4.center.y+220);
    else
        injury5.center = CGPointMake(injury5.center.x, injury5.center.y+170);
    
    [UIView commitAnimations];
}

- (void)sprayAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startBugFall)];
    
    mist.center = CGPointMake(mistPoint.x, mistPoint.y);
    mist.transform = CGAffineTransformMakeScale(1.0, 1.0);
    spray.center = CGPointMake(spray.center.x, spray.center.y+5);
    
    [UIView commitAnimations];
}

- (void)startSprayAnimation
{
    sprayView.center = CGPointMake(sprayPoint.x+100, sprayPoint.y);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(sprayAnimation)];
    
    sprayView.center = CGPointMake(sprayPoint.x, sprayPoint.y);
    
    [UIView commitAnimations];
}

- (void)backSpray
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(callRemoveCatchBugView)];
    
    sprayView.center = CGPointMake(sprayPoint.x+100, sprayPoint.y);
    
    [UIView commitAnimations];
}

- (void)backMist
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(backSpray)];
    
    mist.center = CGPointMake(mistPoint.x+50, mistPoint.y);
    mist.transform = CGAffineTransformMakeScale(0.01, 0.01);
    spray.center = CGPointMake(spray.center.x, spray.center.y-5);
    
    [UIView commitAnimations];
}

- (void)endSprayAnimation
{
    [mist stopAnimating];
    isMoveMist = NO;
    momoImg.hidden = YES;
    momoImg2.hidden = NO;
    [self performSelector:@selector(backMist) withObject:nil afterDelay:0.5];
}

- (void)moveMist2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    if (isMoveMist == YES)
        [UIView setAnimationDidStopSelector:@selector(moveMist)];
    
    mist.center = CGPointMake(mistPoint.x, mistPoint.y);
    
    [UIView commitAnimations];
}

- (void)moveMist
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    if (isMoveMist == YES)
        [UIView setAnimationDidStopSelector:@selector(moveMist2)];
    
    mist.center = CGPointMake(mistPoint.x-1, mistPoint.y-1);
    
    [UIView commitAnimations];
}

- (void) callRemoveCatchBugView
{
    [saveData resetInjury:index];
    [delegate removeCatchBugView];
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
