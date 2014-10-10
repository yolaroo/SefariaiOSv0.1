//
//  MainFoundation+BookMarkActions.h
//  Sefaria
//
//  Created by MGM on 8/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"
#import "LineText.h"

@interface MainFoundation (BookMarkActions)

- (NSString*) appendBookmarkIcon : (LineText*) myLine withString :(NSString*) myString;

- (void) addBookMarkValueToLineText : (UITableView*) tableView  withIndexPath : (NSIndexPath *)indexPath withContext : (NSManagedObjectContext*) context
;

- (void) bookmarkChapterViewSetter : (UIButton*) myButton;
- (void) bookMarkChapterPress : (UIButton*) myButton withContext : (NSManagedObjectContext*) context;
- (void) updateChapterBookmarkView : (bool) isBookmarkedChapter withButton : (UIButton*) myButton;


@end
