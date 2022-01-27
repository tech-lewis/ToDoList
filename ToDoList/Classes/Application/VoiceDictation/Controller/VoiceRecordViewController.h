//
//  VoiceRecordViewController.h
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJLReadObject.h"
#import "PJLRecognitionObject.h"
@interface VoiceRecordViewController : UIViewController
@property (nonatomic)  PJLRecognitionObject *record;
@end
