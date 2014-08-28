//
//  MainFoundation+CommentStyle.m
//  Sefaria
//
//  Created by MGM on 8/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+CommentStyle.h"

#import "MainFoundation+MainViewActions.h"

@implementation MainFoundation (CommentStyle)

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]

- (UITableViewCell *) setMyCommentCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath withSelectedIndex : (NSInteger) selectedIndex withText : (NSString*) myString withInfo : (NSString*) theInfo
{
    if (myString != nil){
        
        
        cell.textLabel.attributedText = [self.myBestStringClass setTextHighlighted:self.theSearchTerm withSentence:myString];

        //cell.textLabel.text = theText;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        cell.textLabel.font = IPAD_FONT;
        if (selectedIndex == indexPath.row) {
            cell.textLabel.numberOfLines = 0;
        } else {
            cell.textLabel.numberOfLines = 5;
        }
        
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if ([theInfo length]) {
            cell.detailTextLabel.text = theInfo;
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
        return cell;
    }
    else {
        cell.textLabel.text = @"error";
        return cell;
    }
}

//
////
//

- (NSString*) commentDetailText : (Comment*) myComment
{
    NSString* commentAuthor;
    NSString* lineNumber;
    NSString* textTitleEnglishName;
    if ([myComment.whatAuthor.name length]) {
        commentAuthor = myComment.whatAuthor.name;
    } else {
        commentAuthor = @" ";
    }
    if (myComment.lineNumber != nil) {
        lineNumber = [myComment.lineNumber stringValue];
    } else {
        lineNumber = @" ";
    }
    if ([myComment.whatTextTitle.englishName length]) {
        textTitleEnglishName = myComment.whatTextTitle.englishName;
    } else {
        textTitleEnglishName = @" ";
    }
    NSString* completeString = [NSString stringWithFormat:@"%@ - on line %@ of %@",commentAuthor,lineNumber,textTitleEnglishName];
    return completeString;
}

- (NSString*) commentTextFromObject:(Comment*) myComment
{
    if ([myComment.englishText length] && [myComment.hebrewText length]) {
        NSString* englishString = myComment.englishText;
        englishString = [self removeHTMLFromString:englishString];

        NSString* hebrewString = myComment.hebrewText;
        hebrewString = [self removeHTMLFromString:hebrewString];
        
        return [NSString stringWithFormat:@"%@\n%@",hebrewString,englishString];
    }
    else if ([myComment.englishText length] && ![myComment.hebrewText length]) {
        NSString* englishString = myComment.englishText;
        return [self removeHTMLFromString:englishString];
    }
    else if (![myComment.englishText length] && [myComment.hebrewText length]) {
        NSString* hebrewString = myComment.hebrewText;
        return [self removeHTMLFromString:hebrewString];
    }
    else {
        NSLog(@"string error");
        return @"";
    }
}

//
//
/////
#pragma mark - Comment Press
/////
//
//

- (void) commentPressAction : (NSIndexPath *)indexPath withcommentTable : (UITableView*) commentTable
{
    if (self.selectedIndex == -1) {
        self.selectedIndex = indexPath.row;
        self.currentIndexPath = indexPath;
        [commentTable beginUpdates];
        [commentTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [commentTable endUpdates];
    }
    else if (self.selectedIndex == indexPath.row) {
        self.selectedIndex = -1;
        self.currentIndexPath = nil;
        [commentTable beginUpdates];
        [commentTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [commentTable endUpdates];
    }
    else if (self.selectedIndex != -1 && self.selectedIndex != indexPath.row) {
        self.selectedIndex = indexPath.row;
        [commentTable beginUpdates];
        [commentTable reloadRowsAtIndexPaths:@[self.currentIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [commentTable endUpdates];
        self.currentIndexPath = indexPath;
    }
}



@end
