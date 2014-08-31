//
//  LineText.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookGroup, BookTitle, Comment, ContextGroupData, Event, Person, Struggle, TextTitle, TextVersionTitle;

@interface LineText : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterNumber;
@property (nonatomic, retain) NSString * englishText;
@property (nonatomic, retain) NSString * hebrewText;
@property (nonatomic, retain) NSNumber * isBookmarked;
@property (nonatomic, retain) NSNumber * isBookmarkedChapter;
@property (nonatomic, retain) NSNumber * isEnglish;
@property (nonatomic, retain) NSNumber * isHebrew;
@property (nonatomic, retain) NSNumber * isLiked;
@property (nonatomic, retain) NSNumber * isTextLevel;
@property (nonatomic, retain) NSNumber * isUnliked;
@property (nonatomic, retain) NSNumber * lineNumber;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatBookGroup;
@property (nonatomic, retain) NSSet *whatBookTitle;
@property (nonatomic, retain) NSSet *whatComment;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) NSSet *whatPerson;
@property (nonatomic, retain) NSSet *whatStruggle;
@property (nonatomic, retain) TextTitle *whatTextTitle;
@property (nonatomic, retain) TextVersionTitle *whatTextVersionTitle;
@property (nonatomic, retain) NSSet *whatContextGroupData;
@end

@interface LineText (CoreDataGeneratedAccessors)

- (void)addWhatBookGroupObject:(BookGroup *)value;
- (void)removeWhatBookGroupObject:(BookGroup *)value;
- (void)addWhatBookGroup:(NSSet *)values;
- (void)removeWhatBookGroup:(NSSet *)values;

- (void)addWhatBookTitleObject:(BookTitle *)value;
- (void)removeWhatBookTitleObject:(BookTitle *)value;
- (void)addWhatBookTitle:(NSSet *)values;
- (void)removeWhatBookTitle:(NSSet *)values;

- (void)addWhatCommentObject:(Comment *)value;
- (void)removeWhatCommentObject:(Comment *)value;
- (void)addWhatComment:(NSSet *)values;
- (void)removeWhatComment:(NSSet *)values;

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatPersonObject:(Person *)value;
- (void)removeWhatPersonObject:(Person *)value;
- (void)addWhatPerson:(NSSet *)values;
- (void)removeWhatPerson:(NSSet *)values;

- (void)addWhatStruggleObject:(Struggle *)value;
- (void)removeWhatStruggleObject:(Struggle *)value;
- (void)addWhatStruggle:(NSSet *)values;
- (void)removeWhatStruggle:(NSSet *)values;

- (void)addWhatContextGroupDataObject:(ContextGroupData *)value;
- (void)removeWhatContextGroupDataObject:(ContextGroupData *)value;
- (void)addWhatContextGroupData:(NSSet *)values;
- (void)removeWhatContextGroupData:(NSSet *)values;

@end
