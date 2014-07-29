//
//  TextDataModel.h
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TanachTextClass.h"
#import "TanachAttributeClass.h"

@interface TanachDataModel : NSObject

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
@property (strong, nonatomic) NSString* theTitle;

//
// Chapter Number
//
@property (nonatomic) NSInteger chapterLength;

//
//
////////////////
// Class Method
////////////////
//
//
+ (TanachDataModel*) newTextDataModel : (kTanachBooks) Tanachbook theText: (TanachAttributeClass*) TanachText theLanguage: (kTextLanguage) TanachLanguage;


@end
