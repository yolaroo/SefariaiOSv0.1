//
//  MainFoundation+EnglishTextStyle.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+EnglishTextStyle.h"

@implementation MainFoundation (EnglishTextStyle)

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define CELL_CONTENT_WIDTH 380.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 90.0

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]



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

        return myString;
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
        cell.textLabel.text = myString;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
        cell.textLabel.font = IPAD_FONT;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
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

@end
