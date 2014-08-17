//
//  MainFoundation+RestTextActions.m
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+RestTextActions.h"


@implementation MainFoundation (RestTextActions)

- (void) restTextAccessAction : (RestTextDataFetch* ) myRestData withTextName : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber
{
    [myRestData mainRestFetchAction : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber];

    if ([self runAtEnd]) {
        NSLog(@"complete");
    }
}

- (bool) runAtEnd {
    [self nameFunction:^(bool unusedValue){
        NSLog(@"second");
    }];
    NSLog(@"last");
    return true;
}

- (void) nameFunction: (void (^)(bool unusedValue)) completionHandler {
    NSLog(@"first");
    completionHandler(true);
};



@end
