//
//  TextVersionTitle.h
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LineText;

@interface TextVersionTitle : NSManagedObject

@property (nonatomic, retain) NSString * attributedDate;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatLine;
@end

@interface TextVersionTitle (CoreDataGeneratedAccessors)

- (void)addWhatLineObject:(LineText *)value;
- (void)removeWhatLineObject:(LineText *)value;
- (void)addWhatLine:(NSSet *)values;
- (void)removeWhatLine:(NSSet *)values;

@end
