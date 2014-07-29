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
        //NSMutableArray* myChapterArray = [[NSMutableArray alloc]init];
        // switch sub
        
        NSArray* myChapterText = [myTextArray objectAtIndex:i];
        NSString* chapterNumber = [NSString stringWithFormat:@"Chapter %d",i+1];
        [myCompleteTextArray addObject:chapterNumber];
        [myCompleteTextArray addObject:@" "];
        
        if ([myChapterText isKindOfClass:[NSString class]]){
            //LOG NSLog(@"-- title %@ --",self.myTitleTempStore);
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
                        NSString* mySubString = [subArray objectAtIndex:k];
                        [myCompleteTextArray addObject:[self stringFormatForForm:mySubString]];
                    }
                }
                else {
                    NSString* myText = [myChapterText objectAtIndex:j];
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

- (void) testMenuRecursion {
    
}

- (void) testDataCheckMasterList {
    BookListDataModel* bookSet = [[BookListDataModel alloc]init];
    NSArray* textList = bookSet.superTextList;
    for (int i = 0; i < [textList count]; i++) {
        NSString* myTextName = [textList objectAtIndex:i];
        //NSLog(@"-- %@ --",myTextName);
        //self.myTitleTempStore = myTextName;
        NSArray* myTextData = [self getTextListData:myTextName];
        NSArray* myText = [self textDataExtract:myTextData];
        NSLog(@"--  MTN %@ --",myText);
        //NSLog(@" ");
    }
    NSLog(@"Done");
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
