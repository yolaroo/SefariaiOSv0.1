//
//  BattleLocation.h
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Battle;

@interface BattleLocation : NSManagedObject

@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatStruggle;
@end

@interface BattleLocation (CoreDataGeneratedAccessors)

- (void)addWhatStruggleObject:(Battle *)value;
- (void)removeWhatStruggleObject:(Battle *)value;
- (void)addWhatStruggle:(NSSet *)values;
- (void)removeWhatStruggle:(NSSet *)values;

@end
