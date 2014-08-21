//
//  MainFoundation+FetchTheComment.m
//  Sefaria
//
//  Created by MGM on 8/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+FetchTheComment.h"

@implementation MainFoundation (FetchTheComment)


- (NSArray*) fetchBookCommentForChapterByTextName : (TextTitle*) theTextTitle
                      withChapterNumber : (NSInteger) chapterNumber
                            withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:context];
    
    NSPredicate *predicateNameEnglish  = [NSPredicate predicateWithFormat:@"whatTextTitle = %@", theTextTitle];
    NSPredicate *predicateNameHebrew  = [NSPredicate predicateWithFormat:@"chapterNumber = %d", chapterNumber];
    
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateNameHebrew, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptorLine = [[NSSortDescriptor alloc] initWithKey:@"lineNumber" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptorLine];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


- (NSArray*) fetchCommentFromEnglishWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:context];
    
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

- (NSArray*) fetchCommentFromHebrewWordSearch : (NSString*)myText withContext : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:context];
    
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


- (NSArray*) fetchAllComments : (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:context];
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


@end
