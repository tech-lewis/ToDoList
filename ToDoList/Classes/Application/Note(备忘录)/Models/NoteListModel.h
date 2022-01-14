//
//  NoteListModel.h
//  ToDoList
//
//  Created by MarkLewis on 2021/12/26.
//  Copyright © 2021 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteListModel : NSObject
/**     string     字符串型的ID*/
@property (nonatomic, copy) NSNumber *idstr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *detail; // category create remind complete
@property (nonatomic, strong) NSNumber *category;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *remindTime;
@property (nonatomic, copy) NSString *completeTime;
@property (nonatomic, strong) NSData *attachmentData;
@property (nonatomic, copy) NSAttributedString *attributedText;
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail category:(NSNumber *)category remind:(NSString *)remindTime;
@end

NS_ASSUME_NONNULL_END
