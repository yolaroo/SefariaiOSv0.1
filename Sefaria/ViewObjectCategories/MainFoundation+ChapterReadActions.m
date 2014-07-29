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

@implementation MainFoundation (ChapterReadActions)


- (NSInteger) getChapterCount: (NSString*) myCellText withContext: (NSManagedObjectContext*) context
{
    TextTitle* myTextTitle = [[self fetchTextTitleByNameString: myCellText withContext: context]firstObject];
    return [myTextTitle.chapterCount integerValue];
}

//
////
//

- (NSArray*) menuFetchToZero : (NSManagedObjectContext*)context
{
    return  [self fetchBookTitleFromDepth: 0 withContext : context];
}

- (NSArray*) menuFetchFromClick : (NSString*) bookString withContext: (NSManagedObjectContext*) context
{
    NSArray* theList = [self fetchBookTitleForSubSet:bookString withContext:context];
    if ([self textCheck:theList]){
        self.isTextLevel = true;
        self.isBookLevel = false;    
    }
    else {
    }
    return theList;
}

- (bool) textCheck : (NSArray*) myArray {
    if ([[myArray firstObject] isKindOfClass:[BookTitle class]]) {
        self.isTextLevel = false;
        self.isBookLevel = true;
        self.theChapterMax = 0;
        return false;
    }
    else if ([[myArray firstObject] isKindOfClass:[TextTitle class]]) {
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
////
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
