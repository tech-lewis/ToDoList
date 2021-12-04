//
//  BiDEditorViewController.h
//  ToDoList
//
//  Created by Mark Lewis on 15-8-31.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiDToDoItem.h"
typedef enum
{
    kStateDeleteItem,
    KStateCancelModify,
    KStateDone
}kState;

@interface BiDEditorViewController : UITableViewController

@property kState state;
@property (nonatomic, strong) BiDToDoItem *item;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic) NSInteger section;

@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemNoteTextField;
@property (weak, nonatomic) IBOutlet UITextField *planDateTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@end
