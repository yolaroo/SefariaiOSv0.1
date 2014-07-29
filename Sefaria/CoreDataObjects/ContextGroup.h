//
//  ContextGroup.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContextCenter, ContextLine;

@interface ContextGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) ContextCenter *whatContextCenter;
@property (nonatomic, retain) NSSet *whatContextLine;
@end

@interface ContextGroup (CoreDataGeneratedAccessors)

- (void)addWhatContextLineObject:(ContextLine *)value;
- (void)removeWhatContextLineObject:(ContextLine *)value;
- (void)addWhatContextLine:(NSSet *)values;
- (void)removeWhatContextLine:(NSSet *)values;

@end
