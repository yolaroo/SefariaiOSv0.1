//
//  MainFoundation+NavBarButtons.m
//  Sefaria
//
//  Created by MGM on 8/22/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+NavBarButtons.h"

#import "MainFoundation+ChapterReadAnimations.h"

@implementation MainFoundation (NavBarButtons)

- (void) loadPreferences : (UIButton*) soundButton
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"sound"] == TRUE) {
        self.soundSet = false;
    } else {
        self.soundSet = true;
    }
    [self soundButtonViewChange : soundButton];
}

- (void) saveSoundPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.soundSet) {
        [defaults setBool:false forKey:@"sound"];
    } else {
        [defaults setBool:true forKey:@"sound"];
    }
    [defaults synchronize];
}


- (void) loadingReadingPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.myCurrentTextTitle = [defaults stringForKey:@"textTitle"];
    self.theChapterMax = [defaults integerForKey:@"chapterMax"];
    self.theChapterNumber = [defaults integerForKey:@"currentChapter"];
    
    NSLog(@"-- numbers %d %d --",self.theChapterNumber,self.theChapterMax);
}

- (void) saveReadingPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.myCurrentTextTitle forKey:@"textTitle"];
    [defaults setInteger:self.theChapterNumber forKey:@"currentChapter"];
    [defaults setInteger:self.theChapterMax forKey:@"chapterMax"];
    [defaults synchronize];
}

- (void) soundButtonViewChange : (UIButton*) soundButton
{
    if (!self.soundSet) {
        [soundButton setTitle:@"📣" forState:UIControlStateNormal];
    } else {
        [soundButton setTitle:@"📢" forState:UIControlStateNormal];
    }
}

- (void) soundPressAction : (UIButton*) soundButton
{
    [self foundationChangeSoudDefaults];
    self.soundSet = !self.soundSet;
    [self soundButtonViewChange : soundButton];
    [self saveSoundPreferences];
}

- (void) fontPressAction : (UITableView*) engTableView withHebrewTableView : (UITableView*) hebrewTableView
{
    self.fontSizeLargeSet = !self.fontSizeLargeSet;
    [engTableView reloadData];
    [hebrewTableView reloadData];
}

- (void) bookmarkPressAction : (UIButton*) bookMarkButton
{
    self.bookmarkSet = !self.bookmarkSet;
    if (!self.bookmarkSet) {
        [bookMarkButton setTitle:@"📖" forState:UIControlStateNormal];
    } else {
        [bookMarkButton setTitle:@"🔖" forState:UIControlStateNormal];
    }
}

- (void) navHidePressAction
{
    self.navHideSet = !self.navHideSet;
    [self hideNavBar];
}


@end
