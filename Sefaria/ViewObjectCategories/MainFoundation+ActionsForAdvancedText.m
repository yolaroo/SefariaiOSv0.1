//
//  MainFoundation+ActionsForAdvancedText.m
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+ActionsForAdvancedText.h"
#import "BookListDataModel.h"

@implementation MainFoundation (ActionsForAdvancedText)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - Data Actions
////////
//
//

- (NSArray*) getTextListData: (NSString*)textName
{
    BookListDataModel* textData = [BookListDataModel myNewDataLoader:textName];
    NSArray* myTextArray = textData.theCompleteTextArray;
    return myTextArray;
}

- (NSArray*) textDataExtract: (NSArray*) myTextArray
{
    NSMutableArray* myCompleteTextArray = [[NSMutableArray alloc]init];
    if ([myTextArray count] == 0){
        NSLog(@"Error Data on text extraction");
        return nil;
    }
    for (int i = 0; i < [myTextArray count]; i++) {// START CHAPTER
        NSArray* myChapterText = [myTextArray objectAtIndex:i];
        NSString* chapterNumber = [NSString stringWithFormat:@"Chapter %d",i+1];
        [myCompleteTextArray addObject:chapterNumber];
        [myCompleteTextArray addObject:@" "];

        if ([myChapterText isKindOfClass:[NSString class]]){
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
                if ([[myChapterText objectAtIndex:j] isKindOfClass:[NSArray class]]) {
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
                        else {
                            NSString* mySubString;
                            if ([[subArray objectAtIndex:k] isKindOfClass:[NSString class]]) {
                                mySubString = [subArray objectAtIndex:k];
                            }
                            else {
                                mySubString = @" ";
                                LOG NSLog(@"-- SUB-ERROR %@ --",[subArray objectAtIndex:k]);
                            }
                            [myCompleteTextArray addObject:[self stringFormatForForm:mySubString]];
                        }
                    }
                }
                else {
                    NSString* myText;
                    if ([[myChapterText objectAtIndex:j] isKindOfClass:[NSString class]]) {
                        myText = [myChapterText objectAtIndex:j];
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
    return [myCompleteTextArray copy];
}

//
////
//

- (NSString*) stringPathFormat :(NSString*) myPathFromPress
{
    myPathFromPress = [myPathFromPress stringByReplacingOccurrencesOfString:@"TextData/"
                                                                 withString:@""];
    myPathFromPress = [myPathFromPress stringByReplacingOccurrencesOfString:@".json"
                                                                 withString:@""];
    return myPathFromPress;
}

- (NSString*) stringFormatForForm :(NSString*) myString
{
    myString = [myString stringByReplacingOccurrencesOfString:@"/"
                                                   withString:@""];
    myString = [myString stringByReplacingOccurrencesOfString:@"\""
                                                   withString:@"'"];
    return myString;
}

//
//
////////
#pragma mark - Tests
////////
//
//

- (void) testMenuRecursion
{
    [self testDataCheckMasterList];
}

- (void) testDataCheckMasterList {
    BookListDataModel* bookSet = [[BookListDataModel alloc]init];
    NSArray* textList = bookSet.superTextList;
    for (int i = 0; i < [textList count]; i++) {
        NSString* myTextName = [textList objectAtIndex:i];
        NSLog(@"-- TNH : %@ --",myTextName);
        //self.myTitleTempStore = myTextName;
        //NSLog(@"0.0");
        NSArray* myTextData = [self getTextListData:myTextName];
        //NSLog(@"0.1");
        NSArray* myText = [self textDataExtract:myTextData];
        NSLog(@"--  MTN %@ --",myText);
        NSLog(@"Loop Done");
    }
    NSLog(@"-- **Done-Done** --");
}

- (void) testLoadDataForMenu {
    BookListDataModel* bookSet = [[BookListDataModel alloc]init];
    NSArray* textList = bookSet.superTextList;
    NSString* myTextName = [textList objectAtIndex:2];
    NSArray* myTextData = [self getTextListData:myTextName];
    NSArray* myText = [self textDataExtract:myTextData];
    NSLog(@"-- %@ --",myText);
}

//
////
//

- (void) testSetMyMenuData {
    BookListDataModel* bookSet = [[BookListDataModel alloc]init];
    self.menuListArray = bookSet.superTextList;
    //[self.menuTable reloadData];
}

- (void) testMenuPress:(NSString*)myCellText {
    self.myCurrentTextTitle = myCellText;
    self.theChapterNumber = 0;
    LOG NSLog(@"-- SMCTT %@ --",self.myCurrentTextTitle);
    //[self basicDataReload];
}

@end
