//
//  MainFoundation+ChapterAndMenuTextStyles.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+ChapterAndMenuTextStyles.h"

@implementation MainFoundation (ChapterAndMenuTextStyles)

#define FONT_NAME @"HelveticaNeue-Light"
#define FONT_SIZE 18.0
#define FONT_SIZE_LARGE 26.0

#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE_LARGE]

- (UITableViewCell *) setChapterCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        [cell.textLabel setAttributedText:[self.myBestStringClass myAttributedString:myString withSize:FONT_SIZE withFont:FONT_NAME]];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        cell.textLabel.numberOfLines = 1;
        //cell.textLabel.font = IPAD_FONT;
        return cell;
    }
    else {
        return nil;
    }
}

- (UITableViewCell *) setMenuCell: (UITableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        [cell.textLabel setAttributedText:[self.myBestStringClass myAttributedString:myString withSize:FONT_SIZE withFont:FONT_NAME]];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        cell.textLabel.numberOfLines = 1;
        //cell.textLabel.font = IPAD_FONT_LARGE;
        return cell;
    }
    else {
        return nil;
    }
}


@end
