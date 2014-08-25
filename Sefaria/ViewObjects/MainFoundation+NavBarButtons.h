//
//  MainFoundation+NavBarButtons.h
//  Sefaria
//
//  Created by MGM on 8/22/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (NavBarButtons)

- (void) loadPreferences : (UIButton*) soundButton;
- (void) saveSoundPreferences;
- (void) soundButtonViewChange : (UIButton*) soundButton;
- (void) soundPressAction : (UIButton*) soundButton;
- (void) fontPressAction : (UITableView*) engTableView withHebrewTableView : (UITableView*) hebrewTableView;
- (void) bookmarkPressAction : (UIButton*) bookMarkButton;
- (void) navHidePressAction;

- (void) loadingReadingPreferences;
- (void) saveReadingPreferences;

@end
