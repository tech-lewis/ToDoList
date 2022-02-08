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
  UIMenuItem * item1=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copy:)];
  UIMenuItem * item2=[[UIMenuItem alloc]initWithTitle:@"文本对比" action:@selector(select:)];
  UIMenuItem * item3=[[UIMenuItem alloc]initWithTitle:@"音标/拼音" action:@selector(read:)];
  //创建UIMenuController
  UIMenuController * menuController=[UIMenuController sharedMenuController];
  menuController.menuItems= @[item1, item2, item3];
 
  BOOL result = (action == @selector(copy:) || action == @selector(select:) || action == @selector(read:) || action == @selector(copy:) || action == @selector(copy:) || action == @selector(copy:));
  
  return  result;
}

/*系统提供的有一些公用的方法,只需要实现出来,对应的menuItem就会加上去 */
-(void)copy:(id)sender
{
    NSLog(@"复制");
}
-(void)select:(id)sender
{
    NSLog(@"粘贴");
}
-(void)read:(id)sender
{}

-(void)selectAll:(id)sender
{}

-(void)restet:(UIMenuItem *)item
{
    NSLog(@"剪切");
}
@end
