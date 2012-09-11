//
//  CollectionViewController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomButton.h"
#import "AppDelegate.h"

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
    NSLog(@"removeDetailVIew");
    
    if (detail) {
        NSLog(@"in");
        
        [detail removeFromSuperview];
        detail = nil;
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app tabBatItemMainEnabled:YES];
    [app tabBatItemCollectionEnabled:YES];
}
    
- (void)detailView:(UIButton *)btn
{
    cb = [CustomButton initWithDelegate:self];
    
    if (detail) {
        [detail removeFromSuperview];
        detail = nil;
    }
    
    detail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    detail.backgroundColor = [UIColor purpleColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [label setText:[NSString stringWithFormat:@"%d",btn.tag]];
    [detail addSubview:label];
    
    UIButton *btn1 = [cb makeButton:CGRectMake(0, 100, 320, 50) :@selector(removeDetailView) :1000 :nil];
    btn1.backgroundColor = [UIColor blackColor];
    [detail addSubview:btn1];
    
    [self.view addSubview:detail];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app tabBatItemMainEnabled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cb = [CustomButton initWithDelegate:self];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.delegate = self;
    
    UIView *scrollStage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*5, 480)];
    scrollView.contentSize = scrollStage.frame.size;
    scrollView.pagingEnabled = YES;
    
    int count = 1;
    for (int i=0; i<5; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 480)];
        if (i%2 == 0){
            tempView.backgroundColor = [UIColor blueColor];
        }
        else {
            tempView.backgroundColor = [UIColor redColor];
        }
        
        for (int j=0; j<2; j++) {
            for (int k=0; k<2; k++) {
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
    
    pageLagel = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, 320, 50)];
    pageLagel.text = @"1/5";
    page = 1;
    scrollXPoint = scrollView.contentOffset.x;
    detail = nil;
    
    [self.view addSubview:scrollView];
    
    [self.view addSubview:pageLagel];
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


//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollXPoint != scrollView.contentOffset.x){
        for (int i=1; i<=4; i++) {
            if (scrollXPoint+320*i == scrollView.contentOffset.x) {
                page+=i;
                scrollXPoint = scrollView.contentOffset.x;
            }
            else if (scrollXPoint-320*i == scrollView.contentOffset.x){
                page-=i;
                scrollXPoint = scrollView.contentOffset.x;
            }
        }
    }
    
    if (page > 5) {
        page = 5;
    }
    
    if (page < 1) {
        page = 1;
    }
    
    [pageLagel setText:[NSString stringWithFormat:@"%d/5",page]];
}

@end
