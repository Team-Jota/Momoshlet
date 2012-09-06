//
//  CollectionViewController.m
//  Momoshlet
//
//  Created by 鈴木 大貴 on 2012/09/06.
//  Copyright (c) 2012年 鈴木 大貴. All rights reserved.
//

#import "CollectionViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
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
            for (int k=0; k<2 || (i==8 && j==1); k++) {
                if (i==7 && j==1) {
                    break;
                }
                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"momo_shade.png"]];
                img.transform = CGAffineTransformMakeScale(0.5, 0.5);
                img.center = CGPointMake(80+160*k, 120+200*j);
                
                [tempView addSubview:img];
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
