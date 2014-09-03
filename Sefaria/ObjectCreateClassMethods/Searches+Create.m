//
//  Searches+Create.m
//  Sefaria
//
//  Created by MGM on 9/2/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Searches+Create.h"

@implementation Searches (Create)


//Searches

+ (Searches*) newSearchTitle : (NSString*) theTitle
                  withContext : (NSManagedObjectContext*) context
{
    Searches* theContextGroup = nil;
    if ([theTitle length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Searches"];
        NSPredicate *predicateTitle = [NSPredicate predicateWithFormat:@"name = %@", theTitle];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateTitle, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            
            theContextGroup = [NSEntityDescription insertNewObjectForEntityForName:@"Searches"
                                                            inManagedObjectContext:context];
            theContextGroup.name = theTitle;
        }
        else {
            theContextGroup = [matches lastObject];
            // change
        }
    }
    return theContextGroup;
}


@end
