//
//  Location.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, LocationAuxName, LocationCoordinate, LocationModernName, Person, Picture, SatellitePicture, Struggle;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *whatAuxName;
@property (nonatomic, retain) LocationCoordinate *whatCoordinate;
@property (nonatomic, retain) LocationModernName *whatModernName;
@property (nonatomic, retain) NSSet *whatPicture;
@property (nonatomic, retain) SatellitePicture *whatSatellitePicture;
@property (nonatomic, retain) NSSet *whatPerson;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) NSSet *whatStruggle;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addWhatAuxNameObject:(LocationAuxName *)value;
- (void)removeWhatAuxNameObject:(LocationAuxName *)value;
- (void)addWhatAuxName:(NSSet *)values;
- (void)removeWhatAuxName:(NSSet *)values;

- (void)addWhatPictureObject:(Picture *)value;
- (void)removeWhatPictureObject:(Picture *)value;
- (void)addWhatPicture:(NSSet *)values;
- (void)removeWhatPicture:(NSSet *)values;

- (void)addWhatPersonObject:(Person *)value;
- (void)removeWhatPersonObject:(Person *)value;
- (void)addWhatPerson:(NSSet *)values;
- (void)removeWhatPerson:(NSSet *)values;

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatStruggleObject:(Struggle *)value;
- (void)removeWhatStruggleObject:(Struggle *)value;
- (void)addWhatStruggle:(NSSet *)values;
- (void)removeWhatStruggle:(NSSet *)values;

@end
