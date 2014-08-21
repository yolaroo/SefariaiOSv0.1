//
//  MainFoundation+RestTextActions.m
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+RestTextActions.h"


@implementation MainFoundation (RestTextActions)

#define DK 2
#define LOG if(DK == 1)

- (void) loadDataListener
{
    [self basicNotifications:@"notificationOfData" withName:@"restDataLoaded"];
}

- (void) loadMenuDataListener
{
    [self basicNotifications:@"notificationOfMenuData" withName:@"restMenuDataLoaded"];
}

- (void) restTextAccessAction : (RestTextDataFetch* ) myRestData withTextName : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber
{
    [myRestData mainRestFetchAction : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber];
}

//
////
//

- (void) restMenuAccessAction : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray withDepth : theDepth
{
    [myMenuRestDataFetch recursiveTitleDataModel : (NSArray*) myCompleteDataArray withDepth : (NSInteger) theDepth];
}

- (NSArray*) intialRestMenuFetch : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray
{
    return [myMenuRestDataFetch restMenuTitleDataDepth0:myCompleteDataArray];
}

- (NSArray*) normalRestMenuFetch : (RestMenuDataFetch*) myMenuRestDataFetch withDataArray : (NSArray*) myCompleteDataArray
{
    return [myMenuRestDataFetch restMenuTitleDataFetch:myCompleteDataArray];
}



//
//
/////
#pragma mark - Test Callback
/////
//
//

- (void) testCallBack {
    if ([self runAtEnd]) {
        LOG NSLog(@"complete");
    }
}

- (bool) runAtEnd {
    [self nameFunction:^(bool unusedValue){
        LOG NSLog(@"second");
    }];
    LOG NSLog(@"last");
    return true;
}

- (void) nameFunction: (void (^)(bool unusedValue)) completionHandler {
    LOG NSLog(@"first");
    completionHandler(true);
};

@end
