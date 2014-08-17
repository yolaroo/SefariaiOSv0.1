//
//  MainFoundation+CommentDataActions.h
//  Sefaria
//
//  Created by MGM on 7/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (CommentDataActions)

- (void) testCommentDataAction;
- (void) testTempCommentFetch;

- (void) allCommentTest : (NSManagedObjectContext*)context;

- (void) buildCoreDataStackForComments : (NSManagedObjectContext*)context;

- (void) testFetchCommentByText : (NSManagedObjectContext*)context;




@end
