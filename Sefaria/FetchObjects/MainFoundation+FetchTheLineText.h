//
//  MainFoundation+FetchTheLineText.h
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

#import "LineText.h"
#import "TextTitle.h"

@interface MainFoundation (FetchTheLineText)

- (NSArray*) fetchLineTextByAttributes: (TextTitle*) theTextTitle withLineNumber: (NSInteger) lineNumber  withChapterNumber: (NSInteger) chapterNumber withContext: (NSManagedObjectContext*) context;

- (NSArray*) fetchLineTextFromEnglishWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context;
- (NSArray*) fetchLineTextFromHebrewWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context;

- (NSArray*) fetchAllLineText : (NSManagedObjectContext*) context;

- (NSArray*) fetchAllBookMarkedLineText : (NSManagedObjectContext*) context;
- (NSArray*) fetchAllBookMarkedChapterLineText : (NSManagedObjectContext*) context;


@end
