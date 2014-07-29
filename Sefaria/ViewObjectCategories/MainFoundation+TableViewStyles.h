//
//  MainFoundation+TableViewStyles.h
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (TableViewStyles)

- (UITableViewCell *) setChapterCell: (UITableViewCell*) cell withString :(NSString *) myString;
- (UITableViewCell *) setMenuCell: (UITableViewCell*) cell withString :(NSString *) myString;
- (UITableViewCell *) setMyEnglishTextCell: (UITableViewCell*) cell withString :(NSString *) myString;
- (UITableViewCell *) setMyHebrewTextCell: (UITableViewCell*) cell withString :(NSString *) myString;

- (CGFloat)tableViewHeightTwoTables:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath;

- (CGFloat)tableViewHeightForSingleTable:(UITableView *)tableView withString : (NSString*) myString;

- (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;

@end
