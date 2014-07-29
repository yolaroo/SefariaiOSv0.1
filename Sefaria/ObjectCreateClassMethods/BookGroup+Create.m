//
//  BookGroup+Create.m
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookGroup+Create.h"

@implementation BookGroup (Create)

+ (BookGroup*)      newBookGroup : (NSString*) theEnglishName
                  withHebrewName : (NSString*) theHebrewName
                     withContext : (NSManagedObjectContext*) context
{
    BookGroup* theBookTitle = nil;
    if ([theEnglishName length] || [theHebrewName length]){
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BookGroup"];
        NSPredicate *predicateNameEnglish = [NSPredicate predicateWithFormat:@"englishName = %@", theEnglishName];
        NSPredicate *predicateNameHebrew = [NSPredicate predicateWithFormat:@"hebrewName = %@", theHebrewName];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateNameEnglish,predicateNameHebrew, nil];
        NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
        request.predicate = orPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            
            theBookTitle = [NSEntityDescription insertNewObjectForEntityForName:@"BookGroup"
                                                         inManagedObjectContext:context];
            
            if ([theEnglishName length]){
                theBookTitle.englishName = theEnglishName;
            }
            else if ([theHebrewName length]){
                theBookTitle.hebrewName = theHebrewName;
            }
        }
        else {
            theBookTitle = [matches lastObject];
            // change
            if ([theEnglishName length]){
                theBookTitle.englishName = theEnglishName;
            }
            else if ([theHebrewName length]){
                theBookTitle.hebrewName = theHebrewName;
            }
        }
    }
    return theBookTitle;
}

@end
