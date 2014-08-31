//
//  MainFoundation+MainViewActions.h
//  Sefaria
//
//  Created by MGM on 7/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (MainViewActions)

- (void) emptyTextAlert;

- (void) viewShadow: (UIView*) shadowObject;
- (void) viewShadowDarkBorder: (UIView*)shadowObject;

- (void) flipScreenPortrait;

- (NSArray*) chapterNumberArray: (NSInteger) maxNumber;

- (BOOL) isLanguageHebrew : (NSString*) myString;


- (void) stopAI;
- (void) startAI;

- (UIImage*) loadBGImage: (NSString*) nameOfBG;

- (void) animateBouncingObjects : (NSArray*) viewGroup;

- (NSString*) removeHTMLFromString : (NSString*) myString;


@end
