//
//  Picture.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *whatLocation;
@end

@interface Picture (CoreDataGeneratedAccessors)

- (void)addWhatLocationObject:(Location *)value;
- (void)removeWhatLocationObject:(Location *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

@end
