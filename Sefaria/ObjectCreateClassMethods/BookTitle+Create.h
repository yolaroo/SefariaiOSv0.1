//
//  BookTitle+Create.h
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookTitle.h"

@interface BookTitle (Create)

+ (BookTitle*)      newBookTitle : (NSInteger) theDepthOrder
                 withEnglishName : (NSString*) theEnglishName
                  withHebrewName : (NSString*) theHebrewName
                     withContext : (NSManagedObjectContext*) context;


@end
