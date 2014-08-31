//
//  ContextGroup+Create.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroup+Create.h"

@implementation ContextGroup (Create)

+ (ContextGroup*) newContextGroup : (NSString*) theTitle
                     withSubTitle : (NSString*) theSubTitle
                      withContext : (NSManagedObjectContext*) context
{
    ContextGroup* theContextGroup = nil;
    if ([theTitle length] && [theSubTitle length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ContextGroup"];
        NSPredicate *predicateTitle = [NSPredicate predicateWithFormat:@"title = %@", theTitle];
        NSPredicate *predicateSubTitle = [NSPredicate predicateWithFormat:@"subTitle = %@", theSubTitle];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateTitle,predicateSubTitle, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            
            theContextGroup = [NSEntityDescription insertNewObjectForEntityForName:@"ContextGroup"
                                                                   inManagedObjectContext:context];
            theContextGroup.title = theTitle;
            theContextGroup.subTitle = theSubTitle;
        }
        else {
            theContextGroup = [matches lastObject];
            // change
        }
    }
    return theContextGroup;
}


@end
