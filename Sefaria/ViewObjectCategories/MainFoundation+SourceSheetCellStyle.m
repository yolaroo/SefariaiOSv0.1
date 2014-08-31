//
//  MainFoundation+SourceSheetCellStyle.m
//  Sefaria
//
//  Created by MGM on 8/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SourceSheetCellStyle.h"

@implementation MainFoundation (SourceSheetCellStyle)

- (NSString *) sourceSheetString : (ContextGroup*) mySourceSheet
{
    NSString* titleString = mySourceSheet.title;
    NSString* subtitleString = mySourceSheet.subTitle;
    if ([titleString length] && [subtitleString length]){
        return [NSString stringWithFormat:@"%@ - %@",titleString,subtitleString];
    }
    else if ([titleString length] && ![subtitleString length]){
        return titleString;
    }
    else if (![titleString length] && [subtitleString length]){
        return subtitleString;
    }
    else {
        return @"error";
    }
}

@end
