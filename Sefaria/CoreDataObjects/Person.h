//
//  Person.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Job, LineText, Location, Struggle;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) Job *whatPersonalTitle;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) NSSet *whatLocation;
@property (nonatomic, retain) NSSet *whatStruggle;
@property (nonatomic, retain) NSSet *whatLineText;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatLocationObject:(Location *)value;
- (void)removeWhatLocationObject:(Location *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

- (void)addWhatStruggleObject:(Struggle *)value;
- (void)removeWhatStruggleObject:(Struggle *)value;
- (void)addWhatStruggle:(NSSet *)values;
- (void)removeWhatStruggle:(NSSet *)values;

- (void)addWhatLineTextObject:(LineText *)value;
- (void)removeWhatLineTextObject:(LineText *)value;
- (void)addWhatLineText:(NSSet *)values;
- (void)removeWhatLineText:(NSSet *)values;

@end
