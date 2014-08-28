//
//  ContextGroupComment.h
//  Sefaria
//
//  Created by MGM on 8/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContextGroup;

@interface ContextGroupComment : NSManagedObject

@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) ContextGroup *whatContextGroup;

@end
