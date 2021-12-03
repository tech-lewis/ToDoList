//
//  BiDEditorViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15-8-31.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BiDEditorViewController.h"


@interface BiDEditorViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation BiDEditorViewController
#pragma mark - segue prepare
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.itemNameTextField.text.length <= 0 || [sender tag]==1)
    {
        self.state = KStateCancelModify;
    }
    else if ([sender tag]==2)
    {
        self.state = KStateDone;
        self.item.itemName = self.itemNameTextField.text;
        self.item.itemNote = self.itemNoteTextField.text;
    }
    else if ([sender tag]==3)
    {
        self.state = kStateDeleteItem;
    }
    // NSLog(@"%d", [sender tag]);
}


#pragma mark - Tap Gesture
// 触摸开始时退出键盘
- (void)tapBackgroundToResignKeyBoard:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}
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

- (void)setSelectedDate:(NSDate *)selectedDate
{
    if(!_selectedDate) _selectedDate = [[NSDate alloc] init];
    _selectedDate = selectedDate;
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
    self.planDateTextField.text = [NSDateFormatter localizedStringFromDate:datePicker.date
                                                                 dateStyle:NSDateFormatterLongStyle
                                                                 timeStyle:NSDateFormatterShortStyle];
    
    self.item.planDate = datePicker.date;
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
        [self.itemNameTextField becomeFirstResponder];
    }
    else if (nextTag == 1)
    {
        [self.itemNoteTextField becomeFirstResponder];
    }
    
}


#pragma mark - Lifecycle and init
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initWithTextField
{
    [self.itemNameTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.2];
    self.itemNameTextField.inputAccessoryView = [self keyboardToolbarView];
    self.itemNoteTextField.inputAccessoryView = [self keyboardToolbarView];
    
    [self.itemNameTextField addTarget:self
                       action:@selector(textFieldDone:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.itemNoteTextField addTarget:self
                               action:@selector(textFieldDone:)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.planDateTextField.inputAccessoryView = [self keyboardToolbarView];
    self.planDateTextField.inputView = [self datePickerForKeyboard];
}

- (void)setItem:(BiDToDoItem *)item
{
    _item = item;
    // NSLog(@"%@", self.item);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemNameTextField.text = self.item.itemName;
    self.itemNoteTextField.text = self.item.itemNote;
    self.planDateTextField.text = [NSDateFormatter localizedStringFromDate:self.item.planDate
                                                                 dateStyle:NSDateFormatterLongStyle
                                                                 timeStyle:NSDateFormatterShortStyle];;
    
    
    // 设置日期和时间
    NSDate *now = [NSDate date];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:now
                                                         dateStyle:NSDateFormatterLongStyle
                                                         timeStyle:NSDateFormatterNoStyle];
    
    [self initWithTextField];
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundToResignKeyBoard:)];
    [self.view addGestureRecognizer:_tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
