//
//  MainFoundation+DataControlPageActions.m
//  Sefaria
//
//  Created by MGM on 7/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+DataControlPageActions.h"

#import "MainFoundation+TextDataActionLayer.h"

#import "LineText+Create.h"
#import "BookTitle+Create.h"
#import "TextTitle+Create.h"

#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheBookTitle.h"
#import "MainFoundation+FetchTheLineText.h"

@implementation MainFoundation (DataControlPageActions)

#define DK 2
#define LOG if(DK == 1)

- (void) loadAllTanachData
{
    [self initialDataLoad:self.managedObjectContext];
}

- (void) initialDataLoad : (NSManagedObjectContext*) context {
    
    NSLog(@"Start Loop Load");
    [self createBooktTitleLVL:context];
    [self createTextTitle:context];
    
    [self loopLoadTorahData:context];
    [self loopLoadWritingsData:context];
    [self loopLoadProphetData:context];
    NSLog(@"End Loop Load");
}

- (void) testNewFetch : (NSManagedObjectContext*) context {
    [self testFetchLineText:context];
}

//
//
//////
#pragma mark - Create Titles
//////
//
//

- (void) createBooktTitleLVL: (NSManagedObjectContext*) context {
    
    BookTitle* myb0 = [BookTitle newBookTitle : 0 withEnglishName : @"Tanach" withHebrewName : @"מקרא" withContext : context];

    BookTitle* myb1a = [BookTitle newBookTitle : 1 withEnglishName : @"Torah" withHebrewName : @"תּוֹרָה" withContext : context];
    BookTitle* myb1b = [BookTitle newBookTitle : 1 withEnglishName : @"Prophets" withHebrewName : @"נְבִיאִים" withContext : context];
    BookTitle* myb1c = [BookTitle newBookTitle : 1 withEnglishName : @"Writings" withHebrewName : @"כְּתוּבִים" withContext : context];
    
    NSSet*myset = [NSSet setWithObjects:myb1a,myb1b,myb1c, nil];
    myb0.whatBookTitleSub = myset;
    myb0.hasBookTitleAsSubset = [NSNumber numberWithBool:TRUE];
    myb0.isBookGroup = [NSNumber numberWithBool:TRUE];

    myb1a.whatBookTitleSuper = myb0;
    myb1b.whatBookTitleSuper = myb0;
    myb1c.whatBookTitleSuper = myb0;
    
    myb1a.displayOrder = [NSNumber numberWithInteger:0];
    myb1b.displayOrder = [NSNumber numberWithInteger:1];
    myb1c.displayOrder = [NSNumber numberWithInteger:2];
    
    myb1a.hasTextTitleAsSubset = [NSNumber numberWithBool:TRUE];
    myb1b.hasTextTitleAsSubset = [NSNumber numberWithBool:TRUE];
    myb1c.hasTextTitleAsSubset = [NSNumber numberWithBool:TRUE];
    myb1a.isBookGroup = [NSNumber numberWithBool:TRUE];
    myb1b.isBookGroup = [NSNumber numberWithBool:TRUE];
    myb1c.isBookGroup = [NSNumber numberWithBool:TRUE];

    [self saveData:context];
}

//
////
//

- (void) createTextTitle: (NSManagedObjectContext*) context {
    for (int i = 0; i < [self.myTanachTextClass.foundationTorah count]; i++) {
        NSString* textTitle = [self.myTanachTextClass.foundationTorah objectAtIndex:i];
        [self createTextTitleSubProcedure : textTitle  withNumber:i withContext : context];
    }
    for (int i = 0; i < [self.myTanachTextClass.foundationProphets count]; i++) {
        NSString* textTitle = [self.myTanachTextClass.foundationProphets objectAtIndex:i];
        [self createTextTitleSubProcedure : textTitle withNumber:i  withContext : context];
    }
    for (int i = 0; i < [self.myTanachTextClass.foundationWritings count]; i++) {
        NSString* textTitle = [self.myTanachTextClass.foundationWritings objectAtIndex:i];
        [self createTextTitleSubProcedure : textTitle withNumber:i withContext : context];
    }
    [self saveData:context];
}

- (void) createTextTitleSubProcedure: (NSString*)textTitle withNumber: (NSInteger) myNumber withContext: (NSManagedObjectContext*) context{
    TextTitle*myText = [TextTitle newTextTitle:2 withEnglishName:textTitle withHebrewName:@"" withContext:context];
    myText.displayOrder = [NSNumber numberWithInteger:myNumber];
}

//
//// Fetch Routine
//

- (TextTitle*) myTextTitle : (NSString*) textName withContext : (NSManagedObjectContext*) context
{
    TextTitle* myText = [[self fetchTextTitleByNameString:textName withContext:context]firstObject];
    LOG NSLog(@"-- MTFF %@ --",myText.englishName);
    return myText;
}

- (BookTitle*) myBookTitle : (NSString*) bookName withContext : (NSManagedObjectContext*) context
{
    BookTitle* myText = [[self fetchBookTitleByNameString:bookName withContext:context]firstObject];
    LOG NSLog(@"-- mBTFF %@ --",myText.englishName);
    return myText;
}

//
////
//

- (void) loopLoadTorahData : (NSManagedObjectContext*) context {
    NSLog(@"Start Loading Torah");
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    kTanachBooks theBook = kTanachTorah;
    for (int i = kTorahGenesis; i <= kTorahDeuteronomy; i++) {
        theAttribute.torah = i;
        
        //Fetch
        NSString* textName = [self.myTanachTextClass.foundationTorah objectAtIndex:i];
        TextTitle* aTextTitle = [self myTextTitle: textName withContext:context];
        BookTitle* aBookTitle = [self myBookTitle:@"Torah" withContext:context];
        aTextTitle.whatBookTitle = aBookTitle;
        //

        kTextLanguage theLanguage = kLanguageEnglish;
        TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];

        //add hebrew
        TanachDataModel* myHebrewTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:kLanguageHebrew];
        self.myHebrewDataModelArray = [myHebrewTextDataModel.theCompleteTextArray mutableCopy];
        
        NSString* hebrewTitle = myTextDataModel.theHebrewTitle;
        aTextTitle.hebrewName = hebrewTitle;
        NSInteger myChapterNumber = myTextDataModel.chapterLength;
        aTextTitle.chapterCount = [NSNumber numberWithInteger: myChapterNumber];
        
        [self chapterLoad:myTextDataModel.theCompleteTextArray withBookTitle:aBookTitle withTextTitle:aTextTitle withContext:context];
    }
    [self saveData:context];
    NSLog(@"Finished Loading Torah");
}

- (void) loopLoadProphetData : (NSManagedObjectContext*) context {
    NSLog(@"Start Loading Prophets");
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    kTanachBooks theBook = kTanachProphets;
    for (int i = kProphetsJoshua; i <= kProphetsMalachi; i++) {
        LOG NSLog(@"-- New Loop --");

        theAttribute.prophets = i;
        
        //Fetch
        NSString* textName = [self.myTanachTextClass.foundationProphets objectAtIndex:i];
        TextTitle* aTextTitle = [self myTextTitle: textName withContext:context];
        BookTitle* aBookTitle = [self myBookTitle:@"Prophets" withContext:context];
        aTextTitle.whatBookTitle = aBookTitle;
        NSLog(@"-- Text Name %@--",textName);
        //
        
        kTextLanguage theLanguage = kLanguageEnglish;
        TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
        
        //add hebrew
        self.myHebrewDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:kLanguageHebrew];
        self.myHebrewDataModelArray = [self.myHebrewDataModel.theCompleteTextArray mutableCopy];
        
        LOG NSLog(@"-- Added Hebrew --");

        
        NSString* hebrewTitle = myTextDataModel.theHebrewTitle;
        aTextTitle.hebrewName = hebrewTitle;
        
        if (![hebrewTitle length]) {
            NSLog(@"Title Error");
        }
        else {
            LOG NSLog(@"-- --");
        }
        
        NSInteger myChapterNumber = myTextDataModel.chapterLength;
        aTextTitle.chapterCount = [NSNumber numberWithInteger: myChapterNumber];

        LOG NSLog(@"0.1 LDL");
        
        [self chapterLoad:myTextDataModel.theCompleteTextArray withBookTitle:aBookTitle withTextTitle:aTextTitle withContext:context];
        
        LOG NSLog(@"-- Loop finished --");

        
    }
    [self saveData:context];
    NSLog(@"Finished Loading Prophets");
}

- (void) loopLoadWritingsData : (NSManagedObjectContext*) context {
    NSLog(@"Start Loading Writings");
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    kTanachBooks theBook = kTanachWritings;
    for (int i = kWritingsPsalms; i <= kWritingsIIChronicles; i++) {
        theAttribute.writings = i;
        
        //Fetch
        NSString* textName = [self.myTanachTextClass.foundationWritings objectAtIndex:i];
        TextTitle* aTextTitle = [self myTextTitle: textName withContext:context];
        BookTitle* aBookTitle = [self myBookTitle:@"Writings" withContext:context];
        aTextTitle.whatBookTitle = aBookTitle;
        //
        
        kTextLanguage theLanguage = kLanguageEnglish;
        TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
        
        //add hebrew
        self.myHebrewDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:kLanguageHebrew];
        self.myHebrewDataModelArray = [self.myHebrewDataModel.theCompleteTextArray mutableCopy];
        
        NSString* hebrewTitle = myTextDataModel.theHebrewTitle;
        aTextTitle.hebrewName = hebrewTitle;
        NSInteger myChapterNumber = myTextDataModel.chapterLength;
        aTextTitle.chapterCount = [NSNumber numberWithInteger: myChapterNumber];

        [self chapterLoad:myTextDataModel.theCompleteTextArray withBookTitle:aBookTitle withTextTitle:aTextTitle withContext:context];
    }
    [self saveData:context];
    NSLog(@"Finished Loading Writings");
}

//
////
//

- (void) chapterLoad: (NSArray*)chapterArray withBookTitle: (BookTitle*) myBookTitle withTextTitle: (TextTitle*) myTextTitle withContext: (NSManagedObjectContext*) context
{
    LOG NSLog(@"-- CAC %d --",[chapterArray count]);
    for (int i = 0; i < [chapterArray count]; i++) {
        NSArray * singleChapter = [chapterArray objectAtIndex:i];
        NSInteger chapterNumber = i;
        [self lineLoad:singleChapter withBookTitle:myBookTitle withTextTitle:myTextTitle withChapterNumber:chapterNumber withContext:context];
    }
}

- (void) lineLoad: (NSArray*) lineArray withBookTitle: (BookTitle*) myBookTitle withTextTitle: (TextTitle*) myTextTitle withChapterNumber : (NSInteger) chapterNumber withContext: (NSManagedObjectContext*) context
{
    LOG NSLog(@"-- LAC %d --",[lineArray count]);

    for (int i = 0; i < [lineArray count]; i++) {
        //NSLog(@"Line Start");
        NSInteger lineNumber = i;
        NSString * singleLine = [lineArray objectAtIndex:i];
        //NSLog(@"-- LL --  %@", singleLine);
        [self createTextLine:singleLine withBookTitle:myBookTitle withTextTitle:myTextTitle withChapterNumber:chapterNumber withLineNumber:lineNumber withContext:context];
    }
}

- (void) createTextLine: theText withBookTitle : (BookTitle*) theBookTitle withTextTitle : (TextTitle*) myTextTitle withChapterNumber : (NSInteger) chapterNumber withLineNumber : (NSInteger) lineNumber withContext : (NSManagedObjectContext*) context {

    /*
    NSString* myTempString = myTextTitle.englishName;
    if ( [myTempString isEqualToString:@"Jonah"]){
        LOG NSLog(@"-- TEXT %@ --",theText);
    }
    */
    
    LineText* myText = [LineText newLineText : theText
                               withBookTitle : theBookTitle
                               withTextTitle : myTextTitle
                           withChapternumber : chapterNumber
                              withLineNumber : lineNumber
                                withLanguage : @"english"
                                 withContext : context];
    
    // add hebrew text
    //myText.hebrewText = [[self.myHebrewDataModelArray objectAtIndex:chapterNumber]objectAtIndex:lineNumber];
    
    //NSLog(@"-- Count: %d ChapterNumber %d--",[self.myHebrewDataModelArray count],chapterNumber);
    //NSLog(@"-- Count: %d LineNumber %d--",[[self.myHebrewDataModelArray objectAtIndex:chapterNumber]count],lineNumber);
    
    NSString*theHebrewString;
    if ([self.myHebrewDataModelArray count] <= chapterNumber) {
        NSLog(@"-- %@ %ld %ld --",myTextTitle.englishName,(long)chapterNumber,(long)lineNumber);
        NSLog(@"error chapter");
    }
    
    if ([[self.myHebrewDataModelArray objectAtIndex:chapterNumber]count] <= lineNumber) {
        NSLog(@"-- %@ %ld %ld --",myTextTitle.englishName,(long)chapterNumber,(long)lineNumber);
        NSLog(@"error line");
        theHebrewString = @"error";
    }
    else {
        theHebrewString = [[self.myHebrewDataModelArray objectAtIndex:chapterNumber]objectAtIndex:lineNumber];
    }

    myText.hebrewText = theHebrewString;
    myText.isHebrew = [NSNumber numberWithBool:true];
    
    if (!myText) {
        NSLog(@"Error on LineText Write");
    }
    
    //NSLog(@"-- THETEXT %@ --",myText);
}

//
//
/////
#pragma mark - Tests
/////
//
//

- (void) basicDataTest {
    
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    
    kTanachBooks theBook = kTanachTorah;
    theAttribute.torah = kTorahGenesis;
    kTextLanguage theLanguage = kLanguageEnglish;
    TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
    //NSString* EnglishTitle = myTextDataModel.theTitle;
    NSArray * singleChapter = [myTextDataModel.theCompleteTextArray firstObject];
    NSString* singleLine = [singleChapter firstObject];
    NSLog(@"-- %@ --",singleLine);
}

//
////
//

- (void) dataTestOnCreate {
    //NSLog(@"-- --");
    //NSLog(@"-- %@ --",myb0);
    //NSLog(@"-- --");
    /*
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:self.managedObjectContext];
     
     NSDictionary *attributes = [entity attributesByName];
     for (NSString *attribute in attributes) {
     id value = [self.managedObjectContext valueForKey: attribute];
     NSLog(@"attribute %@ = %@", attribute, value);
     }
     */
}

//
////
//

- (NSArray*) testFetch: (NSManagedObjectContext*) context
{
    NSLog(@"TT Fetch");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"-- CFF %lu --",(unsigned long)[fetchedRecords count]);
    
    return fetchedRecords;
}

@end
