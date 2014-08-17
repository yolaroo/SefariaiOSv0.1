//
//  MainFoundation+TableViewStyles.m
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+TableViewStyles.h"

@implementation MainFoundation (TableViewStyles)

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


//
//
////////
#pragma mark -
////////
//
//



//
//
////////
#pragma mark - TableView Animation Match
////////
//
//

- (UITableViewCell *) setChapterCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        cell.textLabel.numberOfLines = 1;
        return cell;
    }
    else {
        return nil;
    }
}

- (UITableViewCell *) setMenuCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        cell.textLabel.numberOfLines = 1;
        return cell;
    }
    else {
        return nil;
    }
}

//
////
//



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

//
//
////////
#pragma mark - TableView
////////
//
//

- (CGFloat)tableViewHeightForSingleTable:(UITableView *)tableView withString : (NSString*) myString
{
    CGSize sizeEnglish;
    NSLog(@"-- MS %@ --",myString);
    sizeEnglish = [self frameForText:myString sizeWithFont:nil constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH-CELL_CONTENT_MARGIN, CGFLOAT_MAX)];
    if (sizeEnglish.height > 44.0) {
        NSLog(@"CG 1.0 %f",sizeEnglish.height + CELL_PADDING );
        return sizeEnglish.height + CELL_PADDING;
    }
    else {
        NSLog(@"CG 2.0");
        return 44.0;
    }
}

- (CGFloat)tableViewHeightTwoTables:(UITableView *)tableView cellForRowAtIndexPath :(NSIndexPath *)indexPath
{
    if (tableView.tag == ENGLISH_TAG || tableView.tag == HEBREW_TAG) {
        CGSize sizeHebrew;
        CGSize sizeEnglish;
        if (indexPath.row < [self.primaryEnglishTextArray count]) {

            NSString* myStringEnglish = [self.primaryEnglishTextArray objectAtIndex:indexPath.row];
            sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH-CELL_CONTENT_MARGIN, CGFLOAT_MAX)];
        }
        if (indexPath.row < [self.primaryHebrewTextArray count]) {

            NSString* myStringHebrew = [self.primaryHebrewTextArray objectAtIndex:indexPath.row];
            sizeHebrew = [self frameForText:myStringHebrew sizeWithFont:IPAD_FONT_LARGE constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH-CELL_CONTENT_MARGIN, CGFLOAT_MAX)];
        }
        if (sizeEnglish.height > sizeHebrew.height) {
            return sizeEnglish.height + CELL_PADDING;
        } else {
            return sizeHebrew.height + CELL_PADDING;
        }
    }
    else {
        return 55.0;
    }
}

//
//
////////
#pragma mark - Frame
////////
//
//

- (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin)
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size;
}


@end
