//
//  MainFoundation+CoreDataBuilderForGeneralTitles.m
//  Sefaria
//
//  Created by MGM on 8/10/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+CoreDataBuilderForGeneralTitles.h"

#import "BookTitle+Create.h"
#import "TextTitle+Create.h"

#import "FileRecursion.h"

#import "CompleteBookClass.h"

#import "BookListDataModel.h"

#import "MainFoundation+FetchTheTextTitle.h"

@implementation MainFoundation (CoreDataBuilderForGeneralTitles)

#define ROOT_DIRECTORY @"TextData/Mishnah"

#define DK 2
#define LOG if(DK == 1)


//
//
////
#pragma mark - Book Title
////
//
//

- (void) buildMishnahBookTitles  : (NSManagedObjectContext*) context
{
    NSLog(@"Load Start - Mishnah");
    FileRecursion* myFileRecursionMenu = [[FileRecursion alloc]init];
    NSInteger theDepth = 0;
    NSArray* theInitialPathArray = [myFileRecursionMenu returnPath: @"TextData/Mishnah"];
    BookTitle* mySuperBooktitle = [BookTitle newBookTitle : theDepth withEnglishName : @"Mishnah" withHebrewName : @"מִשְׁנָה" withContext : context];
    if ([self peakForTextLevelStatus:theInitialPathArray withFileRecursion:myFileRecursionMenu]) {
        //make TextTitle
    }
    else {
        [self createBookSet:theInitialPathArray withBooktitle: mySuperBooktitle withDepth:theDepth+1 withFileRecursion:myFileRecursionMenu withContext:context];
    }
    [self saveData:context];
    NSLog(@"Done Mishnah");
}

//
////
//

- (void) createTextSet : (NSString*)textTitle
         withBookTitle : (BookTitle*) myBooktitle
             withDepth : (NSInteger) theDepth
      withDisplayOrder : (NSInteger) myDisplayOrder
           withContext : (NSManagedObjectContext*) context {
    NSLog(@"-- The textTitle %@ --",textTitle);
    TextTitle*myText = [TextTitle newTextTitle:theDepth withEnglishName:textTitle withHebrewName:@"" withContext:context];
    
    myText.displayOrder = [NSNumber numberWithInteger:myDisplayOrder];
    myText.whatBookTitle = myBooktitle;
}

- (void) createBookSet : (NSArray*) thePathArray
         withBooktitle : (BookTitle*) mySuperBooktitle
             withDepth : (NSInteger) theDepth
     withFileRecursion : (FileRecursion*)myFileRecursionMenu
           withContext : (NSManagedObjectContext*) context {
    
    NSMutableArray *myBookArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [[thePathArray firstObject] count]; i++){
        NSString* thePathName = [[thePathArray firstObject] objectAtIndex:i];
        NSLog(@"-- Book Title Name %@ --",thePathName);
        BookTitle* myTitle = [self writeBookTitle:thePathName withDepth:theDepth withDisplayOrder:i withContext:context];
        
        NSArray* theNewNextPath = [myFileRecursionMenu returnPath: [[thePathArray lastObject] objectAtIndex:i]];
        
        if ([self peakForTextLevelStatus:theNewNextPath withFileRecursion:myFileRecursionMenu]) {
            NSLog(@"Is Text Level, Check");
            myTitle.hasTextTitleAsSubset = [NSNumber numberWithBool:TRUE];
            myTitle.isBookGroup = [NSNumber numberWithBool:TRUE];
            
            //create textTitle
            for (int j = 0; j < [[theNewNextPath firstObject] count]; j++){
                NSString* theNewPathName = [[theNewNextPath firstObject] objectAtIndex:j];
                NSLog(@"-- Text Title Name %@ --",theNewPathName);
                [self createTextSet:theNewPathName withBookTitle : myTitle withDepth : theDepth+1 withDisplayOrder : j withContext:context];
            }
        }
        else {
            NSLog(@"Is Not Text Level, Check");
            myTitle.hasTextTitleAsSubset = [NSNumber numberWithBool:false];
            myTitle.hasBookTitleAsSubset = [NSNumber numberWithBool:TRUE];
            myTitle.isBookGroup = [NSNumber numberWithBool:TRUE];
            
            //create bookTitle loop
            [self createBookSet:theNewNextPath withBooktitle: myTitle withDepth:theDepth+1 withFileRecursion:myFileRecursionMenu withContext:context];
        }
        // add to subset
        [myBookArray addObject:myTitle];
    }
    if ([myBookArray count]){
        mySuperBooktitle.whatBookTitleSub = [NSSet setWithArray:myBookArray];
        mySuperBooktitle.hasBookTitleAsSubset = [NSNumber numberWithBool:TRUE];
        mySuperBooktitle.isBookGroup = [NSNumber numberWithBool:TRUE];
    }
}

- (BookTitle*) writeBookTitle : (NSString*) name
                    withDepth : (NSInteger) theDepth
             withDisplayOrder : (NSInteger) myDisplayOrder
                  withContext : (NSManagedObjectContext*) context {
    BookTitle* myBooktitle = [BookTitle newBookTitle : theDepth withEnglishName : name withHebrewName : @"" withContext : context];
    myBooktitle.displayOrder = [NSNumber numberWithInteger: myDisplayOrder];
    return myBooktitle;
}

//
////
//

- (bool) peakForTextLevelStatus : (NSArray*) thePath withFileRecursion : (FileRecursion*)myFileRecursionMenu {
    for (int i = 0; i < [[thePath firstObject] count]; i++) {
        NSArray*theNewNextPath = [myFileRecursionMenu returnPath: [[thePath lastObject] objectAtIndex:i]];
        if ([self pathUnwrapCheckHebrew : [theNewNextPath lastObject]]) {
            NSLog(@"** peak path hebrew %@ **",[theNewNextPath lastObject]);
            return true;
        }
        if ([self pathUnwrapCheckEnglish : [theNewNextPath lastObject]]) {
            NSLog(@"** peak path english %@ **",[theNewNextPath lastObject]);
            return true;
        }
    }
    return false;
}


//
////
//

- (bool) pathUnwrapCheckHebrew : (NSArray*)  thePath {
    if ([thePath count] == 0) return false;
    for (int i = 0; i < [thePath count]; i++){
        NSString* myObject = [thePath objectAtIndex:i];
        if ([myObject hasSuffix:@"Hebrew"]) {
            //NSLog(@"-- myObject peek is Hebrew %@ --",myObject);
            return true;
        }
    }
    return false;
}

- (bool) pathUnwrapCheckEnglish : (NSArray*)  thePath {
    if ([thePath count] == 0) return false;
    for (int i = 0; i < [thePath count]; i++){
        NSString* myObject = [thePath objectAtIndex:i];
        if ([myObject hasSuffix:@"English"]) {
            //NSLog(@"-- myObject peek is English %@ --",myObject);
            return true;
        }
    }
    return false;
}










//
//
////
#pragma mark - Test
////
//
//


- (void) testBookTitleWriterForCoreData : (NSManagedObjectContext*)context
{
    NSLog(@"Load Start");
    
    FileRecursion* myFileRecursionMenu = [[FileRecursion alloc]init];
    NSArray* theInitialPathArray = [myFileRecursionMenu returnPath: ROOT_DIRECTORY];
    
    
    NSLog(@"-- theInitialPathArray %@ --",[theInitialPathArray firstObject]);
    
    [self testRecursiveWriter : theInitialPathArray
            withFileRecursion : myFileRecursionMenu
                    withDepth : 1];
    
}

//
////
//

- (void) testRecursiveWriter : (NSArray*) thePath withFileRecursion : (FileRecursion*)myFileRecursionMenu withDepth : (NSInteger) myDepth  {
    
    if (myDepth == 0) return;
    if ([thePath count] == 0) return;
    for (int i = 0; i < [[thePath firstObject] count]; i++) {
        
        NSArray* theNewNextPath = [myFileRecursionMenu returnPath: [[thePath lastObject] objectAtIndex:i]];
        
        [self testRecursiveWriter : theNewNextPath
                withFileRecursion : myFileRecursionMenu
                        withDepth : myDepth-1];
    }
}


//
////
//

- (bool) generalArrayUnWrap: (NSArray*) theArray {
    for (int i = 0; i < [theArray count]; i++){
        id myObject = [theArray objectAtIndex:i];
        if ([myObject isKindOfClass:[NSString class]]){
            if ([myObject hasSuffix:@"merged.json"]) {
                NSLog(@"-- myObject : %@ --",myObject);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    return false;
}

//
////
//

- (void) testOutlineBookTitleWriterForCoreData : (NSManagedObjectContext*)context {
    NSLog(@"Load Start");
    FileRecursion*myFileRecursionMenu = [[FileRecursion alloc]init];
    
    //make mishnah
    
    NSArray*theLevelName1 = [[myFileRecursionMenu returnPath: ROOT_DIRECTORY] firstObject];
    NSArray*theLevelPath1 = [[myFileRecursionMenu returnPath: ROOT_DIRECTORY] lastObject];
    
    //NSLog(@"-- MFRM %@ --",theLevelName1);
    //NSLog(@"-- --");
    
    for (int i = 0; i < [theLevelName1 count]; i++){
        NSArray*theLevelName2 = [[myFileRecursionMenu returnPath: [theLevelPath1 objectAtIndex:i]] firstObject];
        NSArray*theLevelPath2 = [[myFileRecursionMenu returnPath: [theLevelPath1 objectAtIndex:i]] lastObject];
        
        //NSLog(@"-- theLevelName2 %@ --",theLevelName2);
        //NSLog(@"-- --");
        
        for (int j = 0; j < [theLevelName2 count]; j++){
            NSArray*theLevelName3 = [[myFileRecursionMenu returnPath: [theLevelPath2 objectAtIndex:j]] firstObject];
            NSArray*theLevelPath3 = [[myFileRecursionMenu returnPath: [theLevelPath2 objectAtIndex:j]] lastObject];
            //NSLog(@"-- theLevelName3 %@ --",theLevelName3);
            //NSLog(@"-- --");
            [self generalArrayUnWrap:theLevelName3];
            
            for (int k = 0; k < [theLevelName3 count]; k++){
                NSArray*theLevelName4 = [[myFileRecursionMenu returnPath: [theLevelPath3 objectAtIndex:k]] firstObject];
                [self generalArrayUnWrap:theLevelName4];
            }
        }
    }
}

//
/////
//

- (void) testMishnah : (NSManagedObjectContext*) context {
    CompleteBookClass*myBookClass = [[CompleteBookClass alloc]init];
    NSArray* mishnahArray = [myBookClass completeMishnahFileLocation];
    //NSLog(@"-- %@ --",mishnahArray);
    
    NSString* textName = [mishnahArray objectAtIndex:0];
    //NSLog(@"-- TTN %@ --",textName);
    
    BookListDataModel* textData = [BookListDataModel myNewDataLoader:textName];
    //NSArray* myTextArray = textData.theCompleteTextArray;
    //NSLog(@"-- %@ --",myTextArray);
    
    //NSString* hebrewTitle = textData.theHebrewTitle;
    NSString* englishTitle = textData.theTitle;
    
    TextTitle* aTextTitle = [[self fetchTextTitleByNameString: englishTitle withContext:context]firstObject];
    NSLog(@"-- TEN %@ --",aTextTitle.englishName);
    
    if (aTextTitle.englishName == nil) {
        NSLog(@"-- Nil %@ --",englishTitle);
    }
    else {
        NSLog(@"-- TEN %@ --",aTextTitle.englishName);
    }
    
}



@end
