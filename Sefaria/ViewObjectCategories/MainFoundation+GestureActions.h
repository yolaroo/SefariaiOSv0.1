//
//  MainFoundation+GestureActions.h
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (GestureActions)

- (void) noMenuGesture;
- (void) gestureLoader : (UIView*)firstView withChapterView : (UIView*)chapterView;
- (void) iphoneGestureLoader : (UIView*) smallMenuView;

@end
