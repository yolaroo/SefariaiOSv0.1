//
//  MainFoundation+CoreDataBuilderForGeneralExtraction.m
//  Sefaria
//
//  Created by MGM on 8/8/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+CoreDataBuilderForGeneralExtraction.h"
#import "MainFoundation+CoreDataBuilderForGeneralTitles.h"

//
////
//

#import "MainFoundation+ActionsForAdvancedText.h"

#import "FileRecursion.h"

#import "LineText+Create.h"

#import "MainFoundation+FetchTheBookTitle.h"
#import "MainFoundation+FetchTheLineText.h"
#import "MainFoundation+FetchTheTextTitle.h"

#import "BookListDataModel.h"
#import "CompleteBookClass.h"

@implementation MainFoundation (CoreDataBuilderForGeneralExtraction)

#define DK 2
#define LOG if(DK == 1)



//
//
////
#pragma mark - Combined Core Data
////
//
//

- (void) completeCoreDataBuildForTexts : (NSManagedObjectContext*) context
{

    [self buildMishnahBookTitles : context];

    NSLog(@"-- --");
    NSLog(@"-- --");

    [self loopLoadMishnah : context];
    
    
}

//
//
////
#pragma mark - Write TextTitle
////
//
//

- (void) loopLoadMishnah : (NSManagedObjectContext*) context
{
    NSLog(@"Start Loading Mishnah");
    
    CompleteBookClass*myBookClass = [[CompleteBookClass alloc]init];
    NSArray* mishnahArray = [myBookClass completeMishnahFileLocation];
    
    for (int BK = 0; BK < [mishnahArray count]; BK++) {
        NSString* textName = [mishnahArray objectAtIndex:BK];
        BookListDataModel* textData = [BookListDataModel myNewDataLoader:textName];
        
        LOG NSLog(@"-- FTT %@ --",textData.theTitle);
        
        NSString* theLanguage = textData.theLanguage;
        if ([theLanguage isEqualToString:@"en"]){
            NSString* nextTextName = [mishnahArray objectAtIndex:BK+1];
            BK++;
            BookListDataModel* nextModel = [BookListDataModel myNewDataLoader:nextTextName];
            NSLog(@"-- STT %@ --",nextModel.theTitle);

            [self textDataExtractForCoreData:textData withNextModel : (BookListDataModel*) nextModel withContext : context];
        }
    }
    [self saveData:context];
    NSLog(@"Finished Loading Mishnah");
}

- (void) textDataExtractForCoreData: (BookListDataModel*) textData  withNextModel :  (BookListDataModel*) nextModel withContext : (NSManagedObjectContext*) context
{
    NSArray* myTextArray = textData.theCompleteTextArray;
    NSArray* myNextTextArray = nextModel.theCompleteTextArray;
    
    NSString* hebrewTitle = textData.theHebrewTitle;
    NSString* englishTitle = textData.theTitle;
    NSString* theLanguage = textData.theLanguage;
    TextTitle* aTextTitle = [[self fetchTextTitleByNameString: englishTitle withContext:context]firstObject];
    BookTitle* aBookTitle = [[self fetchBookTitleByNameString:@"Mishnah" withContext:context]firstObject];
    //aTextTitle.whatBookTitle = aBookTitle;
    aTextTitle.hebrewName = hebrewTitle;
    aTextTitle.chapterCount = [NSNumber numberWithInteger:[myTextArray count]];
    NSLog(@"-- TTT %@ --",aTextTitle.englishName);
    
    NSMutableArray* myCompleteTextArray = [[NSMutableArray alloc]init];
    if ([myTextArray count] == 0){
        NSLog(@"Error Data on text extraction");
        return;
    }
    for (int i = 0; i < [myTextArray count]; i++) {// START CHAPTER
        NSArray* myChapterText = [myTextArray objectAtIndex:i];

        // the chapter number
        NSInteger theChapterNumber = i;
        
        if ([myChapterText isKindOfClass:[NSString class]]){
            NSLog(@"Error - lvl 1 text Write as NSString");
            NSString* myStringConversion = [@[myChapterText] firstObject];
            if ([myStringConversion length]){
                [myCompleteTextArray addObject:myStringConversion];
            }
            else {
                [myCompleteTextArray addObject:@" "];
            }
        }
        else if ([myChapterText isKindOfClass:[NSArray class]]){
            for (int j = 0; j < [myChapterText count]; j++) {

                // the line number
                NSInteger theLineNumber = j;

                if ([[myChapterText objectAtIndex:j] isKindOfClass:[NSArray class]]) {
                    NSLog(@"Error - lvl 2.X text Write as NSAray");
                    NSArray* subArray = [myChapterText objectAtIndex:j];
                    for (int k = 0; k < [subArray count]; k++) {
                        
                        if ([[subArray objectAtIndex:k] isKindOfClass:[NSArray class]]) {
                            LOG NSLog(@"-- Error on array %@ --",[subArray objectAtIndex:k]);
                            NSArray* superSubArray = [subArray objectAtIndex:k];
                            
                            for (int l = 0; l < [superSubArray count]; l++) {
                                NSString* mySuperSubString;
                                if ([[superSubArray objectAtIndex:l] isKindOfClass:[NSString class]]) {
                                    mySuperSubString = [superSubArray objectAtIndex:l];
                                }
                                else {
                                    mySuperSubString = @" ";
                                    LOG NSLog(@"-- SUPER-SUB-ERROR %@ --",[superSubArray objectAtIndex:l]);
                                }
                                [myCompleteTextArray addObject:[self stringFormatForForm:mySuperSubString]];
                            }
                        }
                        else { // extra deep text here
                            NSString* mySubString;
                            if ([[subArray objectAtIndex:k] isKindOfClass:[NSString class]]) {
                                mySubString = [subArray objectAtIndex:k];
                            }
                            else {
                                mySubString = @" ";
                                NSLog(@"-- SUB-ERROR %@ --",[subArray objectAtIndex:k]);
                            }
                            [myCompleteTextArray addObject:[self stringFormatForForm:mySubString]];
                        }
                    }
                }
                else { // regular text here

                    NSString* myText;
                    if ([[myChapterText objectAtIndex:j] isKindOfClass:[NSString class]]) {
                        
                        // create normal depth lineText
                        myText = [myChapterText objectAtIndex:j];
                        
                        NSString* theHebrewString;
                        if ([myNextTextArray count] > theChapterNumber ){
                            if ([[myNextTextArray objectAtIndex:theChapterNumber]count] > theLineNumber ){
                                theHebrewString = [[myNextTextArray objectAtIndex:theChapterNumber]objectAtIndex:theLineNumber];
                            }
                            else {
                                theHebrewString = @" ";
                                NSLog(@"-- Error Chapter Count --");
                            }
                        }
                        else {
                            theHebrewString = @" ";
                            NSLog(@"-- Error Line Count --");
                        }

                        [self createTextLine:myText withHebrewText : (NSString*) theHebrewString withBookTitle:aBookTitle withTextTitle:aTextTitle withLanguage:theLanguage withChapterNumber:theChapterNumber withLineNumber:theLineNumber withContext:context];
                        LOG NSLog(@"lvl-2 Text:  %@ %ld %ld",myText,(long)theChapterNumber,(long)theLineNumber);

                    }
                    else {
                        myText = @" ";
                        LOG NSLog(@"-- Error Text %@ --",[myChapterText objectAtIndex:j]);
                    }
                    [myCompleteTextArray addObject:myText];
                }
            }
        }
        [myCompleteTextArray addObject:@" "];
    } //end chapter
    LOG NSLog(@"-- MCTA %@ --",myCompleteTextArray);
}

- (void) createTextLine: theText
        withHebrewText : (NSString*) theHebrewString
         withBookTitle : (BookTitle*) theBookTitle
         withTextTitle : (TextTitle*) myTextTitle
          withLanguage : (NSString*) theLanguage
     withChapterNumber : (NSInteger) chapterNumber
        withLineNumber : (NSInteger) lineNumber
           withContext : (NSManagedObjectContext*) context {
    
    LineText* myText;
    if ([theLanguage isEqualToString:@"en"]){
        myText =   [LineText newLineText : theText
                           withBookTitle : theBookTitle
                           withTextTitle : myTextTitle
                       withChapternumber : chapterNumber
                          withLineNumber : lineNumber
                            withLanguage : @"english"
                             withContext : context];

        myText.hebrewText = theHebrewString;
    }
    else if ([theLanguage isEqualToString:@"he"]) {
        myText =   [LineText newLineText : theText
                           withBookTitle : theBookTitle
                           withTextTitle : myTextTitle
                       withChapternumber : chapterNumber
                          withLineNumber : lineNumber
                            withLanguage : @"hebrew"
                             withContext : context];

    }
    else {
        NSLog(@"Error LineText right");
    }
}





@end
