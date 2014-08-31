//
//  ContextGroup+Create.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroup.h"

@interface ContextGroup (Create)

+ (ContextGroup*) newContextGroup : (NSString*) theTitle
                     withSubTitle : (NSString*) theSubTitle
                      withContext : (NSManagedObjectContext*) context;

@end
