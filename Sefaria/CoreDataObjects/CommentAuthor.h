//
//  CommentAuthor.h
//  Sefaria
//
//  Created by MGM on 8/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, CommentCollectionTitle;

@interface CommentAuthor : NSManagedObject

@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSDate * deathDate;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatComment;
@property (nonatomic, retain) NSSet *whatCommentCollection;
@end

@interface CommentAuthor (CoreDataGeneratedAccessors)

- (void)addWhatCommentObject:(Comment *)value;
- (void)removeWhatCommentObject:(Comment *)value;
- (void)addWhatComment:(NSSet *)values;
- (void)removeWhatComment:(NSSet *)values;

- (void)addWhatCommentCollectionObject:(CommentCollectionTitle *)value;
- (void)removeWhatCommentCollectionObject:(CommentCollectionTitle *)value;
- (void)addWhatCommentCollection:(NSSet *)values;
- (void)removeWhatCommentCollection:(NSSet *)values;

@end
