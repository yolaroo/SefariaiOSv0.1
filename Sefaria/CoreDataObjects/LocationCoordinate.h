//
//  LocationCoordinate.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface LocationCoordinate : NSManagedObject

@property (nonatomic, retain) NSNumber * isLocationAmbiguous;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * secondaryPosition;
@property (nonatomic, retain) Location *whatLocation;

@end
