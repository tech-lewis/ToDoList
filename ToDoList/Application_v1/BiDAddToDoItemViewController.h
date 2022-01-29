//
//  BiDAddToDoItemViewController.h
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiDToDoItem.h"

@interface BiDAddToDoItemViewController : UITableViewController

@property BiDToDoItem *toDoItem;
@property NSDate *selectedDate;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *itemNoteTextField;
@property (weak, nonatomic) IBOutlet UITextField *planDateTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
