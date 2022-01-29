//
//  BiDAddToDoItemViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BiDAddToDoItemViewController.h"

@interface BiDAddToDoItemViewController () <UITextFieldDelegate>
{
    UITapGestureRecognizer *_tap;
}
@end

@implementation BiDAddToDoItemViewController


#pragma mark - Tap Gesture
// 触摸开始时退出键盘
- (void)tapBackgroundToResignKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}



#pragma mark - segue prepare
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (sender != self.doneButton) return;
    
//    if (self.planDateTextField.text.length <= 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select date"
//                                                        message:@"The plan date of this item"
//                                                       delegate:self cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//    }
    
    if (self.textField.text.length > 0)
    {
        self.toDoItem = [[BiDToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.itemNote = self.itemNoteTextField.text;
        self.toDoItem.planDate = self.selectedDate;
        
        self.toDoItem.creationDate = [NSDate date];
        self.toDoItem.completed = NO;
    }
}

#pragma mark - ScrollView

static BOOL isBack = NO;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    //    NSLog(@"x:%f",point.x);
    //    NSLog(@"y:%f",point.y);
    
    CGRect bounds = self.view.bounds;
    if(point.y < -(bounds.size.height*0.35))
    {
        isBack = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(isBack) [self performSegueWithIdentifier:@"SegueToDoListView" sender:self];
    isBack = NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)endEditingOrResignKeyBoard
{
    [self.view endEditing:YES];
}

- (UIToolbar *)keyboardToolbarView
{
    CGRect bounds = self.view.bounds;
    UIToolbar *mainView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    
    /*
    UIBarButtonItem *preButton = [[UIBarButtonItem alloc] initWithTitle:@"Pre"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:nil];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:nil];
     */
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(endEditingOrResignKeyBoard)];
    mainView.items = @[flexibleItem, doneButton];
    return mainView;
}

- (UIDatePicker *)datePickerForKeyboard
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:120];
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return datePicker;
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    _selectedDate = datePicker.date;
    self.planDateTextField.text = [NSDateFormatter localizedStringFromDate:_selectedDate
                                                                 dateStyle:NSDateFormatterLongStyle
                                                                 timeStyle:NSDateFormatterShortStyle];
    self.doneButton.enabled = YES;
}
#define kNumberOfTextField 2
- (void)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
    UITextField *senderField = sender;
    NSInteger nextTag = (senderField.tag + 1) % kNumberOfTextField;
    //1-2-3-0-1-2-3-0...循环
    
    
    if (nextTag == 0)
    {
        [self.textField becomeFirstResponder];
    }
    else if (nextTag == 1)
    {
        [self.itemNoteTextField becomeFirstResponder];
    }

}


- (void)initWithTextField
{
    [self.textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.2];
    self.textField.inputAccessoryView = [self keyboardToolbarView];
    self.itemNoteTextField.inputAccessoryView = [self keyboardToolbarView];
    
    [self.textField addTarget:self
                       action:@selector(textFieldDone:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.itemNoteTextField addTarget:self
                               action:@selector(textFieldDone:)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.planDateTextField.inputAccessoryView = [self keyboardToolbarView];
    self.planDateTextField.inputView = [self datePickerForKeyboard];
}

#pragma mark - init method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithTextField];
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundToResignKeyBoard:)];
    [self.view addGestureRecognizer:_tap];
    
    // 设置日期和时间
    NSDate *now = [NSDate date];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:now
                                                         dateStyle:NSDateFormatterLongStyle
                                                         timeStyle:NSDateFormatterNoStyle];
    self.timeLabel.text = [NSDateFormatter localizedStringFromDate:now
                                                         dateStyle:NSDateFormatterNoStyle
                                                         timeStyle:NSDateFormatterShortStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
