//
//  Comment+Create.m
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Comment+Create.h"

@implementation Comment (Create)


#define DK 2
#define LOG if(DK == 1)

+ (Comment*)    newComment : (TextTitle*) theTextTitle
           withEnglishText : (NSString*) theEnglishText
            withHebrewText : (NSString*) theHebrewtext
                withAuthor : (CommentAuthor*) theCommentAuthor
       withCollectionTitle : (CommentCollectionTitle*) theCollectionTitle
              withLineText : (LineText*) theLineText
         withChapterNumber : (NSInteger) theChapterNumber
            withLineNumber : (NSInteger) theLineNumber
               withContext : (NSManagedObjectContext*) context
{
    Comment* theComment = nil;
    if ([theEnglishText length] || [theHebrewtext length]){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Comment"];
        
        NSPredicate *predicateTheCommentAuthor = [NSPredicate predicateWithFormat:@"whatAuthor = %@", theCommentAuthor];
        NSPredicate *predicateTheTextTitle = [NSPredicate predicateWithFormat:@"whatTextTitle = %@", theTextTitle];
        NSPredicate *predicateTheChapterNumber = [NSPredicate predicateWithFormat:@"chapterNumber = %d", theChapterNumber];
        NSPredicate *predicateTheLineNumber = [NSPredicate predicateWithFormat:@"lineNumber = %d", theLineNumber];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateTheCommentAuthor,predicateTheTextTitle, predicateTheChapterNumber,predicateTheLineNumber,nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            theComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                         inManagedObjectContext:context];
            
            if ([theEnglishText length]){
                theComment.englishText = theEnglishText;
                LOG NSLog(@"-- 0.0a TCTEng %@ --",theComment.englishText);
                theComment.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            if ([theHebrewtext length]){
                theComment.hebrewText = theHebrewtext;
                LOG NSLog(@"-- 0.0b TCTHeb %@ --",theComment.hebrewText);
                theComment.isHebrew = [NSNumber numberWithBool:TRUE];
            }
            theComment.whatAuthor = theCommentAuthor;
            theComment.whatCollectionTitle = theCollectionTitle;
            theComment.whatLineText = theLineText;
            theComment.whatTextTitle = theTextTitle;
            theComment.chapterNumber = [NSNumber numberWithInteger : theChapterNumber];
            theComment.lineNumber = [NSNumber numberWithInteger : theLineNumber];
        }
        else {
            theComment = [matches lastObject];
            LOG NSLog(@"-- Error MATCH COMMENT %@--",theComment.englishText);
            // change
            if ([theEnglishText length]){
                NSLog(@"change english comment");
                theComment.englishText = theEnglishText;
                theComment.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            if ([theHebrewtext length]){
                NSLog(@"change hebrew comment");
                theComment.hebrewText = theHebrewtext;
                theComment.isHebrew = [NSNumber numberWithBool:TRUE];
            }
        }
    }
    return theComment;
}

@end
