//
//  GestureClass.h
//  Sefaria
//
//  Created by MGM on 8/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestureClass : NSObject

typedef NS_ENUM(NSInteger, kGestureNames)  {
    kGestureLeftEdge = 0,
    kGestureRightEdge,
    kGestureSwipeLeftMain,
    kGestureSwipeRightMain,
    kGestureDoubleTapMain,
    kGestureSwipeLeftSecondary,
    kGestureSwipeRightSecondary,
    kGestureLongPressGesture
};

- (void) gestureRecognizerGroupForMainView : (UIView*) theView;

- (NSArray*) gestureNotificationNames;

- (void) gestureRecognizerGroupForSecondaryGroupA : (UIView*) theView;
- (void) gestureRecognizerGroupForSecondaryGroupB : (UIView*) theView;




@end