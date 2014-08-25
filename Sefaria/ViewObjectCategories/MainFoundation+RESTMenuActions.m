//
//  MainFoundation+RESTMenuActions.m
//  Sefaria
//
//  Created by MGM on 8/22/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+RESTMenuActions.h"

#import "MainFoundation+RestTextActions.h"

@implementation MainFoundation (RESTMenuActions)

#define DK 2
#define LOG if(DK == 1)

//@property (nonatomic, strong) RestTextDataFetch* myRestDataFetch;
//@property (nonatomic, strong) RestMenuDataFetch* myMenuRestDataFetch;

//@property (strong,nonatomic) RestTextDataFetch* myRestTextDataFetch;
//@property (strong,nonatomic) RestMenuDataFetch* myRestMenuDataFetch;

//
//
////////
#pragma mark - Full Menu Data
////////
//
//

- (void) theZeroDepthMenuLoad
{
    LOG NSLog(@"initial menu set");
    NSArray* myMenu0 = [self intialRestMenuFetch: self.myRestMenuDataFetch withDataArray:self.myRestMenuDataFetch.myMenuRestData.theCompleteDictionary];
    self.menuListArray = [myMenu0 firstObject];
    self.menuListPathArray = [myMenu0 lastObject];
    [self.menuTopPathChoiceArray removeAllObjects];
    self.isTextLevel = false;
    self.isBookLevel = true;
    self.menuDepthCount = 0;
    [self.menuChoiceArray removeAllObjects];
    [self.menuPathChoiceArray removeAllObjects];
}

//
////
//

- (void) basicRestMenuLoad : (NSInteger) indexPathRow
{
    NSArray* myMenu;
    self.menuDepthCount ++;
    NSLog(@"** Second lvl Menu Load 0.00 **");
    if ([self.menuListPathArray count] > 0){
        if ([[self normalRestMenuFetch: self.myRestMenuDataFetch withDataArray:[self.menuListPathArray objectAtIndex:indexPathRow]] isKindOfClass:[NSArray class]]) {
            myMenu = [self normalRestMenuFetch: self.myRestMenuDataFetch withDataArray:[self.menuListPathArray objectAtIndex:indexPathRow]];
            NSLog(@"!--!");
            self.menuTopPathChoiceArray = [[[[self intialRestMenuFetch: self.myRestMenuDataFetch withDataArray:self.myRestMenuDataFetch.myMenuRestData.theCompleteDictionary]lastObject]objectAtIndex:indexPathRow]mutableCopy];
        } else {
            NSLog(@"error - not an array 0.X1");
        }
    } else {
        NSLog(@"error - empty array 0.X2");
        
    }
    self.menuListArray = [myMenu firstObject];
    self.menuListPathArray = [myMenu lastObject];
    if ([self isMenuTextLevel : myMenu]) {
        NSLog(@"-- Is text level --");
        [self.menuChoiceArray addObject:[myMenu firstObject]];
        //NSLog(@"-- MCA %@ --",self.menuChoiceArray);
        ;
        //NSLog(@"-- MPA %@ --",[[self.menuPathChoiceArray lastObject]objectAtIndex:indexPathRow]);
        
        if([[self.menuPathChoiceArray lastObject] count] > indexPathRow ){
            LOG NSLog(@"-- past count %d %d %d --",self.menuDepthCount,[[self.menuPathChoiceArray lastObject] count],indexPathRow);
            [self.menuPathChoiceArray addObject:[[self.menuPathChoiceArray lastObject]objectAtIndex:indexPathRow]];
        }
        else {
            LOG NSLog(@"-- Not past count %d %d %d --",self.menuDepthCount,[[self.menuPathChoiceArray lastObject] count],indexPathRow);
        }
        self.isTextLevel = true;
        self.isBookLevel = false;
        LOG NSLog(@"-- TDPLZ %@ --",self.menuListArray);
    }
    else {
        LOG NSLog(@"-- Is not text level %d %@ --",self.menuDepthCount,myMenu);
        if ([[myMenu firstObject] count]){
            [self.menuChoiceArray addObject:[myMenu firstObject]];
        }
        if ([[myMenu lastObject] count]) {
            [self.menuPathChoiceArray addObject:[myMenu lastObject]];
        }
        self.isTextLevel = false;
        self.isBookLevel = true;
    }
}

- (bool) isMenuTextLevel : (NSArray*) myRestMenuData
{
    LOG NSLog(@"-- menu test --");
    if ([myRestMenuData count] >= 1){
        bool isTextLevelTest = [[myRestMenuData objectAtIndex:1]boolValue];
        return isTextLevelTest;
    }
    return false;
}

@end
