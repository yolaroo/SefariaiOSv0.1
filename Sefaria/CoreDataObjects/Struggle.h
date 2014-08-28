//
//  Struggle.h
//  Sefaria
//
//  Created by MGM on 8/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, LineText, Location, Person;

@interface Struggle : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) NSSet *whatLineText;
@property (nonatomic, retain) NSSet *whatLocation;
@property (nonatomic, retain) NSSet *whatPerson;
@end

@interface Struggle (CoreDataGeneratedAccessors)

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatLineTextObject:(LineText *)value;
- (void)removeWhatLineTextObject:(LineText *)value;
- (void)addWhatLineText:(NSSet *)values;
- (void)removeWhatLineText:(NSSet *)values;

- (void)addWhatLocationObject:(Location *)value;
- (void)removeWhatLocationObject:(Location *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

- (void)addWhatPersonObject:(Person *)value;
- (void)removeWhatPersonObject:(Person *)value;
- (void)addWhatPerson:(NSSet *)values;
- (void)removeWhatPerson:(NSSet *)values;

@end
