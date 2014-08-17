//
//  MainFoundation+FetchTheTextTitle.h
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

#import "TextTitle.h"
#import "BookTitle.h"

@interface MainFoundation (FetchTheTextTitle)

- (NSArray*) fetchTextTitleByNameString:(NSString*) theName withContext: (NSManagedObjectContext*) context;

- (NSArray*) fetchTextTitleByBookTitleObject:(BookTitle*) theBookTitle withContext: (NSManagedObjectContext*) context;

- (void) testFetchTextTitle : (NSManagedObjectContext*) context;


@end
