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

#import "Searches+Create.h"
#import "MainFoundation+FetchSearchTitles.h"

@implementation MainFoundation (SeachTextActions)


//
//
////////
#pragma mark - Create Search Title Object
////////
//
//

- (void) createSearchTitle : (NSManagedObjectContext*) context
{
    NSLog(@"create search object");
    Searches* newSearch = [Searches newSearchTitle:self.theSearchTerm withContext:context];
    newSearch.displayOrder = [NSNumber numberWithInteger : [self.searchTitlesArray count] + 1];
    [self saveData:context];
}

- (void) fetchSearchTitleDataArray : (NSManagedObjectContext*) context
{
    self.searchTitlesArray = [self fetchAllSearchTitles : context];
}

//
//
////
#pragma mark - bookMarkActions
////
//
//

- (void) addBookMarkValueToSearchText : (UITableView*) tableView withLineText : (LineText*) myLineText withIndexPath : (NSIndexPath *)indexPath withContext : (NSManagedObjectContext*) context
{
    if (!self.bookmarkSet) return;
    NSLog(@"bookmark press");
    bool isBookMarked = [myLineText.isBookmarked boolValue];
    myLineText.isBookmarked = [NSNumber numberWithBool:!isBookMarked];
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
    [self saveData:context];
}

//
//
////////
#pragma mark - Search Action
////////
//
//

- (NSString*) searchDataSetterForTextOnly : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchLineTextFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchLineTextFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    NSString* myCountString = [NSString stringWithFormat:@"  Word Count: %lu",(unsigned long)[self.searchLineDataArray count]];
    return myCountString;
}

- (NSString*) searchDataSetterForCommentsOnly : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchCommentFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchCommentFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    NSString* myCountString = [NSString stringWithFormat:@"  Word Count: %lu",(unsigned long)[self.searchLineDataArray count]];
    return myCountString;
}

- (NSString*) searchDataSetterForAllCases : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchLineTextFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchLineTextFromEnglishWordSearch:myString withContext : self.managedObjectContext];

    NSArray*myHebrewComments = [self fetchCommentFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishComments = [self fetchCommentFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    [completeArray addObjectsFromArray : myHebrewComments];
    [completeArray addObjectsFromArray : myEnglishComments];

    self.searchLineDataArray = [completeArray copy];
    
    NSString* myCountString = [NSString stringWithFormat:@"  Word Count: %lu",(unsigned long)[self.searchLineDataArray count]];
    return myCountString;
}

//
////
//

- (NSArray*) combinedTextSearchLineWrite : (NSObject*) myObject
{
    if ([myObject isKindOfClass:[LineText class]]){
        return [self extractLineText : (LineText*) myObject];
    }
    
    if ([myObject isKindOfClass:[Comment class]]){
        return [self extractCommentText : (Comment*) myObject];
    }
    else {
        NSLog(@"error on search mapping");
        return nil;
    }
}

//
////
//

- (NSArray*) extractCommentText : (Comment*) myCommentText {

    NSInteger line = [myCommentText.lineNumber integerValue]+1;
    NSInteger chapter = [myCommentText.chapterNumber integerValue]+1;
    TextTitle* title = myCommentText.whatTextTitle;
    NSString* theAuthor = myCommentText.whatAuthor.name;
    
    NSString* textTitleEnglish = title.englishName;
    NSString* textTitleHebrew = title.hebrewName;

    NSString* theEnglishString = myCommentText.englishText;
    NSString* theHebrewString = myCommentText.hebrewText;

    NSString* combinedLanguageString = [NSString stringWithFormat:@"%@\n\n%@",theHebrewString,theEnglishString];
    if ([myCommentText.isBookmarked boolValue]){
        combinedLanguageString = [combinedLanguageString stringByAppendingString:@" ✓"];
    }
    else {
        //
    }
    NSString* myTextInfo = [NSString stringWithFormat:@"%@ on %@ %@ - Chapter: %ld Line: %ld",theAuthor,textTitleHebrew,textTitleEnglish,(long)chapter,(long)line];
    return @[combinedLanguageString,myTextInfo];
}

- (NSArray*) extractLineText : (LineText*) myLineText {
    NSInteger line = [myLineText.lineNumber integerValue]+1;
    NSInteger chapter = [myLineText.chapterNumber integerValue]+1;
    TextTitle* title = myLineText.whatTextTitle;
    
    NSString* textTitleHebrew = title.englishName;
    NSString* textTitleEnglish = title.hebrewName;
    
    NSString* theEnglishString = myLineText.englishText;
    NSString* theHebrewString = myLineText.hebrewText;
    NSString* combinedLanguageString = [NSString stringWithFormat:@"%@\n\n%@",theHebrewString,theEnglishString];
    if ([myLineText.isBookmarked boolValue]){
        combinedLanguageString = [combinedLanguageString stringByAppendingString:@" ✓"];
    }
    else {
        //
    }
    
    NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ - %@ Chapter: %ld Line: %ld",textTitleEnglish, textTitleHebrew,(long)chapter,(long)line];
    return @[combinedLanguageString,myTextInfo];
}












//
//
////////
#pragma mark - Test
////////
//
//


- (NSString*) combinedCommentSearchTest : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchCommentFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchCommentFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    if (self.isSelectionComments && self.isSelectionText) {
        //empty
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



- (NSString*) combinedTextSearchTest : (NSString*) myString
{
    NSArray*myHebrewEntries = [self fetchLineTextFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    NSArray*myEnglishEntries = [self fetchLineTextFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    NSMutableArray * completeArray = [[NSMutableArray alloc] initWithArray:myHebrewEntries];
    [completeArray addObjectsFromArray : myEnglishEntries];
    self.searchLineDataArray = [completeArray copy];
    
    [self.searchTextArray removeAllObjects];
    [self.searchInfoArray removeAllObjects];
    
    for (LineText* TLT in myHebrewEntries) {
        //TLT.isEnglish
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
        
        NSString* theString = TLT.englishText;
        if ([TLT.isBookmarked boolValue]){
            theString = [theString stringByAppendingString:@" ✓"];
        }
        else {
            //
        }
        
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        [self.searchTextArray addObject:theString];
        [self.searchInfoArray addObject:myTextInfo];
    }
    
    NSString* myCountString = [NSString stringWithFormat:@"Word Count: %lu",(unsigned long)[self.searchTextArray count]];
    return myCountString;
}

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
