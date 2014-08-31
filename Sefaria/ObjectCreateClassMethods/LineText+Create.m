//
//  LineText+Create.m
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "LineText+Create.h"

@implementation LineText (Create)

+ (LineText*) newLineText : (NSString*) theContentText
            withBookTitle : (BookTitle*) theBookTitle
            withTextTitle : (TextTitle*) theTextTitle
        withChapternumber : (NSInteger)  theChapterNumber
           withLineNumber : (NSInteger)  theLineNumber
             withLanguage : (NSString*) theLanguage
              withContext : (NSManagedObjectContext*) context
{
    LineText* theLineText = nil;
    if ([theContentText length]){
        
        //NSLog(@"-- CN HERE %d--",theChapterNumber);
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LineText"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"englishText = %@", theContentText];
        
        NSPredicate *predicatetheBookTitle = [NSPredicate predicateWithFormat:@"ANY whatBookTitle == %@", theBookTitle];
        NSPredicate *predicatetheTextTitle = [NSPredicate predicateWithFormat:@"whatTextTitle = %@", theBookTitle];
        NSPredicate *predicatetheChapterNumber = [NSPredicate predicateWithFormat:@"chapterNumber = %d", theChapterNumber];
        NSPredicate *predicatetheLineNumber = [NSPredicate predicateWithFormat:@"lineNumber = %d", theLineNumber];

        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicatetheBookTitle,predicatetheTextTitle,predicatetheChapterNumber,predicatetheLineNumber, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;

        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];

        if (!matches || ([matches count] > 1)) {
            //error
        } else if (![matches count]) {
            theLineText = [NSEntityDescription insertNewObjectForEntityForName:@"LineText"
                                                    inManagedObjectContext:context];

            if ([theLanguage isEqualToString:@"english"]){
                theLineText.englishText = theContentText;
                theLineText.isEnglish = [NSNumber numberWithBool:TRUE];
            }
            else if ([theLanguage isEqualToString:@"hebrew"]){
                theLineText.hebrewText = theContentText;
                theLineText.isHebrew = [NSNumber numberWithBool:TRUE];
            }
            theLineText.lineNumber = [NSNumber numberWithInteger:theLineNumber];
            theLineText.chapterNumber = [NSNumber numberWithInteger:theChapterNumber];
            theLineText.whatBookTitle = [NSSet setWithObject:theBookTitle];
            theLineText.whatTextTitle = theTextTitle;
        }
        else {
            theLineText = [matches lastObject];
        }
    }
    return theLineText;
}

@end
