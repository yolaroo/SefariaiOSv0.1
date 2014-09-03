//
//  Searches+Create.h
//  Sefaria
//
//  Created by MGM on 9/2/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Searches.h"

@interface Searches (Create)

+ (Searches*) newSearchTitle : (NSString*) theTitle
                 withContext : (NSManagedObjectContext*) context;

@end
