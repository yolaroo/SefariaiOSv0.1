//
//  RestTextDataFetch.m
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RestTextDataFetch.h"

@implementation RestTextDataFetch

@synthesize myRestData=_myRestData;

#define BASE_REST_PATH @"http://www.sefaria.org/api/texts"

- (void) mainRestFetchAction : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber
{
    NSString* theStringURL = [self restBookNameString : textName withChapterNumber:chapterNumber];
    NSURL * theURL = [self urlForRestRequest:theStringURL];
    [self basicRestRequest : theURL];
}

//
////
//

- (NSString*) restBookNameString : (NSString*) textName withChapterNumber : (NSInteger) chapterNumber  {
    NSString* completeString = [NSString stringWithFormat:@"%@.%d",textName,chapterNumber];
    NSString* urlString = [BASE_REST_PATH stringByAppendingPathComponent : completeString];
    return urlString;
}

- (NSURL*) urlForRestRequest : (NSString*) theURLString  {
    NSURL *url = [NSURL URLWithString: theURLString];
    return url;
}

//
////
//

- (void) basicRestRequest : (NSURL*) pathURL
{
    //__block RestTextDataModel* myRestData = nil;
    NSLog(@"-- request... %@ --", pathURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:pathURL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:10.0];
    //NSURLRequestReloadIgnoringCacheData
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
     {
         NSLog(@"-- Request fetched --");
         if (data.length > 0 && connectionError == nil) {
             NSInteger httpStatus = [((NSHTTPURLResponse *)response) statusCode];
             NSLog(@"http Status : %d",httpStatus);
             [self restResponseObject : pathURL withData:data withConnectionError:connectionError];
         }
     }];
}

//
////
//

- (void) restResponseObject : (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError {
    self.myRestData = [RestTextDataModel myNewRestDataLoader:pathURL withData:myData withConnectionError:connectionError];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"restDataLoaded"
     object:self];
    
    // load into core data
    // post notification
    // load view
}

@end
