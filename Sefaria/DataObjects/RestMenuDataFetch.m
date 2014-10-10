//
//  RestMenuDataFetch.m
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RestMenuDataFetch.h"

@implementation RestMenuDataFetch

@synthesize myMenuRestData=_myMenuRestData;

#define DK 2
#define LOG if(DK == 1)

//
//
/////
#pragma mark - REST Request
/////
//
//

- (void) basicRestMenuRequest
{
    NSString* theURLString = @"http://www.sefaria.org/api/index";
    NSURL *pathURL = [NSURL URLWithString: theURLString];
    NSLog(@"-- request... --");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:pathURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response,
                                               NSData* data,
                                               NSError* connectionError)
 {
     NSLog(@"-- Request fetched --");
     if (data.length > 0 && connectionError == nil) {
         NSInteger httpStatus = [((NSHTTPURLResponse *)response) statusCode];
         NSLog(@"http Status : %ld",(long)httpStatus);
        [self restMenuResponseObject : pathURL withData:data withConnectionError:connectionError];
     }
 }];
}

//
////
//

- (void) restMenuResponseObject : (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError {
    self.myMenuRestData = [RestMenuDataModel myNewRestMenuDataLoader:pathURL withData:myData withConnectionError:connectionError];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"restMenuDataLoaded"
     object:self];
    
    // load into core data
    // post notification
    // load view
}


//
//
/////
#pragma mark - Data Model Parser
/////
//
//

- (NSArray*) restMenuTitleDataDepth0 : (NSArray*) myCompleteDataArray
{
    NSMutableArray* myMenuTitleArray = [[NSMutableArray alloc]init];
    NSMutableArray* myMenuDataArray = [[NSMutableArray alloc]init];

    NSMutableDictionary* bookDictionary = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < [myCompleteDataArray count]; i++) {
        bookDictionary = [myCompleteDataArray objectAtIndex:i];
        if ([self checkCategory: bookDictionary]) {
            NSString* bookTitle = [bookDictionary objectForKey:@"category"];
            LOG NSLog(@"-- BT %@ --",bookTitle);
            [myMenuTitleArray addObject:bookTitle];
        }
        else {
            NSLog(@"Error no book group title");
        }
        if ([self checkContent: bookDictionary]) {
            NSArray* newBookArray = [bookDictionary objectForKey:@"contents"];
            [myMenuDataArray addObject:newBookArray];
        }
    }
    NSNumber* isTextCheck = [NSNumber numberWithBool:false];
    return @[ [myMenuTitleArray copy],isTextCheck,[myMenuDataArray copy]];
}

//
////
//

- (NSArray*) restMenuTitleDataFetch : (NSArray*) myCompleteDataArray
{
    NSMutableArray* myMenuTitleArray = [[NSMutableArray alloc]init];
    NSMutableArray* myMenuDataArray = [[NSMutableArray alloc]init];
    bool isTextLevel = false;
    NSMutableDictionary* bookDictionary = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < [myCompleteDataArray count]; i++) {
        bookDictionary = [myCompleteDataArray objectAtIndex:i];
        
        if ([self checkTitle: bookDictionary]) { // end of path
            NSString* textTitle = [bookDictionary objectForKey:@"title"];
            LOG NSLog(@"-- TT %@ --",textTitle);
            isTextLevel = true;
            [myMenuTitleArray addObject:textTitle];
        }
        else {
            if ([self checkCategory: bookDictionary]) { // normal path
                NSString* bookTitle = [bookDictionary objectForKey:@"category"];
                LOG NSLog(@"-- BT %@ --",bookTitle);
                isTextLevel = false;
                [myMenuTitleArray addObject:bookTitle];
            }
            else {
                NSLog(@"Error no book group title");
            }
            if ([self checkContent: bookDictionary]) {
                NSArray* newBookArray = [bookDictionary objectForKey:@"contents"];
                [myMenuDataArray addObject:newBookArray];
            }
        }
    }
    NSNumber* isTextCheck = [NSNumber numberWithBool:isTextLevel];
    return @[ [myMenuTitleArray copy],isTextCheck, [myMenuDataArray copy] ];
}

//
////
//

- (void) recursiveTitleDataModel : (NSArray*) myCompleteDataArray withDepth : (NSInteger) theDepth
{
    for (int i = 0; i < [myCompleteDataArray count]; i++) { //LVL1
        
        NSDictionary* bookDictionary = [myCompleteDataArray objectAtIndex:i]; //FO
        if ([self checkTitle: bookDictionary]) {
            __unused NSString* textTitle =  [bookDictionary objectForKey:@"title"];
            NSLog(@"-- TT %@ --",textTitle);
            if ([self checkTitle: bookDictionary]) {
                __unused NSInteger chapterMaxNumber = [[bookDictionary objectForKey:@"length"]integerValue];
                NSLog(@"-- CN %ld --",(long)chapterMaxNumber);
            }
            else {
                NSLog(@"Error no chapter number");
                //error
            }
            // can go to book
        }
        else {
            LOG NSLog(@"no text title");
        }
        
        if ([self checkCategory: bookDictionary]) {
            __unused NSString* bookTitle = [bookDictionary objectForKey:@"category"];
            //add title to list for selection
            NSLog(@"-- BT %@ : %ld --",bookTitle,(long)theDepth);
        }
        else {
            NSLog(@"no book group title");
        }
        
        if ([self checkContent: bookDictionary]) {
            NSArray* newBookArray = [bookDictionary objectForKey:@"contents"];
            theDepth++;
            [self recursiveTitleDataModel : newBookArray withDepth : theDepth];
        }
        else {
            NSLog(@"no further book content");
        }
    }
}

//
////
//

- (bool) checkContent : (NSDictionary* ) bookDictionary {
    if ([bookDictionary objectForKey:@"contents"]) { //next data level
        return true;
    }
    return false;
}

- (bool) checkCategory : (NSDictionary* ) bookDictionary {
    if ([bookDictionary objectForKey:@"category"]) { //string @ category level
        return true;
    }
    return false;
}

- (bool) checkTitle : (NSDictionary* ) bookDictionary {
    if ([bookDictionary objectForKey:@"title"]) { //string @ text level
        return true;
    }
    return false;
}


@end
