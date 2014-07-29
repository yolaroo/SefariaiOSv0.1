//
//  Comment.h
//  Sefaria
//
//  Created by MGM on 7/26/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CommentAuthor, CommentText;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * bookTitle;
@property (nonatomic, retain) NSNumber * chapterNumber;
@property (nonatomic, retain) NSNumber * lineNumber;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * textTitle;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) CommentAuthor *whatAuthor;
@property (nonatomic, retain) NSSet *whatText;
@end

@interface Comment (CoreDataGeneratedAccessors)

- (void)addWhatTextObject:(CommentText *)value;
- (void)removeWhatTextObject:(CommentText *)value;
- (void)addWhatText:(NSSet *)values;
- (void)removeWhatText:(NSSet *)values;

@end
