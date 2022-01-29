//
//  ContentCellViewController.h
//  ToDoList
//
//  Created by Mark Lewis on 15-9-13.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ContentCellViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *firstContentView;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) IBOutlet UIView *secondContentView;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *planDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (strong, nonatomic) IBOutlet UIView *backgroundView;
// action
- (IBAction)editButtonPressed:(id)sender;

@end
