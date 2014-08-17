//
//  CommentCollectionTitle+Create.h
//  Sefaria
//
//  Created by MGM on 8/3/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentCollectionTitle.h"

@interface CommentCollectionTitle (Create)

+ (CommentCollectionTitle*) newCommentCollectionTitle : (NSString*) theEnglishTitle
                                      withHebrewTitle : (NSString*) theHebrewTitle
                                          withContext : (NSManagedObjectContext*) context;


@end
