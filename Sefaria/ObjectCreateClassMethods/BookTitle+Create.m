//
//  BookTitle+Create.m
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookTitle+Create.h"

@implementation BookTitle (Create)

+ (BookTitle*)      newBookTitle : (NSInteger) theDepthOrder
                 withEnglishName : (NSString*) theEnglishName
                  withHebrewName : (NSString*) theHebrewName
                     withContext : (NSManagedObjectContext*) context
{
    BookTitle* theBookTitle = nil;
    if ([theEnglishName length] || [theHebrewName length]){
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BookTitle"];
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
            
            theBookTitle = [NSEntityDescription insertNewObjectForEntityForName:@"BookTitle"
                                                        inManagedObjectContext:context];
            
            if ([theEnglishName length]){
                theBookTitle.englishName = theEnglishName;
                theBookTitle.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            else if ([theHebrewName length]){
                theBookTitle.hebrewName = theHebrewName;
                theBookTitle.isHebrew = [NSNumber numberWithBool:TRUE];
            }
            theBookTitle.depthOrderLevel = [NSNumber numberWithInteger:theDepthOrder];
        }
        else {
            theBookTitle = [matches lastObject];
            // change
            if ([theEnglishName length]){
                theBookTitle.englishName = theEnglishName;
                theBookTitle.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            else if ([theHebrewName length]){
                theBookTitle.hebrewName = theHebrewName;
                theBookTitle.isHebrew = [NSNumber numberWithBool:TRUE];
            }
        }
    }
    return theBookTitle;
}

@end
