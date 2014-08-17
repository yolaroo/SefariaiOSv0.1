//
//  MainFoundation+DataControlPageActions.h
//  Sefaria
//
//  Created by MGM on 7/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (DataControlPageActions)

- (void) loadAllTanachData;

- (TextTitle*) myTextTitle : (NSString*) textName withContext : (NSManagedObjectContext*) context;

- (BookTitle*) myBookTitle : (NSString*) bookName withContext : (NSManagedObjectContext*) context;


@end
