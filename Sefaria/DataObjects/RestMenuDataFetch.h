//
//  RestMenuDataFetch.h
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestMenuDataModel.h"

@class RestMenuDataModel;

@interface RestMenuDataFetch : NSObject

@property (nonatomic, strong) RestMenuDataModel* myMenuRestData;

- (void) basicRestMenuRequest;

- (void) recursiveTitleDataModel : (NSArray*) myCompleteDataArray withDepth : (NSInteger) theDepth;

- (NSArray*) restMenuTitleDataDepth0 : (NSArray*) myCompleteDataArray;
- (NSArray*) restMenuTitleDataFetch : (NSArray*) myCompleteDataArray;


@end
