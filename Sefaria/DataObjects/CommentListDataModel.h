//
//  CommentListDataModel.h
//  Sefaria
//
//  Created by MGM on 7/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentListDataModel : NSObject

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
@property (strong, nonatomic) NSArray* theCompleteTextArray;


//
// Titles
//
@property (strong, nonatomic) NSString* theHebrewTitle;
@property (strong, nonatomic) NSString* theEnglishTitle;

@property (strong, nonatomic) NSString* theLanguage;
@property (strong, nonatomic) NSString* theTextName;

@property (strong, nonatomic) NSString* theCommentator;

//
// Chapter Count
//
@property (nonatomic) NSInteger theChapterCount;

//
// Comment List
//

@property (nonatomic, strong) NSArray* superCommentList;

+ (CommentListDataModel*) newCommentDataLoader: (NSString*) filePathStringFromArray;


@end

