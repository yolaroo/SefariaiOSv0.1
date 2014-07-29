//
//  FileEnumerationData.m
//  Sefaria
//
//  Created by MGM on 7/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "FileEnumerationData.h"

@implementation FileEnumerationData

#define ROOT_DIRECTORY @"TextData"

- (void) writeDirectoryFileData
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *mainURL = [[NSBundle mainBundle] bundleURL];
    NSURL *directoryURL = [mainURL URLByAppendingPathComponent:ROOT_DIRECTORY];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    [self runThroughURLEnum:enumerator];
}

- (void) runThroughURLEnum: (NSDirectoryEnumerator*) enumerator {
    NSMutableArray* myArrayOfFilePaths = [[NSMutableArray alloc]init];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
        }
        else if (! [isDirectory boolValue]) {
            [myArrayOfFilePaths addObject:[self fixURL:url]];
        }
    }
    NSLog(@"-- %@ --",myArrayOfFilePaths);
}

- (NSString*) fixURL: (NSURL*)url {
    NSString* str = [url absoluteString];
    str = [str stringByReplacingOccurrencesOfString:@"file:///Users/piXIII/Library/Application%20Support/iPhone%20Simulator/7.1/Applications/6EAA94BF-5F1B-4001-8D35-B94FA2CD0CB4/Sefaria.app/"
                                         withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@" .json"
                                         withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@".json"
                                         withString:@""];
    
    return [str stringByReplacingOccurrencesOfString:@"%20"
                                          withString:@" "];
    
}

@end
