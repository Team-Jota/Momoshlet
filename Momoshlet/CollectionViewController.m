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
    if (detail) {
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
    
    detail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    int number = (btn.tag/10)-1;
    int momo_id = number/5;
    int state = number%5;
    
    UIImageView *bgimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgcollection2.png"]];
    bgimg.frame = CGRectMake(0, 0, 320, 480);
    [detail addSubview:bgimg];
    
    NSLog(@"momo_id = %d, state = %d", momo_id, state);
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[self makeImage:momo_id :state]];
    img.frame = CGRectMake(0, 60.5, 320, 320);
    [detail addSubview:img];
    
    UIButton *btn1 = [cb makeButton:CGRectMake(0, 0, 320, 480) :@selector(removeDetailView) :1000 :nil];
    btn1.backgroundColor = [UIColor clearColor];
    [detail addSubview:btn1];
    
    [self.view addSubview:detail];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app tabBatItemMainEnabled:NO];
}

- (UIImage *)makeImage:(int)index:(int)state
{
    int number = 1;
    
    if (state==1|| state==2 || state==3){
        number = 2;
    }
    else if (state == 4){
        number = 3;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(400, 400));
    [[UIImage imageNamed:[NSString stringWithFormat:@"momo%d-%d.png", index+1, number]] drawInRect:CGRectMake(0, 0, 400, 400)];
    if (state == 1 || state == 3) {
        for (int i=1; i<=5; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"dirty%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
    }
    if (state == 2 || state == 3) {
        for (int i=1; i<=5; i++) {
            [[UIImage imageNamed:[NSString stringWithFormat:@"bug%d.png",i]] drawInRect:CGRectMake(0, 0, 400, 400)];
        }
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)makeScrollView
{
    pages = 5;
    for (int k=25; k<30; k++) {
        BOOL tempBool = [[saveData.collectionArray objectAtIndex:k] boolValue];
        if (tempBool==YES) {
            pages = 6;
            break;
        }
    }
    
    if (stage) {
        [stage removeFromSuperview];
        stage = nil;
    }
    
    cb = [CustomButton initWithDelegate:self];
    stage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:stage];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.delegate = self;
    
    UIView *scrollStage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*pages, 480)];
    scrollView.contentSize = scrollStage.frame.size;
    scrollView.pagingEnabled = YES;
    
    CGPoint point[5] = {
        CGPointMake(23.3+62.5, 60.3+62.5),
        CGPointMake(23.3+23.3+125+62.5, 60.3+62.5),
        CGPointMake(23.3+63.5, 60.3+60.3+125+62.5),
        CGPointMake(23.3+23.3+125+62.5, 60.3+60.3+125+62.5),
        CGPointMake(160, 215.5)
    };
    
    int count = 1;
    for (int i=0; i<pages; i++) {
        UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgcollection1.png"]];
        bgImg.frame = CGRectMake(320*i, 0, 320, 480);
        [scrollStage addSubview:bgImg];
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 480)];
        tempView.backgroundColor = [UIColor clearColor];
        
        for (int j=0; j<5; j++) {
            BOOL isCollection = [[saveData.collectionArray objectAtIndex:count-1] boolValue];
            
            UIButton *btn = [cb makeButton:CGRectMake(0, 0, 125, 125) :@selector(detailView:) :count*10 :nil];
            UIImage *img;
            if (isCollection==YES) {
                img = [self makeImage:i :j];
            }
            else {
                img = [UIImage imageNamed:@"momo_shade.png"];
                btn.enabled = NO;
            }
            [btn setImage:img forState:UIControlStateNormal];
            btn.center = point[j];
            
            [tempView addSubview:btn];
            
            count++;
        }
        
        [scrollStage addSubview:tempView];
    }
    
    [scrollView addSubview:scrollStage];
    
    pageLagel = [[UILabel alloc] initWithFrame:CGRectMake(115, 381, 100, 50)];
    pageLagel.text = [NSString stringWithFormat:@"1/%d",pages];
    pageLagel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
    pageLagel.backgroundColor = [UIColor clearColor];
    page = 1;
    scrollXPoint = scrollView.contentOffset.x;
    detail = nil;
    
    [stage addSubview:scrollView];
    
    [stage addSubview:pageLagel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    cb = [CustomButton initWithDelegate:self];
    saveData = [SaveData initSaveData];
    stage = nil;
    
    [self makeScrollView];
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
    
    if (page > pages) {
        page = pages;
    }
    
    if (page < 1) {
        page = 1;
    }
    
    [pageLagel setText:[NSString stringWithFormat:@"%d/%d",page, pages]];
}

@end
