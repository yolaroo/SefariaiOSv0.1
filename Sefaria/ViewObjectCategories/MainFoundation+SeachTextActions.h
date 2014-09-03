//
//  MainFoundation+SeachTextActions.h
//  Sefaria
//
//  Created by MGM on 8/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SeachTextActions)

- (NSArray*) combinedTextSearchLineWrite : (NSObject*) myObject;

- (NSString*) searchDataSetterForTextOnly : (NSString*) myString;
- (NSString*) searchDataSetterForCommentsOnly : (NSString*) myString;
- (NSString*) searchDataSetterForAllCases : (NSString*) myString;

- (void) addBookMarkValueToSearchText : (UITableView*) tableView withLineText : (LineText*) myLineText withIndexPath : (NSIndexPath *)indexPath withContext : (NSManagedObjectContext*) context;

- (void) createSearchTitle : (NSManagedObjectContext*) context;
- (void) fetchSearchTitleDataArray : (NSManagedObjectContext*) context;





@end
