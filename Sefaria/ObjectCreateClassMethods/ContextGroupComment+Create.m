//
//  ContextGroupComment+Create.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroupComment+Create.h"

@implementation ContextGroupComment (Create)

+ (ContextGroupComment*) newContextGroupComment : (NSString*) theComment
                                  withDataGroup : (ContextGroupData*) whatDataGroup
                                    withContext : (NSManagedObjectContext*) context
{
    ContextGroupComment* theContextGroupComment = nil;
    if ([theComment length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ContextGroupComment"];
        NSPredicate *predicateComment = [NSPredicate predicateWithFormat:@"theComment = %@", theComment];
        NSPredicate *predicateDataGroup = [NSPredicate predicateWithFormat:@"whatData = %@", whatDataGroup];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateComment,predicateDataGroup, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            
            theContextGroupComment = [NSEntityDescription insertNewObjectForEntityForName:@"ContextGroupComment"
                                                         inManagedObjectContext:context];
            
            if ([theComment length]){
                theContextGroupComment.comment = theComment;
            }
            theContextGroupComment.whatData = whatDataGroup;

        }
        else {
            theContextGroupComment = [matches lastObject];
            // change
        }
    }
    return theContextGroupComment;
}

@end
