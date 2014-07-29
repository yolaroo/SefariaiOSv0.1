//
//  MainFoundation+TextDataActionLayer.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+TextDataActionLayer.h"


@implementation MainFoundation (TextDataActionLayer)

#define DK 1
#define LOG if(DK == 1)

//
//
//////
#pragma mark - Public Functions
//////
//
//

- (NSArray*) setTextFromChapter: (NSArray*) theText theChapterNumber : (NSInteger) theNumber
{
    if ([theText count] >= theNumber) {
        return [theText objectAtIndex : theNumber];
    } else {
        NSLog(@"Error Chapter Length");
        return nil;
    }
}

//
////
//

- (NSArray*) getBilingualData: (kTanachBooks) theBook theText: (TanachAttributeClass*) theAttribute
{
    TanachDataModel* myEnglishData = [self getMyEnglishTextDataModel: theBook theText: theAttribute];
    TanachDataModel* myHebrewData = [self getMyHebrewTextDataModel: theBook theText: theAttribute];
    NSString* EnglishTitle = myEnglishData.theTitle;
    NSString* HebrewTitle = myEnglishData.theHebrewTitle;
    NSArray * EnglishText = myEnglishData.theCompleteTextArray;
    NSArray* HebrewText = myHebrewData.theCompleteTextArray;
    NSNumber* chapterLength = [NSNumber numberWithInteger: myEnglishData.chapterLength];
    return @[
             EnglishTitle,
             HebrewTitle,
             EnglishText,
             HebrewText,
             chapterLength
             ];
}

//
//
//////
#pragma mark - Data Calls
//////
//
//

- (TanachDataModel*) getMyEnglishTextDataModel: (kTanachBooks) theBook theText: (TanachAttributeClass*) theAttribute
{
    kTextLanguage theLanguage = kLanguageEnglish;
    TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
    return myTextDataModel;
}

- (TanachDataModel*) getMyHebrewTextDataModel: (kTanachBooks) theBook theText: (TanachAttributeClass*) theAttribute
{
    kTextLanguage theLanguage = kLanguageHebrew;
    TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
    return myTextDataModel;
}

//
//
//////
#pragma mark - Test Class
/////
//
//

- (void) myTextDataModelTest
{
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    
    kTanachBooks theBook = kTanachTorah;
    theAttribute.torah = kTorahLeviticus;
    
    //kTanachBooks theBook = kTanachWritings;
    //theAttribute.writings = kWritingsEsther;
    //kTanachBooks theBook = kTanachProphets;
    //theAttribute.prophets = kProphetsMicah;
    
    kTextLanguage theLanguage = kLanguageEnglish;
    TanachDataModel* myTextDataModel = [TanachDataModel newTextDataModel:theBook theText:theAttribute theLanguage:theLanguage];
    
    [self testDataClass: myTextDataModel];
    
}

-(void) testDataClass: (TanachDataModel*) myTextDataModel {
    
    //
    // title
    //
    NSLog(@"-- The title -- %@",myTextDataModel.theTitle);
    NSLog(@"-- The Hebrew title -- %@",myTextDataModel.theHebrewTitle);
    
    //
    // category list
    //
    NSLog(@"-- The Categories -- %@",myTextDataModel.theCategoryList);
    
    //
    // chapter number
    //
    NSLog(@"-- Chapter Count  -- %ld",(long)myTextDataModel.chapterLength);
    
    //
    // complete text
    //
    NSLog(@"-- Complete Book Text -- %@",myTextDataModel.theCompleteTextArray);
    
    //
    // single chapter text
    //
    NSLog(@"-- Complete Chapter Text -- %@",myTextDataModel.theCompleteTextArray);
    NSLog(@"-- Chapter Line Count -- %lu", (unsigned long)[myTextDataModel.theCompleteTextArray count]);
    NSString * singleChapter = [myTextDataModel.theCompleteTextArray firstObject];
    NSLog(@"-- Single Line --  %@", singleChapter);
}

//
////
//

- (void) primaryBookMatrix {
    NSLog(@"TT %d",self.theTorahText);
    NSLog(@"PT %d",self.theProphetText);
    NSLog(@"WT %d",self.theWritingsText);
}

- (bool) primaryBookCheck
{
    switch (self.thePrimarybook) {
        case kTanachProphets:
            if(!self.theProphetText) {
                NSLog(@"Error : No Prophet Text");
                return true;
            }
            break;
        case kTanachTorah:
            if(!self.theTorahText) {
                NSLog(@"Error : No Torah Text");
                return true;
            }
            break;
        case kTanachWritings:
            if(!self.theWritingsText) {
                NSLog(@"Error : No Writings Text");
                return true;
            }
            break;
        default:
            NSLog(@"Error : book check default");
            return true;
            break;
    }
    return false;
}


@end
