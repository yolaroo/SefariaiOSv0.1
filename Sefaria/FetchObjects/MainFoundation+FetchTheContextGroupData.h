//
//  MainFoundation+FetchTheContextGroupData.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (FetchTheContextGroupData)

- (NSArray*) fetchAllContextGroupData : (NSManagedObjectContext*) context;

@end
