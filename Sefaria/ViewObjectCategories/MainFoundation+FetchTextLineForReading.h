//
//  MainFoundation+FetchTextLineForReading.h
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"
#import "TextTitle.h"

@interface MainFoundation (FetchTextLineForReading)

- (NSArray*) fetchTextTitleByTitleAndChapter:(TextTitle*) theTextTitle withChapter : (NSInteger) chapterNumber withContext: (NSManagedObjectContext*) context;


@end
