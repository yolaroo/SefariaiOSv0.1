//
//  Battle.h
//  Sefaria
//
//  Created by MGM on 7/26/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BattleLocation, BattlePerson, StuggleLine;

@interface Battle : NSManagedObject

@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) StuggleLine *whatLine;
@property (nonatomic, retain) BattleLocation *whatLocation;
@property (nonatomic, retain) NSSet *whatPerson;
@end

@interface Battle (CoreDataGeneratedAccessors)

- (void)addWhatPersonObject:(BattlePerson *)value;
- (void)removeWhatPersonObject:(BattlePerson *)value;
- (void)addWhatPerson:(NSSet *)values;
- (void)removeWhatPerson:(NSSet *)values;

@end
