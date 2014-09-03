//
//  Searches.h
//  Sefaria
//
//  Created by MGM on 9/2/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Searches : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSNumber * displayOrder;

@end
