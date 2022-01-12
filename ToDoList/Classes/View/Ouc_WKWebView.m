//
//  Ouc_WKWebView.m
//  WKWebViewDemo
//
//  Created by 钟小麦 on 2019/4/24.
//  Copyright © 2019 eenet. All rights reserved.
//

#import "Ouc_WKWebView.h"
#import <objc/runtime.h>

NSString* INJECT_JS = @"window.EasyJS = {\
\
call: function (obj, functionName, args){\
var formattedArgs = [];\
for (var i = 0, l = args.length; i < l; i++){\
formattedArgs.push(encodeURIComponent(args[i]));\
}\
\
var argStr = (formattedArgs.length > 0 ? \":\" + encodeURIComponent(formattedArgs.join(\":\")) : \"\");\
\
window.webkit.messageHandlers[obj].postMessage(obj + \":\" + encodeURIComponent(functionName) + argStr);\
\
},\
\
inject: function (obj, methods){\
window[obj] = {};\
var jsObj = window[obj];\
\
for (var i = 0, l = methods.length; i < l; i++){\
(function (){\
var method = methods[i];\
var jsMethod = method.replace(new RegExp(\":\", \"g\"), \"\");\
jsObj[jsMethod] = function (){\
return EasyJS.call(obj, method, Array.prototype.slice.call(arguments));\
};\
})();\
}\
}\
};";

@interface Ouc_WKWebView()<WKScriptMessageHandler>

@property (nonatomic,strong)NSMutableDictionary *javascriptInterfaces;

@end

@implementation Ouc_WKWebView

- (void) addJavascriptInterfaces:(NSObject*) interface WithJSObjName:(NSString*) name{
    if (! self.javascriptInterfaces){
        self.javascriptInterfaces = [[NSMutableDictionary alloc] init];
    }
    
    [self.javascriptInterfaces setValue:interface forKey:name];
    // 注入JS对象interface
    WKUserContentController *userContentController = self.configuration.userContentController;
    if (!userContentController) {
        userContentController = [[WKUserContentController alloc]init];
    }
    WKUserScript *script1 = [[WKUserScript alloc] initWithSource:INJECT_JS injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [userContentController addUserScript:script1];
    
    NSMutableString* injection = [NSMutableString new];
    //inject the javascript interface
    [injection appendString:@"EasyJS.inject(\""];
    [injection appendString:name];
    [injection appendString:@"\", ["];
    
    unsigned int mc = 0;
    Class cls = object_getClass(interface);
    Method * mlist = class_copyMethodList(cls, &mc);
    for (int i = 0; i < mc; i++){
        [injection appendString:@"\""];
        [injection appendString:[NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))]];
        [injection appendString:@"\""];
        
        if (i != mc - 1){
            [injection appendString:@", "];
        }
    }
    
    free(mlist);
    
    [injection appendString:@"]);"];
    
    WKUserScript *script2 = [[WKUserScript alloc] initWithSource:injection injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [userContentController addUserScript:script2];
    // 声明WKScriptMessageHandler 协议
    [userContentController  addScriptMessageHandler:self name:name];
    self.configuration.userContentController=userContentController;
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSArray *components = [message.body componentsSeparatedByString:@":"];
    
    NSString* obj = (NSString*)[components objectAtIndex:0];
    NSString* method = [(NSString*)[components objectAtIndex:1]
                        stringByRemovingPercentEncoding];
    
    NSObject* interface = [self.javascriptInterfaces objectForKey:obj];
    if(!interface)
    {
        return;
    }
    // execute the interfacing method
    SEL selector = NSSelectorFromString(method);
    NSMethodSignature* sig = [[interface class] instanceMethodSignatureForSelector:selector];
    NSInvocation* invoker = [NSInvocation invocationWithMethodSignature:sig];
    invoker.selector = selector;
    invoker.target = interface;
    
    if ([components count] > 2){
        NSString *argsAsString = [(NSString*)[components objectAtIndex:2]
                                  stringByRemovingPercentEncoding];
        
        NSArray* formattedArgs = [argsAsString componentsSeparatedByString:@":"];
        for (int i = 0; i < [formattedArgs count]; i++){
            NSString* argStr = ((NSString*) [formattedArgs objectAtIndex:i ]);
            //如果是中文，解码后invoke会闪退，所以把解码放在回调方法里
            //            NSString* arg = [argStr stringByRemovingPercentEncoding];
            //            if (i==2) {
            //                arg = @"2018年9月计算机统考考前直播";
            //            }
            [invoker setArgument:&argStr atIndex:(i + 2)];
            
        }
    }
    [invoker invoke];
    
    
}

@end
