//
//  GestureClass.m
//  Sefaria
//
//  Created by MGM on 8/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "GestureClass.h"

@interface GestureClass ()

@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer * edgeLeftPanGesture;
@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer * edgeRightPanGesture;

@property (strong,nonatomic) UISwipeGestureRecognizer * swipeLeftMainGesture;
@property (strong,nonatomic) UISwipeGestureRecognizer * swipeRightMainGesture;

@property (strong,nonatomic) UITapGestureRecognizer * doubleTapMainGesture;

@property (strong,nonatomic) UISwipeGestureRecognizer * swipeLeftSecondaryGesture;
@property (strong,nonatomic) UISwipeGestureRecognizer * swipeRightSecondaryGesture;

@property (strong,nonatomic) UILongPressGestureRecognizer * longPressGesture;

@end

//
////
//

@implementation GestureClass

@synthesize edgeLeftPanGesture=_edgeLeftPanGesture,edgeRightPanGesture=_edgeRightPanGesture,swipeLeftMainGesture=_swipeLeftMainGesture,swipeRightMainGesture=_swipeRightMainGesture,doubleTapMainGesture=_doubleTapMainGesture,swipeLeftSecondaryGesture=_swipeLeftSecondaryGesture,swipeRightSecondaryGesture=_swipeRightSecondaryGesture,longPressGesture=_longPressGesture;

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - Gesture Load
////////
//
//

- (void) gestureRecognizerGroupForMainView : (UIView*) theView
{
    LOG NSLog(@"Gesture Loaded");
    [theView addGestureRecognizer:self.edgeLeftPanGesture];
    [theView addGestureRecognizer:self.edgeRightPanGesture];
    
    [theView addGestureRecognizer:self.swipeLeftMainGesture];
    [theView addGestureRecognizer:self.swipeRightMainGesture];
    //
    [theView addGestureRecognizer:self.doubleTapMainGesture];
    [theView addGestureRecognizer:self.longPressGesture];
}

- (void) gestureRecognizerGroupForSecondaryGroupA : (UIView*) theView
{
    [theView addGestureRecognizer: self.swipeRightSecondaryGesture];
}

- (void) gestureRecognizerGroupForSecondaryGroupB : (UIView*) theView
{
    [theView addGestureRecognizer:self.swipeLeftSecondaryGesture];
}

//
//
////////
#pragma mark - Gesture Notification Array
////////
//
//

- (NSArray*) gestureNotificationNames
{
    return @[
             @"leftEdgeGesture",
             @"rightEdgeGesture",
             @"swipeLeftMain",
             @"swipeRightMain",
             @"doubleTapMain",
             @"swipeLeftSecondary",
             @"swipeRightSecondary",
             @"pressLongGesture",
             ];
}

//
//
////////
#pragma mark - Gesture Setters
////////
//
//

- (UILongPressGestureRecognizer *) longPressGesture {
    if(!_longPressGesture) {
        _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCheck:)];
        [_longPressGesture setMinimumPressDuration:1.0f];
    }
    return _longPressGesture;
}

- (void) longPressCheck:(UILongPressGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"pressLongGesture"
     object:self];
}

//
////
//

- (UIScreenEdgePanGestureRecognizer *) edgeLeftPanGesture {
    if (!_edgeLeftPanGesture){
        _edgeLeftPanGesture =
        [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(leftEdgeCheck:)];
        [_edgeLeftPanGesture setEdges:UIRectEdgeLeft];
    }
    return _edgeLeftPanGesture;
}

- (void) leftEdgeCheck:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"leftEdgeGesture"
     object:self];
    //[self moveMenuAction : self.mainMenuView];
}

- (UIScreenEdgePanGestureRecognizer *) edgeRightPanGesture {
    if (!_edgeRightPanGesture){
        _edgeRightPanGesture =
        [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(rightEdgeCheck:)];
        [_edgeRightPanGesture setEdges:UIRectEdgeRight];
    }
    return _edgeRightPanGesture;
}

- (void) rightEdgeCheck:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"rightEdgeGesture"
     object:self];
    //[self moveChapterAction : self.mainChapterView];
}

//
////
//

- (UISwipeGestureRecognizer *) swipeLeftMainGesture {
    if (!_swipeLeftMainGesture){
        _swipeLeftMainGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(nextAction:)];
        [_swipeLeftMainGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _swipeLeftMainGesture;
}

- (void) nextAction:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeLeftMain"
     object:self];
    //[self chapterNextAction];
}

- (UISwipeGestureRecognizer *) swipeRightMainGesture {
    if (!_swipeRightMainGesture){
        _swipeRightMainGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(previousAction:)];
        [_swipeRightMainGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _swipeRightMainGesture;
}

- (void) previousAction:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeRightMain"
     object:self];
    //[self chapterPreviousAction];
}

//
////
//

- (UITapGestureRecognizer *) doubleTapMainGesture {
    if (!_doubleTapMainGesture){
        _doubleTapMainGesture =
        [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(hideMenus:)];
        [_doubleTapMainGesture setNumberOfTapsRequired:2];
    }
    return _doubleTapMainGesture;
}

- (void) hideMenus:(UITapGestureRecognizer*) recognizer{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"doubleTapMain"
     object:self];
    //[self moveMenuAction : self.mainMenuView];
    //[self moveChapterAction : self.mainChapterView];
}

//
//
////
#pragma mark - Menu Gestures
////
//
//

- (UISwipeGestureRecognizer *) swipeLeftSecondaryGesture {
    if (!_swipeLeftSecondaryGesture){
        _swipeLeftSecondaryGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(closeMenu:)];
        [_swipeLeftSecondaryGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _swipeLeftSecondaryGesture;
}

- (void) closeMenu:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeLeftSecondary"
     object:self];
    //[self moveMenuAction : self.mainMenuView];
}

- (UISwipeGestureRecognizer *) swipeRightSecondaryGesture {
    if (!_swipeRightSecondaryGesture){
        _swipeRightSecondaryGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(closeChapter:)];
        [_swipeRightSecondaryGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _swipeRightSecondaryGesture;
}

- (void) closeChapter:(UISwipeGestureRecognizer *)recognizer {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeRightSecondary"
     object:self];
    //[self moveChapterAction : self.mainChapterView];
}




@end
