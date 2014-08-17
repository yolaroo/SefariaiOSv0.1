//
//  MainFoundation+FetchTheCommentCollectionTitle.h
//  Sefaria
//
//  Created by MGM on 8/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (FetchTheCommentCollectionTitle)

- (NSArray*) fetchAllCommentCollectionTitles : (NSManagedObjectContext*) context;

@end
