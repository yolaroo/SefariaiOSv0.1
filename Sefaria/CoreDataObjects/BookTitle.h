//
//  BookTitle.h
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookGroup, BookTitle, LineText, TextTitle;

@interface BookTitle : NSManagedObject

@property (nonatomic, retain) NSNumber * depthOrderLevel;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSNumber * hasBookTitleAsSubset;
@property (nonatomic, retain) NSNumber * hasTextTitleAsSubset;
@property (nonatomic, retain) NSString * hebrewName;
@property (nonatomic, retain) NSNumber * isBookGroup;
@property (nonatomic, retain) NSNumber * isEnglish;
@property (nonatomic, retain) NSNumber * isHebrew;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) BookGroup *whatBookGroup;
@property (nonatomic, retain) NSSet *whatBookTitleSub;
@property (nonatomic, retain) BookTitle *whatBookTitleSuper;
@property (nonatomic, retain) NSSet *whatLine;
@property (nonatomic, retain) NSSet *whatTextTitle;
@end

@interface BookTitle (CoreDataGeneratedAccessors)

- (void)addWhatBookTitleSubObject:(BookTitle *)value;
- (void)removeWhatBookTitleSubObject:(BookTitle *)value;
- (void)addWhatBookTitleSub:(NSSet *)values;
- (void)removeWhatBookTitleSub:(NSSet *)values;

- (void)addWhatLineObject:(LineText *)value;
- (void)removeWhatLineObject:(LineText *)value;
- (void)addWhatLine:(NSSet *)values;
- (void)removeWhatLine:(NSSet *)values;

- (void)addWhatTextTitleObject:(TextTitle *)value;
- (void)removeWhatTextTitleObject:(TextTitle *)value;
- (void)addWhatTextTitle:(NSSet *)values;
- (void)removeWhatTextTitle:(NSSet *)values;

@end
