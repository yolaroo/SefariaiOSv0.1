//
//  RestTextDataModel.m
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RestTextDataModel.h"

@implementation RestTextDataModel

@synthesize theCompleteDictionary=_theCompleteDictionary,theCategoryList=_theCategoryList,theCompleteHebrewTextArray=_theCompleteHebrewTextArray,theCompleteEnglishTextArray=_theCompleteEnglishTextArray,theCompleteCommentTextArray=_theCompleteCommentTextArray,theTitleWithChapter=_theTitleWithChapter,theDataChapterMax=_theDataChapterMax;

#define DK 2
#define LOG if(DK == 1)

+ (RestTextDataModel*) myNewRestDataLoader: (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError
{
    if (myData.length > 0 && connectionError == nil)
    {
        RestTextDataModel* myTextDataModel = [[RestTextDataModel alloc]init];
        //
        // NSJSONSerialization
        //
        NSError* error;
        myTextDataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                                options:kNilOptions
                                                                                  error:&error];
        //
        // The Text
        //
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"text"]) {
            myTextDataModel.theCompleteEnglishTextArray = [myTextDataModel.theCompleteDictionary objectForKey:@"text"];
            LOG NSLog(@"-- Full English Text: %@ --",myTextDataModel.theCompleteEnglishTextArray);
        }
        else {
            LOG NSLog(@"English Text Error");
            LOG NSLog(@"-- at path name %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"he"]) {
            myTextDataModel.theCompleteHebrewTextArray = [myTextDataModel.theCompleteDictionary objectForKey:@"he"];
            LOG NSLog(@"-- Full Hebrew Text: %@ --",myTextDataModel.theCompleteHebrewTextArray);
        }
        else {
            LOG NSLog(@"Hebrew Text Error");
            LOG NSLog(@"-- at path name %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"commentary"]) {
            myTextDataModel.theCompleteCommentTextArray = [myTextDataModel.theCompleteDictionary objectForKey:@"commentary"];
            LOG NSLog(@"-- Full Comment Text: %@ --",myTextDataModel.theCompleteCommentTextArray);
        }
        else {
            LOG NSLog(@"Comment Text Error");
            LOG NSLog(@"-- at path name %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        //
        // Titles
        //
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"book"]) {
            myTextDataModel.theTitle = [myTextDataModel.theCompleteDictionary objectForKey:@"book"];
            LOG NSLog(@"-- Title: %@ --",[myTextDataModel.theCompleteDictionary objectForKey:@"book"]);
        }
        else {
            LOG NSLog(@"Error for English Title");
            LOG NSLog(@"-- pathName: %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"heTitle"]) {
            myTextDataModel.theHebrewTitle = [myTextDataModel.theCompleteDictionary objectForKey:@"heTitle"];
            LOG NSLog(@"-- Hebrew Title: %@ --",[myTextDataModel.theCompleteDictionary objectForKey:@"heTitle"]);
        }
        else {
            LOG NSLog(@"Error for Hebrew Title");
            LOG NSLog(@"-- pathName: %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        //
        // the chapter and title
        //
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"ref"]) {
            myTextDataModel.theTitleWithChapter = [myTextDataModel.theCompleteDictionary objectForKey:@"ref"];
            LOG NSLog(@"-- Chapter and Title: %@ --",[myTextDataModel.theCompleteDictionary objectForKey:@"ref"]);
        }
        else {
            LOG NSLog(@"Error for Chapter and Title");
            LOG NSLog(@"-- pathName: %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        if ([myTextDataModel.theCompleteDictionary objectForKey:@"lengths"]) {
            myTextDataModel.theDataChapterMax = [[[myTextDataModel.theCompleteDictionary objectForKey:@"lengths"] firstObject]integerValue];
            LOG NSLog(@"-- Chapter Number Max : %@ --",[myTextDataModel.theCompleteDictionary objectForKey:@"lengths"]);
        }
        else {
            LOG NSLog(@"Error for Chapter Number Max");
            LOG NSLog(@"-- pathName: %@ --",pathURL);
            LOG NSLog(@"-- --");
        }
        
        //next
        //prev

        return myTextDataModel;
    }
    else {
        NSLog(@"Data Request Error - %@",connectionError);
        return nil;
    }
}



@end
