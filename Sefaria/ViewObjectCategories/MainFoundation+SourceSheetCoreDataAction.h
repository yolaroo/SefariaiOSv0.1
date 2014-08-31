//
//  MainFoundation+SourceSheetCoreDataAction.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

#import "SourceSheetObject.h"

@interface MainFoundation (SourceSheetCoreDataAction)

- (void) createSourceSheetCoreDataObject : (SourceSheetObject*) mySourceSheet withContext : (NSManagedObjectContext*) context;

- (void) testFetchSourceSheetwithContext : (NSManagedObjectContext*) context;



@end
