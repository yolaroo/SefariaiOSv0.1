//
//  MainFoundation+FetchTheBookTitle.h
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"
#import "BookTitle.h"

@interface MainFoundation (FetchTheBookTitle)


- (NSArray*) fetchBookTitleByNameString:(NSString*) theName withContext: (NSManagedObjectContext*) context;

- (void) testFetchBookTitle: (NSManagedObjectContext*) context;

- (NSArray*) fetchBookTitleFromDepth: (NSInteger) depthNumber withContext :(NSManagedObjectContext*) context;

- (NSArray*) fetchBookTitleForSubSet : (NSString*) theName withContext :(NSManagedObjectContext*) context;

@end
