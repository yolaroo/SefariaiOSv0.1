//
//  StruggleLocation.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Struggle;

@interface StruggleLocation : NSManagedObject

@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatStruggle;
@end

@interface StruggleLocation (CoreDataGeneratedAccessors)

- (void)addWhatStruggleObject:(Struggle *)value;
- (void)removeWhatStruggleObject:(Struggle *)value;
- (void)addWhatStruggle:(NSSet *)values;
- (void)removeWhatStruggle:(NSSet *)values;

@end
