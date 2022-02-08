//
//  BiDWebBrowserViewController.m
//  ToDoList
//
//  Created by Mark on 21-12-4.
//  Copyright (c) 2021年 TechLewis. All rights reserved.
//

#import "BiDWebBrowserViewController.h"
#define webDefaultURL @"defaultURL"
@interface BiDWebBrowserViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BiDWebBrowserViewController


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *text = [alertView textFieldAtIndex:0].text;
    if (text.length > 0)
    {
        if ([text hasPrefix:@"http://"] || [text hasPrefix:@"https://"])
        {
            // save
            [[NSUserDefaults standardUserDefaults] setObject:text forKey:webDefaultURL];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的网站地址" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}
- (void)reloadOtherInWebview
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的网站地址" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView textFieldAtIndex:0].placeholder = @"请输入正确格式的网站地址";
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];
    [alertView show];
    
}


- (void)refreshWebview {
    [self.webView reload];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"正在刷新网页" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)closeThisController
{
    [self dismissViewControllerAnimated:true completion:NULL];
}
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
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    // 设置工具条
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                   action:@selector(refreshWebview)];
    UIBarButtonItem *changeSiteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                   target:self
                                                                                   action:@selector(reloadOtherInWebview)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(closeThisController)];
    
    CGFloat toolbarHeight = 30.0;
    BOOL iOS7orLater = ([[UIDevice currentDevice] systemVersion].doubleValue >= 7.0);
    UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-toolbarHeight-(iOS7orLater ? 0: 20), 320, toolbarHeight)];
    [bottomBar setBarStyle:UIBarStyleBlackTranslucent];
    [bottomBar setItems:@[refreshButton, flexibleItem, changeSiteButton, flexibleItem, closeButton]];
    [self.view addSubview:bottomBar];
    [self.navigationController setToolbarHidden:NO];
    [self setupUIWIthoutToolbarHeight:toolbarHeight];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupUIWIthoutToolbarHeight:(CGFloat)h
{
    CGSize viewSize = self.view.bounds.size;
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height-h)];
    [self.view addSubview:webview];
    
    
    NSURL *defaultURL = [NSURL URLWithString:@"https://www.baidu.com"];
    NSString *sandboxURL = [[NSUserDefaults standardUserDefaults] objectForKey:webDefaultURL];
    if (sandboxURL.length > 5) {
        defaultURL = [NSURL URLWithString:sandboxURL];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:defaultURL];
    [webview loadRequest:urlRequest];
}
@end
