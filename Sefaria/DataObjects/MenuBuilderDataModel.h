//
//  MenuBuilder.h
//  Sefaria
//
//  Created by MGM on 7/15/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuBuilderDataModel : NSObject

//
// NSJSONSerialization
//
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;

//
// Category Names
//
@property (strong, nonatomic) NSArray* theCategoryList;

//
// The Data Lump
//
@property (strong, nonatomic) NSArray* theCompleteTextArray;

//
// The book titles
//
@property (strong, nonatomic) NSArray* theBookTitle;

//
// The text titles
//
@property (strong, nonatomic) NSArray* theTextTitle;


//
//
////
//
////
//
//

+ (MenuBuilderDataModel*) newMenuBuilderDataModel;


@end
