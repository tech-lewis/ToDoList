//
//  AddNewNoteController.h
//  ToDoList
//
//  Created by MarkLewis on 2022/1/26.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "CU_BaseViewController.h"
@class NoteListModel;
typedef void(^AddNoteFinishBlock)(NoteListModel *data);
@interface AddNewNoteController : CU_BaseViewController
@property (nonatomic, copy) AddNoteFinishBlock completeBlock;

- (instancetype)initWithBlock:(AddNoteFinishBlock)block;
@end
