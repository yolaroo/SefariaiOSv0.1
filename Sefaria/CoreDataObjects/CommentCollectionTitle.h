//
//  CommentCollectionTitle.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, CommentAuthor;

@interface CommentCollectionTitle : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSString * hebrewName;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatComment;
@property (nonatomic, retain) CommentAuthor *whatCommentAuthor;
@end

@interface CommentCollectionTitle (CoreDataGeneratedAccessors)

- (void)addWhatCommentObject:(Comment *)value;
- (void)removeWhatCommentObject:(Comment *)value;
- (void)addWhatComment:(NSSet *)values;
- (void)removeWhatComment:(NSSet *)values;

@end
