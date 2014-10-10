//
//  MainFoundation+BookMarkStyle.m
//  Sefaria
//
//  Created by MGM on 8/26/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+BookMarkStyle.h"

#import "MainFoundation+MainViewActions.h"

@implementation MainFoundation (BookMarkStyle)

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]
#define IPAD_FONT_XTLARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.8]


- (NSString*) bookmarkChapterTextFromObject:(NSIndexPath *)indexPath
{
    if ([self.bookmarkChapterArray count] > indexPath.row){
        LineText*myLine = [self.bookmarkChapterArray objectAtIndex:indexPath.row];
        NSString*textTitleEnglishName = myLine.whatTextTitle.englishName;
        NSInteger chapterNumber = [myLine.chapterNumber integerValue];
        NSString* completeString = [NSString stringWithFormat:@"%@ - Chapter %ld",textTitleEnglishName,(long)chapterNumber+1];
        return completeString;
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}


//
//// Core Data
//

- (NSString*) bookmarkTextFromObject:(NSIndexPath *)indexPath
{
    if ([self.bookmarkArray count] > indexPath.row){
        LineText*myLine = [self.bookmarkArray objectAtIndex:indexPath.row];
        NSString*myString;
        if (self.isSingleViewEnglish){
           myString = myLine.englishText ? myLine.englishText : @"error";
        }
        else {
            myString = myLine.hebrewText ? myLine.hebrewText : @"error";
        }
        return [self removeHTMLFromString:myString];
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}


- (NSString*) bookmarkDetailFromObject:(NSIndexPath *)indexPath
{
    if ([self.bookmarkArray count] > indexPath.row){
        LineText*myLine = [self.bookmarkArray objectAtIndex:indexPath.row];
        NSString*textTitleEnglishName = myLine.whatTextTitle.englishName;
        NSInteger chapterNumber = [myLine.chapterNumber integerValue];
        NSInteger lineNumber = [myLine.lineNumber integerValue];
        NSString* completeString = [NSString stringWithFormat:@"%@ - Chapter %ld Line %ld",textTitleEnglishName,(long)chapterNumber+1,(long)lineNumber+1];
        return completeString;
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}


//
////
//
- (UITableViewCell *) setMyBookmarkChapterTextCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil && [myString isKindOfClass:[NSString class]]){
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
        cell.textLabel.text = myString;
        cell.textLabel.font = IPAD_FONT;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    else {
        NSLog(@"--Error - Cell is not a string --");
        cell.textLabel.text = @"error";
        return cell;
    }
}

//
/////
//

- (UITableViewCell *) setMyBookmarkTextCell: (UITableViewCell*) cell withString :(NSString *) myString withDetailText : (NSString*) myDetail
{
    if (myString != nil && [myString isKindOfClass:[NSString class]]){
        
        if (self.isSingleViewEnglish) {
            cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
            
            if ([self.theSearchTerm length]) {
                cell.textLabel.attributedText = [self.myBestStringClass setTextHighlighted:self.theSearchTerm withSentence:myString];
            }
            else {
                cell.textLabel.text = myString;
            }

            if (self.fontSizeLargeSet) {
                cell.textLabel.font = IPAD_FONT_LARGE;
            }
            else {
                cell.textLabel.font = IPAD_FONT;
            }
        }
        else {
            cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
            cell.textLabel.text = myString;

            if (self.fontSizeLargeSet) {
                cell.textLabel.font = IPAD_FONT_XTLARGE;
            }
            else {
                cell.textLabel.font = IPAD_FONT_LARGE;
            }
        }
        
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];

        //detail text
        cell.detailTextLabel.text = myDetail;
        cell.detailTextLabel.textColor = [UIColor grayColor];

        return cell;
    }
    else {
        NSLog(@"--Error - Cell is not a string --");
        cell.textLabel.text = @"error";
        return cell;
    }
}
@end
