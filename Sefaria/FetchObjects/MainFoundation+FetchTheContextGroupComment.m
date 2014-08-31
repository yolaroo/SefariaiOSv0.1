//
//  MainFoundation+FetchTheContextGroupComment.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheContextGroupComment.h"

@implementation MainFoundation (FetchTheContextGroupComment)

- (NSArray*) fetchAllContextGroupDataComment : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ContextGroupComment" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


@end
