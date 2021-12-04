//
//  BiDToDoListViewController.h
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiDEditorViewController.h"

@interface BiDToDoListViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *toDoItems;
@property (strong, nonatomic) BiDEditorViewController *editorViewController;

// back to this list
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
