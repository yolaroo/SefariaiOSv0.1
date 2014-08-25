//
//  MainFoundation+SeachTextActions.m
//  Sefaria
//
//  Created by MGM on 8/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SeachTextActions.h"

#import "MainFoundation+FetchTheComment.h"
#import "MainFoundation+FetchTheLineText.h"


@implementation MainFoundation (SeachTextActions)


//
//
////////
#pragma mark - Search Action
////////
//
//


- (NSString*) combinedCommentSearch : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchCommentFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchCommentFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    if (self.isSelectionComments && self.isSelectionText) {
        
    }
    else {
        [self.searchTextArray removeAllObjects];
        [self.searchInfoArray removeAllObjects];
    }
    
    for (Comment* TLT in myHebrewEntries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.hebrewName;
        
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        [self.searchTextArray addObject:TLT.hebrewText];
        [self.searchInfoArray addObject:myTextInfo];
    }
    
    for (Comment* TLT in myEnglishEntries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* theAuthor = TLT.whatAuthor.name;
        
        NSString* text = title.englishName;
        NSString* myTextInfo = [NSString stringWithFormat:@"%@ on %@ Chapter: %ld Line: %ld",theAuthor,text,(long)chapter,(long)line];
        [self.searchTextArray addObject:TLT.englishText];
        [self.searchInfoArray addObject:myTextInfo];
    }
    
    NSString* myCountString = [NSString stringWithFormat:@"Word Count: %lu",(unsigned long)[self.searchTextArray count]];
    return myCountString;
}

- (NSString*) combinedTextSearch : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchLineTextFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchLineTextFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    [self.searchTextArray removeAllObjects];
    [self.searchInfoArray removeAllObjects];
    
    for (LineText* TLT in myHebrewEntries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.hebrewName;
        
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        [self.searchTextArray addObject:TLT.hebrewText];
        [self.searchInfoArray addObject:myTextInfo];
    }
    
    for (LineText* TLT in myEnglishEntries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.englishName;
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        [self.searchTextArray addObject:TLT.englishText];
        [self.searchInfoArray addObject:myTextInfo];
    }
    
    NSString* myCountString = [NSString stringWithFormat:@"Word Count: %lu",(unsigned long)[self.searchTextArray count]];
    return myCountString;
}


//
//
////////
#pragma mark - Test
////////
//
//

- (void) testSearch {
    NSArray*myentries = [self fetchLineTextFromEnglishWordSearch:@"lord" withContext : self.managedObjectContext];
    for (LineText* TLT in myentries) {
        NSInteger line = [TLT.lineNumber integerValue];
        NSInteger chapter = [TLT.chapterNumber integerValue];
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.englishName;
        NSLog(@"-- Text: %@ Chapter %ld Line %ld --",text,(long)chapter,(long)line);
        NSLog(@"-- %@ --",TLT.englishText);
    }
}


@end
