//
//  BookGroup.h
//  Sefaria
//
//  Created by MGM on 8/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookTitle, LineText, TextTitle;

@interface BookGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSString * hebrewName;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatBookTitle;
@property (nonatomic, retain) NSSet *whatLine;
@property (nonatomic, retain) NSSet *whatTextTitle;
@end

@interface BookGroup (CoreDataGeneratedAccessors)

- (void)addWhatBookTitleObject:(BookTitle *)value;
- (void)removeWhatBookTitleObject:(BookTitle *)value;
- (void)addWhatBookTitle:(NSSet *)values;
- (void)removeWhatBookTitle:(NSSet *)values;

- (void)addWhatLineObject:(LineText *)value;
- (void)removeWhatLineObject:(LineText *)value;
- (void)addWhatLine:(NSSet *)values;
- (void)removeWhatLine:(NSSet *)values;

- (void)addWhatTextTitleObject:(TextTitle *)value;
- (void)removeWhatTextTitleObject:(TextTitle *)value;
- (void)addWhatTextTitle:(NSSet *)values;
- (void)removeWhatTextTitle:(NSSet *)values;

@end
