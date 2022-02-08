//
//  VoiceRecognizeTextView.m
//  ToDoList
//
//  Created by MarkLewis on 2022/2/7.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "VoiceRecognizeTextView.h"

@implementation VoiceRecognizeTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
  UIMenuItem * item1=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(myCopy:)];
  UIMenuItem * item2=[[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(myCut:)];
  UIMenuItem * item3=[[UIMenuItem alloc]initWithTitle:@"全选" action:@selector(mySelectAll:)];
  UIMenuItem * item4=[[UIMenuItem alloc]initWithTitle:@"文本对比" action:@selector(myEditor:)];
  UIMenuItem * item5=[[UIMenuItem alloc]initWithTitle:@"音标/拼音" action:@selector(myRead:)];
  //创建UIMenuController
  UIMenuController * menuController=[UIMenuController sharedMenuController];
  menuController.menuItems= @[item1, item2, item3, item4, item5];
 
  BOOL result = (action == @selector(myCopy:) || action == @selector(mySelect:) || action == @selector(myRead:) || action == @selector(mySelectAll:) || action == @selector(myCut:) || action == @selector(myEditor:));
  
  return  result;
}

/*系统提供的有一些公用的方法,只需要实现出来,对应的menuItem就会加上去 */
-(void)myCopy:(id)menu
{
  if (!self.text) return; //当没有文字的时候调用这个方法会崩溃
  //复制文字到剪切板
  UIPasteboard * paste = [UIPasteboard generalPasteboard];
  paste.string = self.text;
}
-(void)mySelect:(id)menu
{
  [self select:menu];
}

-(void)mySelectAll:(id)menu
{
  [self selectAll:menu];
}

-(void)myCut:(UIMenuItem *)item
{
  [self cut:item];
}


-(void)myRead:(id)menu
{
  NSLog(@"%@", menu);
}


- (void)myEditor: (id)menu
{
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"I‘m Sorry" message:@"应用不支持iOS 7.0以下的设备" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
  [alertView show];
}
@end
