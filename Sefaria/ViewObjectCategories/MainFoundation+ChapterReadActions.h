//
//  MainFoundation+ChapterReadActions.h
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (ChapterReadActions)

- (NSArray*) menuFetchToZero : (NSManagedObjectContext*)context;
- (NSArray*) menuFetchFromClick : (NSString*) bookString withContext: (NSManagedObjectContext*) context;

- (NSInteger) getChapterCount: (NSString*) myCellText withContext: (NSManagedObjectContext*) context;

- (NSArray*) fetchCommentByTextAndChapter : (NSString*) theTextName
                              withChapter : (NSInteger) theChapter
                              withContext : (NSManagedObjectContext*) context;

- (void) chapterReadBackMenuActionStatus;
- (void) smallChapterMenuReadBackMenuActionStatus;


@end
