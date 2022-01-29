//
//  ContentCellViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15-9-13.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "ContentCellViewController.h"
#import "FoldableView.h"

@interface ContentCellViewController ()

@end

@implementation ContentCellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // [self.view addSubview:self.noteTextView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds =self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(bounds.size.width*2, bounds.size.height);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    // 在scrollView中添加View
    CGSize tempSzie = self.firstContentView.bounds.size;
    self.firstContentView.frame = CGRectMake(0, 0, tempSzie.width, tempSzie.height);
    [self.scrollView addSubview:self.firstContentView];
    
    tempSzie = self.secondContentView.bounds.size;
    self.secondContentView.frame = CGRectMake(bounds.size.width, 0, tempSzie.width, tempSzie.height);
    [self.scrollView addSubview:self.secondContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender
{    
    if ([[self.backgroundView superview] isKindOfClass:[FoldableView class]])
    {
        // 设置isOpen来关闭foldview
        FoldableView *mySuperview = (FoldableView *)self.backgroundView.superview;
        mySuperview.isClickEditButton = YES;
    }
}
@end
