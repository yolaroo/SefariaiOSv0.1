//
//  MainFoundation+FetchTheContextGroupData.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheContextGroupData.h"

@implementation MainFoundation (FetchTheContextGroupData)

- (NSArray*) fetchAllContextGroupData : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ContextGroupData" inManagedObjectContext:context];
    
    NSSortDescriptor *sortDescriptorisplayOrder = [[NSSortDescriptor alloc] initWithKey:@"displayOrder" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptorisplayOrder, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


@end
