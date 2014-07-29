//
//  Location.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LocationAuxName, LocationCoordinate, LocationDirectLine, LocationModernName, Picture, SatellitePicture;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *whatAuxName;
@property (nonatomic, retain) LocationCoordinate *whatCoordinate;
@property (nonatomic, retain) LocationDirectLine *whatDirectLine;
@property (nonatomic, retain) LocationModernName *whatModernName;
@property (nonatomic, retain) NSSet *whatPicture;
@property (nonatomic, retain) SatellitePicture *whatSatellitePicture;
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

@end
