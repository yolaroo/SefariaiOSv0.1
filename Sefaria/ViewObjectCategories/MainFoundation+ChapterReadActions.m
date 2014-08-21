//
//  MainFoundation+ChapterReadActions.m
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+ChapterReadActions.h"

#import "MainFoundation+FetchTheBookTitle.h"
#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheComment.h"

@implementation MainFoundation (ChapterReadActions)

#define DK 2
#define LOG if(DK == 1)


//
//
////////
#pragma mark - Fetch Comment
////////
//
//


- (NSArray*) fetchCommentByTextAndChapter : (NSString*) theTextName
                              withChapter : (NSInteger) theChapter
                              withContext : (NSManagedObjectContext*) context
{
    if ([theTextName length]) {
        TextTitle* mytextTitle = [[self fetchTextTitleByNameString:theTextName withContext:context]firstObject];
        if (mytextTitle != nil) {
            return [self fetchBookCommentForChapterByTextName:mytextTitle withChapterNumber:theChapter withContext:context];
        } else {
            NSLog(@"Error comment fetch");
        }
    } else {
        NSLog(@"Error comment fetch text");
    }
    NSLog(@"");
    return nil;
}

//
////
//

- (NSInteger) getChapterCount: (NSString*) myCellText withContext: (NSManagedObjectContext*) context
{
    TextTitle* myTextTitle = [[self fetchTextTitleByNameString: myCellText withContext: context]firstObject];
    return [myTextTitle.chapterCount integerValue];
}

//
//
////////
#pragma mark - Fetch at Zero
////////
//
//

- (NSArray*) menuFetchToZero : (NSManagedObjectContext*)context
{
    return  [self fetchBookTitleFromDepth: 0 withContext : context];
}

- (NSArray*) menuFetchFromClick : (NSString*) bookString withContext: (NSManagedObjectContext*) context
{
    LOG NSLog(@"-- TBS %@ --",bookString);
    NSArray* theList = [self fetchBookTitleForSubSet:bookString withContext:context];
    LOG NSLog(@"-- TL %@ --",theList);
    if ([self textCheck:theList]){
        self.isTextLevel = true;
        self.isBookLevel = false;    
    }
    else {
    }
    return theList;
}

- (bool) textCheck : (NSArray*) myArray {
    LOG NSLog(@"-- pressed text check %@ --",myArray);
    
    if ([[myArray firstObject] isKindOfClass:[BookTitle class]]) {
        LOG NSLog(@"is book title");
        self.isTextLevel = false;
        self.isBookLevel = true;
        self.theChapterMax = 0;
        return false;
    }
    else if ([[myArray firstObject] isKindOfClass:[TextTitle class]]) {
        LOG NSLog(@"is text title");
        
        //TextTitle* myText = [myArray firstObject];
        //NSLog(@"-- MTA %@ --",myText.englishName);
        //self.theChapterMax = [myText.chapterCount integerValue];
        //NSLog(@"-- SCM %d --",[myText.chapterCount integerValue]);
        return true;
    }
    else {
        return false;
    }
}


//
//
////////
#pragma mark - Menu State Setter
////////
//
//


- (void) chapterReadBackMenuActionStatus
{
    self.isTextLevel = false;
    self.isBookLevel = true;
    self.theChapterNumber = 0;
    self.theChapterMax = 0;
    if([self.menuChoiceArray count] == 1) {
        [self.menuChoiceArray removeLastObject];
        self.menuListArray = [self menuFetchToZero:self.managedObjectContext];
    }
    else {
        [self.menuChoiceArray removeLastObject];
        self.chapterListArray = @[];
        self.menuListArray = [self menuFetchFromClick:[self.menuChoiceArray lastObject] withContext:self.managedObjectContext];
    }
}












//
//
////////
#pragma mark - Test
////////
//
//


- (void) testBookTitleFetch: (NSManagedObjectContext*)context
{
    NSArray* test = [self fetchBookTitleFromDepth: 0 withContext : context];
    NSLog(@"-- BT %@--",test);
}

- (void) testBookTitleFetchFromName: (NSString*) bookString withContext: (NSManagedObjectContext*) context
{
    NSArray* bookTitleList = [self fetchBookTitleForSubSet:bookString withContext:context];
    if ([self testNames:bookTitleList]){
        // set value
    }
    else {
        //set value
    }
}

- (bool) testNames : (NSArray*) myArray {
    if ([[myArray firstObject] isKindOfClass:[BookTitle class]]) {
        for (BookTitle* BTL in myArray){
            NSLog(@"-- ENL %@--",BTL.englishName);
        }
        return false;
    }
    else if ([[myArray firstObject] isKindOfClass:[TextTitle class]]) {
        for (TextTitle* TTL in myArray){
            NSLog(@"-- ENL %@--",TTL.englishName);
        }
        return true;
    }
    else {
        return false;
    }
}

@end
