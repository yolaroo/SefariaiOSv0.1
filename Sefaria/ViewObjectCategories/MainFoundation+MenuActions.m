//
//  MainFoundation+MenuActions.m
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+MenuActions.h"

@implementation MainFoundation (MenuActions)

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define TORAH_TAG 1000
#define PROPHET_TAG 1001
#define WRITINGS_TAG 1002

//
//
////////
#pragma mark - Core Data Menu
////////
//
//

- (NSString*) objectName: (NSManagedObject*)myObject
{
    NSArray* myObjectArray = @[myObject];
    if ([[myObjectArray firstObject] respondsToSelector:@selector(englishName)]){
        return [[myObjectArray firstObject] englishName];
    }
    else {
        return (@"error");
    }
}

//
//
////////
#pragma mark - Advanced Menu
////////
//
//

- (NSArray*) setMenuFromDepth: (NSString*)myString
{
    NSArray*myArray;
    myArray = [self.myTanachTextClass foundationTanach];

    if ([myString isEqualToString:@"Tanach"]) {
        myArray = [self.myTanachTextClass foundationTanach];
    }
    else if ([myString isEqualToString:@"Torah"]) {
        myArray = [self.myTanachTextClass foundationTorah];
    }
    else if ([myString isEqualToString:@"Prophets"]) {
        myArray = [self.myTanachTextClass foundationProphets];
    }
    else if ([myString isEqualToString:@"Writings"]) {
        myArray = [self.myTanachTextClass foundationWritings];
    }
    
//    NSArray*m1 = [self.myTanachTextClass foundationTorah];
//    NSArray*m2 = [self.myTanachTextClass foundationProphets];
//    NSArray*m3 = [self.myTanachTextClass foundationWritings];

    return myArray;
}

//
//
////////
#pragma mark - Simple Menu
////////
//
//

- (void) tableViewMenuAction:(NSInteger)tableViewTag didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewTag == MENU_TAG){
        switch (self.thePrimarybook) {
            case kTanachTorah:
            [self selectionForTorah : indexPath.row];
            break;
            case kTanachProphets:
            [self selectionForProphets : indexPath.row];
            break;
            case kTanachWritings:
            [self selectionForWritings : indexPath.row];
            break;
            default:
            NSLog(@"Error - Menu Button");
            break;
        }
        self.theChapterNumber = 0;
    }
}

- (void)selectionForWritings : (NSInteger) thenumber {
    self.theWritingsText = thenumber;
}

- (void)selectionForProphets : (NSInteger) thenumber {
    self.theProphetText = thenumber;
}

- (void)selectionForTorah : (NSInteger) thenumber {
    self.theTorahText = thenumber;
}

//
//
////////
#pragma mark -
////////
//
//

- (void) menuForTorahAction : (NSInteger) buttonNumber
{
    switch (buttonNumber) {
        case TORAH_TAG:
        [self theMenuTorahSetter];
        break;
        case PROPHET_TAG:
        [self theMenuProphetSetter];
        break;
        case WRITINGS_TAG:
        [self theMenuWritingsSetter];
        break;
        default:
        NSLog(@"Error - Menu Button");
        break;
    }
}

- (void) theMenuTorahSetter {
    self.menuListArray = self.myTanachTextClass.foundationTorah;
    self.thePrimarybook = kTanachTorah;
}

- (void) theMenuProphetSetter {
    self.menuListArray = self.myTanachTextClass.foundationProphets;
    self.thePrimarybook = kTanachProphets;
}

- (void) theMenuWritingsSetter {
    self.menuListArray = self.myTanachTextClass.foundationWritings;
    self.thePrimarybook = kTanachWritings;
}



@end
