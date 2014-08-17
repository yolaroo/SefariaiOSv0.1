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

@interface MainFoundation (RestTextActions)

- (void) restTextAccessAction : (RestTextDataFetch* ) myRestData withTextName : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber;

@end
