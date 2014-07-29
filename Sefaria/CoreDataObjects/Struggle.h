//
//  Struggle.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class StruggleLocation, StrugglePerson, StuggleDirectLine;

@interface Struggle : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) StuggleDirectLine *whatLine;
@property (nonatomic, retain) StruggleLocation *whatLocation;
@property (nonatomic, retain) NSSet *whatPerson;
@end

@interface Struggle (CoreDataGeneratedAccessors)

- (void)addWhatPersonObject:(StrugglePerson *)value;
- (void)removeWhatPersonObject:(StrugglePerson *)value;
- (void)addWhatPerson:(NSSet *)values;
- (void)removeWhatPerson:(NSSet *)values;

@end
