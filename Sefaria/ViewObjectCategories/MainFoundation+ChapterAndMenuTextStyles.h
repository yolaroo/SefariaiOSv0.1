//
//  MainFoundation+ChapterAndMenuTextStyles.h
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (ChapterAndMenuTextStyles)

- (UITableViewCell *) setChapterCell: (UITableViewCell*) cell withString :(NSString *) myString;
- (UITableViewCell *) setMenuCell: (UITableViewCell*) cell withString :(NSString *) myString;

@end
