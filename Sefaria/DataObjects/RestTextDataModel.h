//
//  RestTextDataModel.h
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestTextDataModel : NSObject

//
// NSJSONSerialization
//
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;

//
// Category Names
//
@property (strong, nonatomic) NSArray* theCategoryList;

//
// The Text
//
@property (strong, nonatomic) NSArray* theCompleteEnglishTextArray;
@property (strong, nonatomic) NSArray* theCompleteHebrewTextArray;
@property (strong, nonatomic) NSArray* theCompleteCommentTextArray;

//
// Titles
//
@property (strong, nonatomic) NSString* theHebrewTitle;
@property (strong, nonatomic) NSString* theTitle;

//
// Chapter Nav
//
@property (strong, nonatomic) NSString* theTitleWithChapter;

@property (nonatomic) NSInteger theDataChapterMax;

//
////
//

+ (RestTextDataModel*) myNewRestDataLoader: (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError;


@end
