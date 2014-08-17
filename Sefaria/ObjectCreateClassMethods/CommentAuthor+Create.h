//
//  CommentAuthor+Create.h
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentAuthor.h"

@interface CommentAuthor (Create)

+ (CommentAuthor*) newCommentAuthor : (NSString*) theName
                        withContext : (NSManagedObjectContext*) context;

@end
