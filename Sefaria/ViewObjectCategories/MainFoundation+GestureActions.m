//
//  MainFoundation+GestureActions.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+GestureActions.h"

@implementation MainFoundation (GestureActions)

- (void) gestureLoader : (UIView*) menuView withChapterView : (UIView*) chapterView
{
    [self.myGestureClass gestureRecognizerGroupForMainView:self.view];
    [self.myGestureClass gestureRecognizerGroupForSecondaryGroupA:chapterView];
    [self.myGestureClass gestureRecognizerGroupForSecondaryGroupB:menuView];
    [self bookGestureNotificationLoader];
}

- (void) bookGestureNotificationLoader {
    [self basicNotifications:@"chapterNextAction" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeLeftMain]];
    [self basicNotifications:@"chapterPreviousAction" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeRightMain]];
    
    [self basicNotifications:@"theMenuActionComplete" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureDoubleTapMain]];
    
    [self basicNotifications:@"theMenuBookActionSingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureLeftEdge]];
    [self basicNotifications:@"theChapterActionsingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureRightEdge]];
    
    [self basicNotifications:@"theMenuBookActionSingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeLeftSecondary]];
    [self basicNotifications:@"theChapterActionsingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeRightSecondary]];
    [self basicNotifications:@"foundationStopSpeech" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureLongPressGesture]];
    
}




@end
