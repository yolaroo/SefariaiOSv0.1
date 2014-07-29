//
//  MainFoundation+TextDataActionLayer.h
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"


@interface MainFoundation (TextDataActionLayer)

- (NSArray*) setTextFromChapter: (NSArray*) theText theChapterNumber : (NSInteger) theNumber;
- (NSArray*) getBilingualData: (kTanachBooks) theBook theText: (TanachAttributeClass*) theAttribute;

//
//// Test Class
//

- (void) myTextDataModelTest;
- (bool) primaryBookCheck;


@end
