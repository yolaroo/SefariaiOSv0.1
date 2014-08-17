//
//  MainFoundation+FetchTheTextTitle.m
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheTextTitle.h"

@implementation MainFoundation (FetchTheTextTitle)

- (NSArray*) fetchTextTitleByNameString:(NSString*) theName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"TextTitle" inManagedObjectContext:context];
    
    NSPredicate *predicateNameEnglish  = [NSPredicate predicateWithFormat:@"englishName = %@", theName];
    NSPredicate *predicateNameHebrew  = [NSPredicate predicateWithFormat:@"hebrewName = %@", theName];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateNameHebrew, nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = orPredicate;
    
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    //NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    //[fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (void) testFetchTextTitle : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"TextTitle" inManagedObjectContext:context];
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"-- CFTC %lu --",(unsigned long)[fetchedRecords count]);
    for (TextTitle* TTT in fetchedRecords) {
        NSLog(@"-- CFTEXT  %@ --",TTT.englishName);
    }
}

//
////
//

- (NSArray*) fetchTextTitleByBookTitleObject:(BookTitle*) theBookTitle withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"TextTitle" inManagedObjectContext:context];
    
    NSPredicate *predicateBookTitleObject  = [NSPredicate predicateWithFormat:@"whatBookTitle = %@", theBookTitle];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateBookTitleObject, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayOrder" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


@end
