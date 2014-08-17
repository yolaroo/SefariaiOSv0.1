//
//  TextDataModel.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "TanachDataModel.h"

@implementation TanachDataModel

#define DK 2
#define LOG if(DK == 1)

+ (TanachDataModel*) newTextDataModel : (kTanachBooks) tanachBook theText: (TanachAttributeClass*) tanachText theLanguage: (kTextLanguage) tanachLanguage
{
    TanachTextClass* myTextClass = [[TanachTextClass alloc] init];

    NSString* book;
    NSString* text;
    NSString* language;
    NSString* fileName;
    
    switch (tanachBook) {
        case kTanachTorah:
            book = [myTextClass.foundationTanach objectAtIndex:kTanachTorah];
            text = [myTextClass.foundationTorah objectAtIndex:tanachText.torah];
            break;
        case kTanachProphets:
            book = [myTextClass.foundationTanach objectAtIndex:kTanachProphets];
            text = [myTextClass.foundationProphets objectAtIndex:tanachText.prophets];
            break;
        case kTanachWritings:
            book = [myTextClass.foundationTanach objectAtIndex:kTanachWritings];
            text = [myTextClass.foundationWritings objectAtIndex:tanachText.writings];
            break;
        default:
            NSLog(@"Error Book and Text");
            break;
    }

    switch (tanachLanguage) {
        case kLanguageEnglish:
            language = [myTextClass.foundationLanguages objectAtIndex:kLanguageEnglish];
            fileName = @"merged";
            break;
        case kLanguageHebrew:
            language = [myTextClass.foundationLanguages objectAtIndex:kLanguageHebrew];
            fileName = @"merged";
            break;
        default:
            NSLog(@"Error Language");
            break;
    }

    TanachDataModel * myTextDataModel = [[TanachDataModel alloc] init];
    NSString* const folderName = @"TextData";
    NSString* const category = @"Tanach";
    
    NSString* filePathStringEnglish = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",folderName,category,book,text,language,fileName];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: filePathStringEnglish ofType:@"json"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    //
    // NSJSONSerialization
    //
    NSError* error;
    myTextDataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                            options:kNilOptions
                                                                              error:&error];
    
    //
    // Category Names
    //
    myTextDataModel.theCategoryList =  [myTextDataModel.theCompleteDictionary objectForKey:@"categories"];

    //
    // The Text
    //
    myTextDataModel.theCompleteTextArray = [myTextDataModel.theCompleteDictionary objectForKey:@"text"];
    
    //
    // Titles
    //
    myTextDataModel.theTitle = [myTextDataModel.theCompleteDictionary objectForKey:@"title"];
    myTextDataModel.theHebrewTitle = [myTextDataModel.theCompleteDictionary objectForKey:@"heTitle"];

    //
    // Chapter Number
    //
    myTextDataModel.chapterLength = [myTextDataModel.theCompleteTextArray count];
    
    return myTextDataModel;
}

@end
