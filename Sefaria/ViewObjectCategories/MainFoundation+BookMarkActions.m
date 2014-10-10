//
//  MainFoundation+BookMarkActions.m
//  Sefaria
//
//  Created by MGM on 8/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+BookMarkActions.h"

@implementation MainFoundation (BookMarkActions)

//
//
////
#pragma mark - Chapter bookmark
////
//
//

- (void) bookmarkChapterViewSetter : (UIButton*) myButton
{
    if ([self.primaryDataArray count] > 0) {
        LineText* myLineText = [self.primaryDataArray firstObject];
        bool isBookmarkedChapter = [myLineText.isBookmarkedChapter boolValue];
        [self updateChapterBookmarkView : (bool) isBookmarkedChapter withButton : (UIButton*) myButton];
    }
    else {
        NSLog(@"Error Bookmark Chapter Checker");
    }
}

- (void) bookMarkChapterPress : (UIButton*) myButton withContext : (NSManagedObjectContext*) context
{
    if ([self.primaryDataArray count] > 0) {
        LineText* myLineText = [self.primaryDataArray firstObject];
        bool isBookmarkedChapter = [myLineText.isBookmarkedChapter boolValue];
        isBookmarkedChapter = !isBookmarkedChapter;
        myLineText.isBookmarkedChapter = [NSNumber numberWithBool:isBookmarkedChapter];
        [self updateChapterBookmarkView : (bool) isBookmarkedChapter withButton : (UIButton*) myButton];
        [self saveData:context];
    }
    else {
        NSLog(@"Error Bookmark Data");
    }

}

- (void) updateChapterBookmarkView : (bool) isBookmarkedChapter withButton : (UIButton*) myButton
{
    if (isBookmarkedChapter) {
        [myButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else {
        [myButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

//
//
////
#pragma mark - bookmark view
////
//
//

- (NSString*) appendBookmarkIcon : (LineText*) myLine withString :(NSString*) myString
{
    if ([myLine.isBookmarked
         boolValue]){
        myString = [myString stringByAppendingString:@" ✓"];
    }
    return myString;
}

//
//
////
#pragma mark - bookMarkActions
////
//
//

- (void) addBookMarkValueToLineText : (UITableView*) tableView  withIndexPath : (NSIndexPath *)indexPath withContext : (NSManagedObjectContext*) context
{
    if (!self.bookmarkSet) return;
    if ([self.primaryDataArray count] < indexPath.row) return;
    LineText* myLineText = [self.primaryDataArray objectAtIndex:indexPath.row];
    bool isBookMarked = [myLineText.isBookmarked boolValue];
    myLineText.isBookmarked = [NSNumber numberWithBool:!isBookMarked];

    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
    [self saveData:context];
}

//
////
//


@end
