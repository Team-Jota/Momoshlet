//
//  CollectionViewController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomButton.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)removeDetailView
{
    NSLog(@"aaaaaaaaaaa");
    if (detail) {
        [detail removeFromSuperview];
    }
}
    
- (void)detailView:(UIButton *)btn
{
    detail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    detail.backgroundColor = [UIColor purpleColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [label setText:[NSString stringWithFormat:@"%d",btn.tag]];
    [detail addSubview:label];
    
    UIButton *btn1 = [cb makeButton:CGRectMake(0, 100, 320, 50) :@selector(removeDetailView) :1000 :nil];
    [detail addSubview:btn1];
    
    [self.view addSubview:detail];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cb = [CustomButton initWithDelegate:self];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    int count = 1;
    UIView *scrollStage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*8, 480)];
    scrollView.contentSize = scrollStage.frame.size;
    scrollView.pagingEnabled = YES;
    for (int i=0; i<8; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 480)];
        if (i%2 == 0){
            tempView.backgroundColor = [UIColor blueColor];
        }
        else {
            tempView.backgroundColor = [UIColor redColor];
        }
        
        for (int j=0; j<2; j++) {
            for (int k=0; k<2; k++) {
                if (count>30) {
                    break;
                }
                NSString *img;
                img = @"momo_shade.png";
                
                UIButton *btn = [cb makeButton:CGRectMake(0, 0, 250, 200) :@selector(detailView:) :count*10 :img];
                btn.transform = CGAffineTransformMakeScale(0.5, 0.5);
                btn.center = CGPointMake(80+160*k, 120+200*j);
                
                [tempView addSubview:btn];
                
                count++;
            }
        }
        
        [scrollStage addSubview:tempView];
    }
    
    [scrollView addSubview:scrollStage];
    
    [self.view addSubview:scrollView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
