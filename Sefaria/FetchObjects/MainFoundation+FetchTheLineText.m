//
//  MainFoundation+FetchTheLineText.m
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheLineText.h"

@implementation MainFoundation (FetchTheLineText)

- (NSArray*) fetchLineTextByAttributes: (TextTitle*) theTextTitle
                        withLineNumber: (NSInteger) lineNumber
                     withChapterNumber: (NSInteger) chapterNumber
                           withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSPredicate *predicateLineNumber  = [NSPredicate predicateWithFormat:@"lineNumber = %d", lineNumber];
    NSPredicate *predicateChapterNumber  = [NSPredicate predicateWithFormat:@"chapterNumber = %d", chapterNumber];
    NSPredicate *predicateTextTitle  = [NSPredicate predicateWithFormat:@"whatTextTitle = %@", theTextTitle];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateLineNumber,predicateChapterNumber,predicateTextTitle, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) fetchLineTextFromEnglishWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSPredicate *predicateWordSearch  = [NSPredicate predicateWithFormat:@"englishText CONTAINS[cd] %@", myText];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateWordSearch, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;

    NSSortDescriptor *sortDescriptorText = [[NSSortDescriptor alloc] initWithKey:@"whatTextTitle" ascending:YES];
    NSSortDescriptor *sortDescriptorChapter = [[NSSortDescriptor alloc] initWithKey:@"chapterNumber" ascending:YES];
    NSSortDescriptor *sortDescriptorLine = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptorText,sortDescriptorChapter,sortDescriptorLine, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) fetchLineTextFromHebrewWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSPredicate *predicateWordSearch  = [NSPredicate predicateWithFormat:@"hebrewText CONTAINS[cd] %@", myText];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateWordSearch, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptorText = [[NSSortDescriptor alloc] initWithKey:@"whatTextTitle" ascending:YES];
    NSSortDescriptor *sortDescriptorChapter = [[NSSortDescriptor alloc] initWithKey:@"chapterNumber" ascending:YES];
    NSSortDescriptor *sortDescriptorLine = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptorText,sortDescriptorChapter,sortDescriptorLine, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (void) testFetchLineText : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"-- TFLT %lu --",(unsigned long)[fetchedRecords count]);

}

@end
