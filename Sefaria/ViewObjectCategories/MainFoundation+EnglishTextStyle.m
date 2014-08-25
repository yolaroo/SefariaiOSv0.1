//
//  MainFoundation+EnglishTextStyle.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+EnglishTextStyle.h"

#import "MainFoundation+BookMarkActions.h"

@implementation MainFoundation (EnglishTextStyle)

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]

//
//// JSON
//

- (NSString*) englishTextFromArray:(NSIndexPath *)indexPath
{
    if ([self.primaryEnglishTextArray count] > indexPath.row){
        NSString*myString = [self.primaryEnglishTextArray objectAtIndex:indexPath.row] ? [self.primaryEnglishTextArray objectAtIndex:indexPath.row] : @"error";
        myString = [myString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

        return myString;
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}

//
//// Core Data
//

- (NSString*) englishTextFromObject:(NSIndexPath *)indexPath
{
    if ([self.primaryDataArray count] > indexPath.row){
        LineText*myLine = [self.primaryDataArray objectAtIndex:indexPath.row];
        NSString*myString = myLine.englishText ? myLine.englishText : @"error";
        myString = [myString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        myString = [myString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

        return [self appendBookmarkIcon:myLine withString:myString];
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}



//
////
//

- (UITableViewCell *) setMyEnglishTextCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil && [myString isKindOfClass:[NSString class]]){
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
        if (self.fontSizeLargeSet) {
            cell.textLabel.font = IPAD_FONT_LARGE;
        }
        else {
            cell.textLabel.font = IPAD_FONT;
        }
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.attributedText = [self.myBestStringClass setTextHighlighted:self.theSearchTerm withSentence:myString];

        return cell;
    }
    else {
        NSLog(@"--Error - Cell is not a string --");
        cell.textLabel.text = @"error";
        return cell;
    }
}

@end
