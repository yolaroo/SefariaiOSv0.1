//
//  MainFoundation+HebrewTextStyles.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+HebrewTextStyles.h"

@implementation MainFoundation (HebrewTextStyles)

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

- (NSString*) hebrewTextFromArray:(NSIndexPath *)indexPath
{
    if ([self.primaryHebrewTextArray count] > indexPath.row){
        NSString*myString = [self.primaryHebrewTextArray objectAtIndex:indexPath.row] ? [self.primaryHebrewTextArray objectAtIndex:indexPath.row] : @"error";
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

- (NSString*) hebrewTextFromObject:(NSIndexPath *)indexPath
{
    if ([self.primaryDataArray count] > indexPath.row){
        LineText*myLine = [self.primaryDataArray objectAtIndex:indexPath.row];
        NSString*myString = myLine.hebrewText ? myLine.hebrewText : @"error";
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

- (UITableViewCell *) setMyHebrewTextCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        cell.textLabel.font = IPAD_FONT_LARGE;
        
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
    else {
        cell.textLabel.text = @"error";
        return cell;
    }
}

@end
