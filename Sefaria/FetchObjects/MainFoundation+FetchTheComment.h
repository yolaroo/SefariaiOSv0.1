//
//  MainFoundation+FetchTheComment.h
//  Sefaria
//
//  Created by MGM on 8/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (FetchTheComment)

- (NSArray*) fetchBookCommentForChapterByTextName : (TextTitle*) theTextTitle
                                withChapterNumber : (NSInteger) chapterNumber
                                      withContext : (NSManagedObjectContext*) context;

- (NSArray*) fetchAllComments : (NSManagedObjectContext*) context;


- (NSArray*) fetchCommentFromHebrewWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context;

- (NSArray*) fetchCommentFromEnglishWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context;


@end
