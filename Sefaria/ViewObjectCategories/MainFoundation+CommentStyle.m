//
//  MainFoundation+CommentStyle.m
//  Sefaria
//
//  Created by MGM on 8/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+CommentStyle.h"

@implementation MainFoundation (CommentStyle)


- (NSString*) commentDetailText : (Comment*) myComment
{
    NSString* commentAuthor;
    NSString* lineNumber;
    NSString* textTitleEnglishName;
    if ([myComment.whatAuthor.name length]){
        commentAuthor = myComment.whatAuthor.name;
    } else {
        commentAuthor = @" ";
    }
    if (myComment.lineNumber != nil){
        lineNumber = [myComment.lineNumber stringValue];
    } else {
        lineNumber = @" ";
    }
    if ([myComment.whatTextTitle.englishName length]){
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
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

        NSString* hebrewString = myComment.hebrewText;
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
        
        return [NSString stringWithFormat:@"%@\n%@",hebrewString,englishString];
    }
    else if ([myComment.englishText length] && ![myComment.hebrewText length]) {
        NSString* englishString = myComment.englishText;
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        englishString = [englishString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

        return englishString;
    }
    else if (![myComment.englishText length] && [myComment.hebrewText length]) {
        NSString* hebrewString = myComment.hebrewText;
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        hebrewString = [hebrewString stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

        return hebrewString;
    }
    else {
        NSLog(@"string error");
        return @"";
    }
}



@end
