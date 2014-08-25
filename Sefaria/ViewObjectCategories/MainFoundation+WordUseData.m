//
//  MainFoundation+WordUseData.m
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+WordUseData.h"

#import "MainFoundation+FetchTheLineText.h"

@implementation MainFoundation (WordUseData)

- (void) textToWordList : (NSManagedObjectContext*) context
{
    NSLog(@"Run Word Check");
    NSArray* myLineTextArray = [self fetchAllLineText:context];
    NSMutableArray* myArray = [[NSMutableArray alloc]init];
    
    for (LineText* MLT in myLineTextArray) {
        NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSString *trimmedReplacement = [[MLT.englishText componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@" "];
        NSString *newString = [trimmedReplacement stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@""];
        [ MLT.englishText stringByTrimmingCharactersInSet:charactersToRemove ];
        [myArray addObject:newString];
    }
    
    NSArray* returnArray = [self stringArrayToSet : myArray];
    NSLog(@"-- Return Count %d --",[returnArray count]);
    
    NSArray* sortedArray = [returnArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@" %@ ",sortedArray);
}

- (NSArray*) stringArrayToSet : (NSArray*) myStringArray{
    NSMutableSet* mySet = [[NSMutableSet alloc]init];
    
    for (NSString* STR in myStringArray){
        [mySet addObjectsFromArray:[STR componentsSeparatedByString:@" "]];
    }
    return [mySet allObjects];
}

@end
