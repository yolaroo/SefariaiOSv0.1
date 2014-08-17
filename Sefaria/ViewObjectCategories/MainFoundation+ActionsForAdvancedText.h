//
//  MainFoundation+ActionsForAdvancedText.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (ActionsForAdvancedText)


- (NSArray*) textDataExtract: (NSArray*) myTextArray;
- (NSArray*) getTextListData: (NSString*)textName;


- (NSString*) stringPathFormat :(NSString*) myPathFromPress;
- (NSString*) stringFormatForForm :(NSString*) myString;

- (void) testMenuRecursion;

@end
