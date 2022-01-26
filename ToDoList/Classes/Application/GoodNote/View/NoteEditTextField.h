//
//  NoteEditTextField.h
//  ToDoList
//
//  Created by MarkLewis on 2022/1/26.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectNoteEditFirstMenuBlock)(void);
@interface NoteEditTextField : UITextField
@property (nonatomic, copy) SelectNoteEditFirstMenuBlock selectFirstMenuIemBlock;
@end

NS_ASSUME_NONNULL_END
