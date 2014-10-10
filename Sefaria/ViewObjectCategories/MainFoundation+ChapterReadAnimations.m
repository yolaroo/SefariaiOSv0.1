//
//  MainFoundation+ChapterReadAnimations.m
//  Sefaria
//
//  Created by MGM on 7/27/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+ChapterReadAnimations.h"

@implementation MainFoundation (ChapterReadAnimations)

#define DK 2
#define LOG if(DK == 1)

#define ANIMATE_DURATION 0.6
#define ANIMATE_OPACITY 0.2

#define HIDE_CG CGPointMake(-150.0, 490.0)
#define SHOW_CG CGPointMake(260.0, 388.0)

#define HIDE_CH CGPointMake(1174.0, 490.0)
#define SHOW_CH CGPointMake(764.0, 388.0)

#define HIDE_MENU_POSITION CGPointMake(384.0, 1194.0)
#define SHOW_MENU_POSITION CGPointMake(384.0, 740.0)


//
//
////////
#pragma mark - Small Menu Animation
////////
//
//

- (CGPoint) hideSmallPoint : (UIView*)myView {
    return CGPointMake(-self.view.frame.size.width/(myView.frame.size.width/145), myView.center.y);
}

- (CGPoint) showSmallPoint : (UIView*)myView {
    return CGPointMake(self.view.frame.size.width/2, myView.center.y);
}

- (void) moveSmallMenuAction : (UIView*) myView
{
    LOG NSLog(@"-- animated --");
    if (!self.menuIsMoving) {
        if (self.isMenuShowing) {
            [self hideSmallMenu : myView];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
        else {
            [self showSmallMenu : myView];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
    }
}

//
////
//

- (void) hideSmallMenu : (UIView*) myView {
    LOG NSLog(@"-- hide --");
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = [self hideSmallPoint : myView];
                         myView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

- (void) showSmallMenu : (UIView*) myView {
    LOG NSLog(@"-- show --");

    [self.view bringSubviewToFront:myView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = [self showSmallPoint : myView];
                         myView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}



//
//
////////
#pragma mark - Menu Load Animation
////////
//
//

- (void) menuAnimationOnLoad : (UIView*) menuView withChapterView : (UIView*) chapterView
{
    LOG NSLog(@"main animated");
    [self moveMenuAction:menuView];
    self.menuIsMoving = true;
    self.isMenuShowing = true;
    
    [self moveChapterAction:chapterView];
    self.chapterIsMoving = true;
    self.isChapterShowing = true;
}

//
//
////////
#pragma mark - Menu Animation
////////
//
//

- (void) moveMenuAction : (UIView*) myView
{
    LOG NSLog(@"basic menu action");

    if (!self.menuIsMoving) {
        if (self.isMenuShowing) {
            [self hideMenu : myView];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
        else {
            [self showMenu : myView];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
    }
}

- (void) hideMenu : (UIView*) myView {
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = HIDE_CG;
                         myView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

- (void) showMenu : (UIView*) myView {
    [self.view bringSubviewToFront:myView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = SHOW_CG;
                         myView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

//
//
////////
#pragma mark - Chapter Animation
////////
//
//

- (void) moveChapterAction : (UIView*) myView
{
    if (!self.chapterIsMoving) {
        if (self.isChapterShowing) {
            [self hideChapter : myView];
            self.chapterIsMoving = true;
            self.isChapterShowing = !self.isChapterShowing;
        }
        else {
            [self showChapter : myView];
            self.chapterIsMoving = true;
            self.isChapterShowing = !self.isChapterShowing;
        }
    }
}

- (void) hideChapter : (UIView*) myView  {
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = HIDE_CH;
                         myView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.chapterIsMoving = false;
                     }];
}

- (void) showChapter : (UIView*) myView  {
    [self.view bringSubviewToFront:myView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = SHOW_CH;
                         myView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         self.chapterIsMoving = false;
                     }];
}

//
//
////////
#pragma mark - NavigationBar Hide Action
////////
//
//

- (void) hideNavBar
{
    if (!self.isNavBarShowing) {
        return;
    }
    self.isNavBarShowing = false;
    [UIView animateWithDuration:ANIMATE_DURATION*2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.navigationController.navigationBar.frame =  CGRectOffset(self.navigationController.navigationBar.frame, 0, -40 );
                     }
                     completion:^(BOOL finished){
                         //empty
                     }];
}

- (void) showNavBar
{
    if (self.isNavBarShowing) {
        return;
    }
    
    self.isNavBarShowing = true;
    [UIView animateWithDuration:ANIMATE_DURATION/8
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.navigationController.navigationBar.frame =  CGRectOffset(self.navigationController.navigationBar.frame, 0, 40 );
                     }
                     completion:^(BOOL finished){
                         //[self performSelector:@selector(hideNavBar) withObject:nil afterDelay:2.2];
                     }];
}

//
//
////////
#pragma mark - Single Menu Animation
////////
//
//

- (void) showSingleMenu : (UIView*) myView
{
    [self.view bringSubviewToFront:myView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = SHOW_MENU_POSITION;
                         myView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

- (void) hideSingleMenu : (UIView*) myView
{
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         myView.center = HIDE_MENU_POSITION;
                         myView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

@end
