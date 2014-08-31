//
//  MainFoundation+SearchStyle.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SearchStyle.h"

@implementation MainFoundation (SearchStyle)

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]


- (UITableViewCell *) setMySearchTextCell: (UITableViewCell*) cell withText : (NSString*) myString withInfo : (NSString*) myInfo
{
    if (myString != nil){
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
        cell.textLabel.font = IPAD_FONT;
        
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        if ([self.theSearchTerm length]) {
            cell.textLabel.attributedText = [self.myBestStringClass setTextHighlighted:self.theSearchTerm withSentence:myString];
        }
        else {
            cell.textLabel.text = myString;
        }
        if ([myInfo length]) {
            cell.detailTextLabel.text = myInfo;
        }
        return cell;
    }
    else {
        cell.textLabel.text = @"error";
        return cell;
    }
}

@end
