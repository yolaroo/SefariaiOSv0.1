//
//  Event.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventContextualLine, EventDirectLine, EventPerson;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) EventContextualLine *whatContextualLine;
@property (nonatomic, retain) EventDirectLine *whatDirectLine;
@property (nonatomic, retain) EventPerson *whatPerson;

@end
