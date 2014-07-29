//
//  CommentText.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface CommentText : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * englishContent;
@property (nonatomic, retain) NSString * hebrewContent;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSSet *whatComment;
@end

@interface CommentText (CoreDataGeneratedAccessors)

- (void)addWhatCommentObject:(Comment *)value;
- (void)removeWhatCommentObject:(Comment *)value;
- (void)addWhatComment:(NSSet *)values;
- (void)removeWhatComment:(NSSet *)values;

@end
