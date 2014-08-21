//
//  MainFoundation+EnglishTextStyle.h
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (EnglishTextStyle)

- (NSString*) englishTextFromArray:(NSIndexPath *)indexPath;
- (NSString*) englishTextFromObject:(NSIndexPath *)indexPath;
- (UITableViewCell *) setMyEnglishTextCell: (UITableViewCell*) cell withString :(NSString *) myString;


@end
