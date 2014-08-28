//
//  ContextGroup.h
//  Sefaria
//
//  Created by MGM on 8/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContextGroupComment, LineText;

@interface ContextGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *whatLineText;
@property (nonatomic, retain) NSSet *whatComment;
@end

@interface ContextGroup (CoreDataGeneratedAccessors)

- (void)addWhatLineTextObject:(LineText *)value;
- (void)removeWhatLineTextObject:(LineText *)value;
- (void)addWhatLineText:(NSSet *)values;
- (void)removeWhatLineText:(NSSet *)values;

- (void)addWhatCommentObject:(ContextGroupComment *)value;
- (void)removeWhatCommentObject:(ContextGroupComment *)value;
- (void)addWhatComment:(NSSet *)values;
- (void)removeWhatComment:(NSSet *)values;

@end
