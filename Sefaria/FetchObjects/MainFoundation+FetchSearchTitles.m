//
//  MainFoundation+FetchSearchTitles.m
//  Sefaria
//
//  Created by MGM on 9/2/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchSearchTitles.h"

@implementation MainFoundation (FetchSearchTitles)

- (NSArray*) fetchAllSearchTitles : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Searches" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

@end
