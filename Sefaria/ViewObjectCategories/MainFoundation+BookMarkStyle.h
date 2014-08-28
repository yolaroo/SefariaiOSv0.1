//
//  MainFoundation+BookMarkStyle.h
//  Sefaria
//
//  Created by MGM on 8/26/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (BookMarkStyle)

- (NSString*) bookmarkTextFromObject:(NSIndexPath *)indexPath;
- (NSString*) bookmarkDetailFromObject:(NSIndexPath *)indexPath;

- (UITableViewCell *) setMyBookmarkTextCell: (UITableViewCell*) cell withString :(NSString *) myString withDetailText : (NSString*) myDetail;


- (NSString*) bookmarkChapterTextFromObject:(NSIndexPath *)indexPath;
- (UITableViewCell *) setMyBookmarkChapterTextCell: (UITableViewCell*) cell withString :(NSString *) myString;

@end
