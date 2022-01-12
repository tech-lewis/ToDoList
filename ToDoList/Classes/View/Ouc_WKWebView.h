//
//  Ouc_WKWebView.h
//  WKWebViewDemo
//
//  Created by 钟小麦 on 2019/4/24.
//  Copyright © 2019 eenet. All rights reserved.
//  重写WKWebView，可与H5交互

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ouc_WKWebView : WKWebView


/**
 注入对象

 @param interface 实例对象
 @param name 与H5约定好名称
 */
- (void) addJavascriptInterfaces:(NSObject*) interface WithJSObjName:(NSString*) name;

@end

NS_ASSUME_NONNULL_END
