//
//  RestTextDataFetch.h
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestTextDataModel.h"

@class RestTextDataModel;

@interface RestTextDataFetch : NSObject

@property (nonatomic, strong) RestTextDataModel* myRestData;

- (void) mainRestFetchAction : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber;


@end
