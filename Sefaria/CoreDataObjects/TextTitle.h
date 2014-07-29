//
//  TextTitle.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookGroup, BookTitle, LineText;

@interface TextTitle : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterCount;
@property (nonatomic, retain) NSNumber * depthOrderLevel;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSString * hebrewName;
@property (nonatomic, retain) NSNumber * isEnglish;
@property (nonatomic, retain) NSNumber * isHebrew;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatBookGroup;
@property (nonatomic, retain) BookTitle *whatBookTitle;
@property (nonatomic, retain) NSSet *whatLineText;
@end

@interface TextTitle (CoreDataGeneratedAccessors)

- (void)addWhatBookGroupObject:(BookGroup *)value;
- (void)removeWhatBookGroupObject:(BookGroup *)value;
- (void)addWhatBookGroup:(NSSet *)values;
- (void)removeWhatBookGroup:(NSSet *)values;

- (void)addWhatLineTextObject:(LineText *)value;
- (void)removeWhatLineTextObject:(LineText *)value;
- (void)addWhatLineText:(NSSet *)values;
- (void)removeWhatLineText:(NSSet *)values;

@end