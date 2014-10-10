//
//  MainFoundation+FetchTextLineForReading.m
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTextLineForReading.h"

@implementation MainFoundation (FetchTextLineForReading)


- (NSArray*) fetchTextTitleByTitleAndChapter : (TextTitle*) theTextTitle
                                 withChapter : (NSInteger) chapterNumber
                                 withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSPredicate *predicateNameEnglish  = [NSPredicate predicateWithFormat:@"whatTextTitle = %@", theTextTitle];
    NSPredicate *predicateChapterNumber  = [NSPredicate predicateWithFormat:@"chapterNumber = %d", chapterNumber];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateChapterNumber, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


- (NSArray*) fetchChapterTextByName: (NSString*) theTextTitle
                     withChapterNumber: (NSInteger) chapterNumber
                           withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"LineText" inManagedObjectContext:context];
    
    NSPredicate *predicateChapterNumber  = [NSPredicate predicateWithFormat:@"chapterNumber = %d", chapterNumber];
    NSPredicate *predicateTextTitle  = [NSPredicate predicateWithFormat:@"ANY whatTextTitle.englishName == %@", theTextTitle];
        
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateChapterNumber,predicateTextTitle, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

@end
