//
//  CommentAuthor+Create.m
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentAuthor+Create.h"

@implementation CommentAuthor (Create)

+ (CommentAuthor*) newCommentAuthor : (NSString*) theName
                                          withContext : (NSManagedObjectContext*) context
{
    CommentAuthor* theCommentAuthor = nil;
    if ([theName length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CommentAuthor"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name = %@", theName];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            theCommentAuthor = [NSEntityDescription insertNewObjectForEntityForName:@"CommentAuthor"
                                                                      inManagedObjectContext:context];
            
            if ([theName length]){
                theCommentAuthor.name = theName;
            }
        }
        else {
            theCommentAuthor = [matches lastObject];
        }
    }
    return theCommentAuthor;
}

@end
