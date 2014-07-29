//
//  TextTitle+Create.m
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "TextTitle+Create.h"

@implementation TextTitle (Create)

#define DK 2
#define LOG if(DK == 1)

+ (TextTitle*)      newTextTitle : (NSInteger) theDepthOrder
                 withEnglishName : (NSString*) theEnglishName
                  withHebrewName : (NSString*) theHebrewName
                     withContext : (NSManagedObjectContext*) context
{
    TextTitle* theTextTitle = nil;
    if ([theEnglishName length] || [theHebrewName length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TextTitle"];
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
            theTextTitle = [NSEntityDescription insertNewObjectForEntityForName:@"TextTitle"
                                                         inManagedObjectContext:context];
            
            if ([theEnglishName length]){
                theTextTitle.englishName = theEnglishName;
                theTextTitle.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            else if ([theHebrewName length]){
                theTextTitle.hebrewName = theHebrewName;
                theTextTitle.isHebrew = [NSNumber numberWithBool:TRUE];
            }
            theTextTitle.depthOrderLevel = [NSNumber numberWithInteger:theDepthOrder];
        }
        else {
            theTextTitle = [matches lastObject];
            LOG NSLog(@"-- TEN %@--",theTextTitle.englishName);

            // change
            if ([theEnglishName length]){
                theTextTitle.englishName = theEnglishName;
                theTextTitle.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            else if ([theHebrewName length]){
                theTextTitle.hebrewName = theHebrewName;
                theTextTitle.isHebrew = [NSNumber numberWithBool:TRUE];
            }
        }
    }
    return theTextTitle;
}


@end
