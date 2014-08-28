//
//  MainFoundation+TableViewStyles.h
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (TableViewStyles)


- (NSInteger) tableViewCellNumberForCoreData:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger) tableViewCellNumberForREST:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

//
////
//

- (CGFloat) tableViewHeightForCoreData:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath;
- (CGFloat) tableViewHeightTwoTables:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath;
- (CGFloat) dualLanguagetableViewHeight:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath;
- (CGFloat) commentHeight : (UITableView*) tableView withIndexPath : (NSIndexPath *)indexPath;

- (CGSize) frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;

- (UILabel*) labelForNumberRightSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell;
- (UILabel*) labelForNumberLeftSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell;



@end
