//
//  ContextGroupData+Create.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroupData+Create.h"

@implementation ContextGroupData (Create)


+ (ContextGroupData*) newContextGroupComment  : (ContextGroup*) whatContextGroup
                             withGroupComment : (NSString*) theComment
                                  withContext : (NSManagedObjectContext*) context
{
    ContextGroupData* theContextGroupData = nil;
    if (whatContextGroup != nil){
        if ([theComment length]){
            theContextGroupData = [NSEntityDescription insertNewObjectForEntityForName:@"ContextGroupData"
                                                                inManagedObjectContext:context];
            
            theContextGroupData.isComment = [NSNumber numberWithBool:true];
            theContextGroupData.whatContextGroup = whatContextGroup;
            
        }
        else {
            NSLog(@"-- Error 0.1a Comment Data Create --");
            return theContextGroupData;
        }
    }
    NSLog(@"-- Error 0.0a Comment Data Create --");
    return theContextGroupData;
}

+ (ContextGroupData*) newContextGroupLineText : (ContextGroup*) whatContextGroup
                                 withLineText : (LineText*) theLineText
                                  withContext : (NSManagedObjectContext*) context
{
    ContextGroupData* theContextGroupData = nil;
    if (whatContextGroup != nil){
        if (theLineText != nil){
            theContextGroupData = [NSEntityDescription insertNewObjectForEntityForName:@"ContextGroupData"
                                                                inManagedObjectContext:context];
            
            theContextGroupData.isLineText = [NSNumber numberWithBool:true];
            theContextGroupData.whatContextGroup = whatContextGroup;
            theContextGroupData.whatLineText = theLineText;
            
        }
        else {
            NSLog(@"-- Error 0.1b Comment Data Create --");
            return theContextGroupData;
        }
    }
    NSLog(@"-- Error 0.0b Comment Data Create --");
    return theContextGroupData;
}

@end
