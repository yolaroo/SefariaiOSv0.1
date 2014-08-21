//
//  MainFoundation+HebrewTextStyles.h
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (HebrewTextStyles)

- (NSString*) hebrewTextFromArray:(NSIndexPath *)indexPath;
- (NSString*) hebrewTextFromObject:(NSIndexPath *)indexPath;
- (UITableViewCell *) setMyHebrewTextCell: (UITableViewCell*) cell withString :(NSString *) myString;

@end
