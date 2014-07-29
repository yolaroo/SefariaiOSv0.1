//
//  BookGroup+Create.h
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookGroup.h"

@interface BookGroup (Create)

+ (BookGroup*)      newBookGroup : (NSString*) theEnglishName
                  withHebrewName : (NSString*) theHebrewName
                     withContext : (NSManagedObjectContext*) context;


@end
