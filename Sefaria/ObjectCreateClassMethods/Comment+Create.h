//
//  Comment+Create.h
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Comment.h"

@interface Comment (Create)

+ (Comment*)    newComment : (TextTitle*) theTextTitle
           withEnglishText : (NSString*) theEnglishText
            withHebrewText : (NSString*) theHebrewtext
                withAuthor : (CommentAuthor*) theCommentAuthor
       withCollectionTitle : (CommentCollectionTitle*) theCollectionTitle
              withLineText : (LineText*) theLineText
         withChapterNumber : (NSInteger) theChapterNumber
            withLineNumber : (NSInteger) theLineNumber
               withContext : (NSManagedObjectContext*) context;

@end
