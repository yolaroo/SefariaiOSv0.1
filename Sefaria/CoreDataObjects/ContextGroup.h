//
//  ContextGroup.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContextGroupData;

@interface ContextGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subTitle;
@property (nonatomic, retain) NSSet *whatData;
@end

@interface ContextGroup (CoreDataGeneratedAccessors)

- (void)addWhatDataObject:(ContextGroupData *)value;
- (void)removeWhatDataObject:(ContextGroupData *)value;
- (void)addWhatData:(NSSet *)values;
- (void)removeWhatData:(NSSet *)values;

@end
