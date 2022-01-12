//
//  CU_PublicWebViewController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_PublicWebViewController.h"
#import "Ouc_WKWebView.h"
#import "CU_PublicWebViewJSBridge.h"
#import "UIButton+CU_ImageTitleBtn.h"

@interface CU_PublicWebViewController ()<WKNavigationDelegate>

@property (nonatomic,strong) UIButton *backBtn ;

@property (nonatomic,strong) Ouc_WKWebView *webView ;//网页

@end

@implementation CU_PublicWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confingUI] ;
    
    NSURL *url = [NSURL URLWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0f]] ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES] ;
    self.gk_navItemLeftSpace = 9.0f ;
    //修改状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES] ;
    self.gk_navItemLeftSpace = 0.0f ;
    //    [self.webView stopLoading] ;
}

#pragma mark - configUI
-(void)confingUI{
    //返回按钮
    //    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"nav_back" target:self action:@selector(goBackAction:)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn] ;
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closeBtnClick:)] ;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = kBoldFont(15);
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [closeItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [closeItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    self.gk_navLeftBarButtonItems = @[backItem,closeItem] ;
    //添加网页
    [self.view addSubview:self.webView] ;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationAndStatusHeight) ;
        make.left.right.bottom.equalTo(self.view) ;
    }] ;
    kWeakSelf(self)
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.webView reload];
    }];
}

#pragma mark - 返回事件
-(void) goBackAction:(id) sender{
    if (self.webView.canGoBack==YES) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) closeBtnClick:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKDelegate
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = [[navigationAction.request URL] absoluteString];
    kNSLog(@"网址。。。%@",url) ;
    //防止跳转百度
    NSArray *testArray = [url componentsSeparatedByString:@"/"] ;
    NSString *testString ;
    if (testArray.count>2) {
        testString = testArray[2] ;
    }
    if ([url containsString:@"baidu.com"]||[testString isIPDomain]||[url containsString:@"about:blank"]) {
        //防止跳转百度,包含百度域名，或IP地址不跳转
        decisionHandler(WKNavigationActionPolicyCancel);
        return ;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [webView.scrollView.mj_header endRefreshing] ;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [webView.scrollView.mj_header endRefreshing] ;
}

//WkWebView的 回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.gk_navTitle = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
    }
}

//-(void)callJsMethod:(WKWebView *)webView{
//    Bee_AccountModel *account = [Bee_AccountModel acountModel] ;
//    NSDictionary *param = @{@"organizationId":kOrganizationId,
//                            @"appId":kAppId,
//                            @"studId":account.studId?account.studId:@"",
//                            @"forId":account.forId?account.forId:@"",
//                            @"studName":account.studName?account.studName:@"",
//                            @"studImg":account.studImg?account.studImg:@""
//                            };
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:&parseError];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *methodJS = [NSString stringWithFormat:@"appUserInfo('%@')",jsonString];
//    [webView evaluateJavaScript:methodJS completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//
//    }];
//}

#pragma mark - Getter
-(Ouc_WKWebView *)webView{
    if (!_webView) {
        _webView = [[Ouc_WKWebView alloc] init];
        _webView.navigationDelegate = self ;
        CU_PublicWebViewJSBridge *bridge = [CU_PublicWebViewJSBridge new] ;

        [_webView addJavascriptInterfaces:bridge WithJSObjName:@"Phone"] ;
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _webView ;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"返回" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal] ;
            [btn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:2.0f] ;
            //按钮文字属性
            [btn.titleLabel setFont:kFont(15)] ;
            [btn addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside] ;
            btn ;
        }) ;
    }
    return _backBtn ;
}


@end
