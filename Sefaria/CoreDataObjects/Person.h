//
//  Person.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job, PersonEvent, PersonEventDirectLine, PersonLocation;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) PersonEventDirectLine *whatDirectLine;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) Job *whatJob;
@property (nonatomic, retain) NSSet *whatLocation;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addWhatEventObject:(PersonEvent *)value;
- (void)removeWhatEventObject:(PersonEvent *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatLocationObject:(PersonLocation *)value;
- (void)removeWhatLocationObject:(PersonLocation *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

@end
