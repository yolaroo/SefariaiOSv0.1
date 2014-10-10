//
//  BookListDataModel.h
//  Sefaria
//
//  Created by MGM on 7/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListDataModel : NSObject


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
// Language
//
@property (strong, nonatomic) NSString* theLanguage;

//
// Titles
//
@property (strong, nonatomic) NSString* theHebrewTitle;
@property (strong, nonatomic) NSString* theTitle;

//
////
//

@property (nonatomic, strong) NSArray* superTextList;

+ (BookListDataModel*) myNewDataLoader: (NSString*) filePathStringFromArray;

@end
