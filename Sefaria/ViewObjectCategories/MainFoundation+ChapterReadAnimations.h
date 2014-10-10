//
//  MainFoundation+ChapterReadAnimations.h
//  Sefaria
//
//  Created by MGM on 7/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (ChapterReadAnimations)

- (void) moveSmallMenuAction : (UIView*) myView;
- (void) moveMenuAction : (UIView*) myView;
- (void) moveChapterAction : (UIView*) myView;

- (void) hideNavBar;
- (void) showNavBar;

- (void) menuAnimationOnLoad : (UIView*) menuView withChapterView : (UIView*) chapterView;

- (void) hideSingleMenu : (UIView*) myView;
- (void) showSingleMenu : (UIView*) myView;


@end
