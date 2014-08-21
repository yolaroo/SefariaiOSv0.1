//
//  MainFoundation+RestTextActions.h
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

#import "RestTextDataModel.h"
#import "RestTextDataFetch.h"
#import "RestMenuDataModel.h"
#import "RestMenuDataFetch.h"


@interface MainFoundation (RestTextActions)

- (void) restTextAccessAction : (RestTextDataFetch* ) myRestData withTextName : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber;
- (void) restMenuAccessAction : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray withDepth : theDepth;

- (NSArray*) intialRestMenuFetch : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray;
- (NSArray*) normalRestMenuFetch : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray;

//

- (void) loadDataListener;
- (void) loadMenuDataListener;


@end
