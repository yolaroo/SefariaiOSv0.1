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
#define CELL_PADDING 25.0

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]

#define ACC_FONT_NAME @"HelveticaNeue-Light"
#define ACC_FONT_SIZE 10.0


//
//
////////
#pragma mark - Accessory Label
////////
//
//

- (UILabel*) labelForNumberRightSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell
{
    CGRect myRect = CGRectMake(0,0,30,cell.frame.size.height);
    UILabel* myLabel = [[UILabel alloc]initWithFrame:myRect];
    NSString* myLineNumber = [NSString stringWithFormat:@"%d",indexPathRow+1];
    myLabel.text = myLineNumber;
    myLabel.textColor = [UIColor grayColor];
    myLabel.font = [UIFont fontWithName: ACC_FONT_NAME size:ACC_FONT_SIZE];
    myLabel.textAlignment = NSTextAlignmentNatural;
    return myLabel;
}

- (UILabel*) labelForNumberLeftSide : (NSInteger) indexPathRow withCell : (UITableViewCell*) cell
{
    CGRect myRect = CGRectMake(0,0,30,cell.frame.size.height);
    UILabel* myLabel = [[UILabel alloc]initWithFrame:myRect];
    NSString* myLineNumber = [NSString stringWithFormat:@"%d",indexPathRow+1];
    myLabel.text = myLineNumber;
    myLabel.textColor = [UIColor grayColor];
    myLabel.font = [UIFont fontWithName: ACC_FONT_NAME size:ACC_FONT_SIZE];
    myLabel.textAlignment = NSTextAlignmentNatural;
    myLabel.tag = 5000;
    return myLabel;
}

//        TextVerticalAlignment = UITextVerticalAlignment.Top;

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
            sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        }
        if (indexPath.row < [self.primaryHebrewTextArray count]) {

            NSString* myStringHebrew = [self.primaryHebrewTextArray objectAtIndex:indexPath.row];
            sizeHebrew = [self frameForText:myStringHebrew sizeWithFont:IPAD_FONT_LARGE constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
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
