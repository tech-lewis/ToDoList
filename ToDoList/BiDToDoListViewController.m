//
//  BiDToDoListViewController.m
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BiDToDoListViewController.h"
#import "BiDAddToDoItemViewController.h"
#import "MusicListViewController.h"
#import "FoldableView.h"
#import "BiDToDoItem.h"
#import "UIImage+ImageEffects.h"

@interface BiDToDoListViewController ()<FoldableDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) FoldableView *foldableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, strong) UILongPressGestureRecognizer *lpGesture;

@end

static NSString *CellIdentifier = @"ListCell";


@implementation BiDToDoListViewController
- (NSString *)dataPath
{
    // 获取应用程序沙盒的documents路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = paths[0];
    // 合成指定plist文件的全路径
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"todolist.plist"];
    
    return filename;
}

#pragma mark - storage code
// 将自定义的ToDoItem类的数组转为NSData，然后写入plist文件
- (void)writeDataSourceToPlist
{
    NSData *writeData = [NSKeyedArchiver archivedDataWithRootObject:self.toDoItems];
    [writeData writeToFile:[self dataPath] atomically:YES];
    
    /*
    // 保存屏幕截图
    CGSize imageSize = self.tableView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.0);
    [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     */
}

- (void)loadInitialData
{
    // 判断第一次启动是否有plist，没有才创建
    BiDToDoItem *item = [[BiDToDoItem alloc] init];
    item.itemName = @"Please hold me !";
    item.itemNote = @"Welcome to Easy.ToDo\nPlease try press the BlueButton for add new item";
    item.creationDate = [NSDate date];
    item.planDate = [NSDate dateWithTimeIntervalSinceNow:1];
    
    [self.toDoItems addObject:item];
    // 获取Documents里todolist.plist子文件的路径
    BOOL isExistOldPlist = [[NSFileManager defaultManager] fileExistsAtPath:[self dataPath]];
    // NSLog(@"沙盒中是否存在todolist.plist文件 ？ %d", isExistOldPlist);     // 0不存在该文件
    if (isExistOldPlist)
    {
        // 只在从老版本升级到1.0.5版本时调用启动时调用过一次
        NSLog(@"老用户升级");
    }
    else
    {
        NSLog(@"新用户");
    }
}


#pragma mark - Init methods
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


// lazy instance
- (NSMutableArray *)toDoItems
{
    if(!_toDoItems) self.toDoItems = [[NSMutableArray alloc] init];
    return _toDoItems;
}

- (void)playButtonPressed:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您需要播放音乐吗?" delegate:self cancelButtonTitle:@"Help" otherButtonTitles:@"播放音乐", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        /// 打开网页 但是不支持UIWebView了
        NSLog(@"%@-%@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]);
    }
    else
    {
        [self performSegueWithIdentifier:@"SegueToMusicList" sender:self];
    }
}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // self.navigationItem.rightBarButtonItems = @[playButton, self.addButton];
    

    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                target:self
                                                                                action:@selector(playButtonPressed:)];

    
    [self setToolbarItems:@[flexibleItem, playButton]];
    [self.navigationController setToolbarHidden:NO];
    // [self.navigationController setToolbarItems:@[flexibleItem, playButton]];

    
    // 获取Documents路径
    NSString *filename = [self dataPath];
    
    // 判断第一次启动是否有plist，没有才创建
    BOOL isExistPlist = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    NSLog(@"沙盒中是否存在todolist.plist文件 ？ %d", isExistPlist);     // 0不存在该文件
    if (!isExistPlist)
    {
        [self loadInitialData]; // 只在第一次启动时调用过一次
    }
    else
    {
        // 存在plist文件时
        // 从文件中获得todolist.plist得到NSData数据
        // 解档到toDoItems数组
        NSData *data = [NSData dataWithContentsOfFile:filename];
        self.toDoItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    
    //订阅UIApplicationWillResignActiveNotification通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(writeDataSourceToPlist)
     name:UIApplicationWillResignActiveNotification
     object:app];
    
    
    // add long press gesture
    self.lpGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedCell:)];
    [self.tableView addGestureRecognizer:self.lpGesture];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    /*
    // 移除订阅通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:app];
     */
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - modify
- (void)modifyItem:(BiDToDoItem *)modifiedItem WtithIndex:(NSIndexPath *)selectedIndexPath
{
    // 先修改数据再刷新表格
    BiDToDoItem *item = self.toDoItems[selectedIndexPath.row];
    item = modifiedItem;
    
    // 刷新需要更新的那一行
    [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    // 性能有很大的影响
    // [self.tableView reloadData];
    // [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
    //                      withRowAnimation:UITableViewRowAnimationNone];

    
}
- (void)deleteItemAtIndexPath:(NSIndexPath *)selectedIndexPath
{
    // 先修改数据再刷新表格
    [self.toDoItems removeObjectAtIndex:selectedIndexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[selectedIndexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segue
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    BiDAddToDoItemViewController *source = [segue sourceViewController];
    BiDToDoItem *newItem = source.toDoItem;
    
    if (newItem != nil)
    {
        [self.toDoItems insertObject:newItem atIndex:0]; // 新的排列在最前面
        [self.tableView reloadData];
    }
}

- (IBAction)unwindFromMusicListBackToList:(UIStoryboardSegue *)sender
{
    NSLog(@"From MusicList back");
}

- (IBAction)unwindFromEditorBackToList:(UIStoryboardSegue *)segue
{
    kState state = KStateCancelModify;
    BiDEditorViewController *sourceController;
    // NSLog(@"%@", [[segue sourceViewController] class]);
    
    
    if ([[segue sourceViewController] isKindOfClass:[BiDEditorViewController class]])
    {
        sourceController = [segue sourceViewController];
        state = sourceController.state;
    }
    
    switch (state)
    {
        case KStateDone:
            [self modifyItem:sourceController.item WtithIndex:self.selectedIndexPath];
            break;
        case kStateDeleteItem:
            [self deleteItemAtIndexPath:self.selectedIndexPath];
            break;
        default:
            [self.tableView reloadData];
            break;
    }
    
}

#pragma mark - Segue prepare
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEditorView"])
    {
        UINavigationController *vc = [segue destinationViewController];
        
        if ([vc.viewControllers[0] isKindOfClass:[BiDEditorViewController class]])
        {
            BiDEditorViewController *viewController = vc.viewControllers[0];
            BiDToDoItem *selectedItem = self.toDoItems[self.selectedIndexPath.row];
            viewController.item = selectedItem;
        }
        
        
    }
}
#pragma mark - LongPress Gesture
- (void)swipeToDoItem:(UISwipeGestureRecognizer *)sender
{
    // 获得Swipe的那个Cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.view.tag inSection:0];
    if(indexPath == nil) return;
    UITableViewCell *swipeCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"swipe");
        BiDToDoItem *item= self.toDoItems[indexPath.row];
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:item.itemName];
        
        
        // 添加删除线
        NSUInteger nameLength = [[item itemName] length];
        [name addAttribute:NSStrikethroughStyleAttributeName
                     value:@(NSUnderlinePatternSolid|NSUnderlineStyleThick)
                     range:NSMakeRange(0, nameLength)];
        [name addAttribute:NSStrikethroughColorAttributeName
                     value:[UIColor orangeColor]
                     range:NSMakeRange(0, nameLength)];
        
        swipeCell.textLabel.attributedText = name;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        
    }
}
- (void)longPressedCell:(UILongPressGestureRecognizer *)sender
{
    // 获得长按的那个Cell
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
    if(indexPath == nil) return;
    self.selectedIndexPath = indexPath;
    // UITableViewCell *selectedCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    CGPoint point = [sender locationInView:self.navigationController.view];
    
    
    // 手势处理代码, 长按打开
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // NSLog(@"%@", NSStringFromCGPoint(selectedCell.frame.origin));
        

        CGSize imageSize = CGSizeMake(self.view.bounds.size.width, point.y);
        
        // 截图代码
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.0);
        [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *topImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // save this image
        // UIImageWriteToSavedPhotosAlbum(topImage, nil, nil, nil);
        
        // 下半部分
        imageSize = self.tableView.bounds.size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.0);
        [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //
        self.foldableView = [[FoldableView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:self.foldableView aboveSubview:self.tableView];
        // NSLog(@"%@", NSStringFromCGRect(self.foldableView.frame));


        // 保存两种版本的Image对象
        self.foldableView.originTopImage = topImage;
        self.foldableView.originBottomImage = image;
        self.foldableView.translucentTopImage = [topImage applyBlurWithRadius:3 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
        self.foldableView.translucentBottomImage = [image applyBlurWithRadius:3 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
        
        self.foldableView.topImage = self.foldableView.translucentTopImage;
        self.foldableView.bottomImage = self.foldableView.translucentBottomImage;
        self.foldableView.delegate = self;
        // 传递DataModel
        self.foldableView.item = self.toDoItems[indexPath.row];
        // setting TableView and button state
        self.tableView.scrollEnabled = NO;
        self.editButtonItem.enabled = NO;
        self.addButton.enabled = NO;
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        // NSLog(@"end gesture");
        // 禁用LongPress手势
        self.lpGesture.enabled = NO;
    }
    
}

#pragma mark - FoldableView delegate
- (void)foldableView:(FoldableView *)foldableView didClosedImageViewWithContentCell:(UIView *)view isClickEditButton:(BOOL)isClick
{
    // 更新该行的Item备注
    BiDToDoItem *selectedItem = self.toDoItems[self.selectedIndexPath.row];
    selectedItem = foldableView.item;
    
    // NSLog(@"%d", isClick);
    
    // 启用LongPress手势
    self.lpGesture.enabled = YES;
    // NSLog(@"关闭通知");
    // setting TableView and button state
    self.tableView.scrollEnabled = YES;
    self.editButtonItem.enabled = YES;
    self.addButton.enabled = YES;
    
    if (isClick)
    {
        self.editorViewController = [[BiDEditorViewController alloc] init];
        [self performSelector:@selector(segueToEditorView)
                   withObject:nil
                   afterDelay:0.5];
    }
}

- (void)segueToEditorView
{
    [self performSegueWithIdentifier:@"showEditorView" sender:self];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.toDoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    BiDToDoItem *item = self.toDoItems[indexPath.row];
    NSDate *date = item.creationDate;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:item.itemName];
    
    // 用accessory扩展图标，标记是否完成
    if (item.completed)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        
        // 添加删除线
        NSUInteger nameLength = [[item itemName] length];
        [name addAttribute:NSStrikethroughStyleAttributeName
                     value:@(NSUnderlinePatternSolid|NSUnderlineStyleThick)
                     range:NSMakeRange(0, nameLength)];
        [name addAttribute:NSStrikethroughColorAttributeName
                     value:[UIColor orangeColor]
                     range:NSMakeRange(0, nameLength)];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        
        // 隐藏删除线
        NSUInteger nameLength = [[item itemName] length];
        [name addAttribute:NSStrikethroughStyleAttributeName
                     value:@(NSUnderlinePatternSolid|NSUnderlineStyleNone)
                     range:NSMakeRange(0, nameLength)];
        [name addAttribute:NSStrikethroughColorAttributeName
                     value:[UIColor clearColor]
                     range:NSMakeRange(0, nameLength)];
    }
    
    
    // 显示日期
    if (date != nil)
    {
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    }
    else
    {
        cell.detailTextLabel.text = nil;
    }
    cell.textLabel.attributedText = name;
    cell.textLabel.tag = indexPath.row;
    // 添加向左Swipe gesture
    // UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDoItem:)];
    //leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    // [cell.textLabel addGestureRecognizer:leftSwipe];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BiDToDoItem *tappedItem = self.toDoItems[indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    // NSLog(@"Precent: %.1f％", [tappedItem precentOfCreatingDateWithPlainDate]*100);
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        // 先删除模型数据 ，然后再刷新表格
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

//- (IBAction)editButtonPressed:(id)sender
//{
//    BOOL state = !self.tableView.isEditing; // 判断编辑模式
//    [self.tableView setEditing:state animated:YES];
//}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // 取出要移动的项目
    BiDToDoItem *item = self.toDoItems[fromIndexPath.row];
    // 先删除，后移动
    [self.toDoItems removeObjectAtIndex:fromIndexPath.row];
    [self.toDoItems insertObject:item atIndex:toIndexPath.row];
}


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - ScrollView

static BOOL isBack = NO;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    //    NSLog(@"x:%f",point.x);
    //    NSLog(@"y:%f",point.y);
    
    
    
    CGRect bounds = self.view.bounds;
    if(point.y < -(bounds.size.height*0.2))
    {
        // NSLog(@"You can segue to addView!");
        isBack = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(isBack) [self performSegueWithIdentifier:@"SegueToAddView" sender:self];
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

@end
