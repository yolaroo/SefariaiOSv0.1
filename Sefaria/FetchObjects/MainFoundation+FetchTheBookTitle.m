//
//  MainFoundation+FetchTheBookTitle.m
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheBookTitle.h"
#import "MainFoundation+FetchTheTextTitle.h"

@implementation MainFoundation (FetchTheBookTitle)

- (NSArray*) fetchBookTitleByNameString:(NSString*) theName withContext: (NSManagedObjectContext*) context
{    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:context];
    
    NSPredicate *predicateNameEnglish  = [NSPredicate predicateWithFormat:@"englishName = %@", theName];
    NSPredicate *predicateNameHebrew  = [NSPredicate predicateWithFormat:@"hebrewName = %@", theName];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateNameHebrew, nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = orPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) fetchBookTitleFromDepth: (NSInteger) depthNumber withContext :(NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:context];

    NSPredicate *predicateDepth  = [NSPredicate predicateWithFormat:@"depthOrderLevel = %d", depthNumber];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateDepth, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;

    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) fetchBookTitleForSubSet : (NSString*) theName withContext :(NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:context];
    
    NSPredicate *predicateNameEnglish  = [NSPredicate predicateWithFormat:@"englishName CONTAINS[cd] %@", theName];
    NSPredicate *predicateNameHebrew  = [NSPredicate predicateWithFormat:@"hebrewName CONTAINS[cd] %@", theName];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateNameHebrew, nil];
    NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = orPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayOrder" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];

    BookTitle* myBookTitle = [fetchedRecords firstObject];
    bool myboolForTextTitles = [myBookTitle.hasTextTitleAsSubset boolValue];
    if (myBookTitle != nil && !myboolForTextTitles) {
        NSArray* bookTitleSubArray = [myBookTitle.whatBookTitleSub allObjects];
        NSArray* bookTitlesOrdered = [self orderByDisplayNumber:bookTitleSubArray];
        if ([bookTitlesOrdered count] == [bookTitleSubArray count]){
            return bookTitlesOrdered;
        }
        else {
            NSLog(@"Error - Display Order for Subtitles");
            return bookTitleSubArray;
        }
    }
    else if (myboolForTextTitles) {
        NSArray* myTextTitleArray = [self fetchTextTitleByBookTitleObject:myBookTitle withContext:context];
        return myTextTitleArray;
    }
    else {
        NSLog(@"Error no fetch results for booktitle subset");
        return @[];
    }
}

- (NSArray*) orderByDisplayNumber : (NSArray*) myArray {
    NSInteger bookCount = 0;
    NSMutableArray* myNewArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= [myNewArray count]; i++) {
        for (BookTitle* BTL in myArray) {
            if ([BTL.displayOrder integerValue] == bookCount) {
                [myNewArray addObject:BTL];
                bookCount++;
            }
        }
    }
    return [myNewArray copy];
}

//
////
//

- (void) testFetchBookTitle: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"BookTitle" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];

    NSLog(@"-- CBTC %lu --",(unsigned long)[fetchedRecords count]);
    for (BookTitle* TBT in fetchedRecords) {
        NSLog(@"-- CFBOOKT  %@ --",TBT.englishName);
    }

}


@end
