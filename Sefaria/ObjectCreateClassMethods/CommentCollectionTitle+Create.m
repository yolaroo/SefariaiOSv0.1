//
//  CommentCollectionTitle+Create.m
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentCollectionTitle+Create.h"

@implementation CommentCollectionTitle (Create)

#define DK 2
#define LOG if(DK == 1)

+ (CommentCollectionTitle*) newCommentCollectionTitle : (NSString*) theEnglishTitle
                                      withHebrewTitle : (NSString*) theHebrewTitle
                                          withContext : (NSManagedObjectContext*) context
{
    CommentCollectionTitle* theCommentCollectionTitle = nil;
    if ([theEnglishTitle length] || [theHebrewTitle length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CommentCollectionTitle"];
        NSPredicate *predicateEnglishName = [NSPredicate predicateWithFormat:@"englishName = %@", theEnglishTitle];
        NSPredicate *predicateHebrewName = [NSPredicate predicateWithFormat:@"hebrewName = %@", theHebrewTitle];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateEnglishName,predicateHebrewName, nil];
        NSPredicate *orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
        request.predicate = orPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            theCommentCollectionTitle = [NSEntityDescription insertNewObjectForEntityForName:@"CommentCollectionTitle"
                                                         inManagedObjectContext:context];
            
            if ([theEnglishTitle length]){
                theCommentCollectionTitle.englishName = theEnglishTitle;
            }
            if ([theHebrewTitle length]){
                theCommentCollectionTitle.hebrewName = theHebrewTitle;
            }
        }
        else {
            theCommentCollectionTitle = [matches lastObject];
            
            if ([theEnglishTitle length]){
                theCommentCollectionTitle.englishName = theEnglishTitle;
            }
            if ([theHebrewTitle length]){
                theCommentCollectionTitle.hebrewName = theHebrewTitle;
            }
        }
    }
    return theCommentCollectionTitle;
}


@end
