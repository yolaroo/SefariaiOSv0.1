//
//  MainFoundation+FetchSearchTitles.h
//  Sefaria
//
//  Created by MGM on 9/2/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (FetchSearchTitles)

- (NSArray*) fetchAllSearchTitles : (NSManagedObjectContext*) context;

@end
