//
//  TextClass.m
//  Sefaria
//
//  Created by MGM on 7/6/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "TanachTextClass.h"

@implementation TanachTextClass

@synthesize foundationLanguages=_foundationLanguages,foundationTexts=_foundationTexts,foundationTanach=_foundationTanach,foundationTorah=_foundationTorah,foundationProphets=_foundationProphets,foundationWritings=_foundationWritings;

- (NSArray*) foundationLanguages
{
    return @[@"English",@"Hebrew"];
}

- (NSArray*) foundationTexts
{
    return @[@"Tanach"];
}

- (NSArray*) foundationTanach
{
    return @[@"Torah",
             @"Prophets",
             @"Writings",];
}

- (NSArray*) foundationTorah
{
    return @[@"Genesis",
             @"Exodus",
             @"Leviticus",
             @"Numbers",
             @"Deuteronomy",
             ];
}

- (NSArray*) foundationProphets
{
    return @[@"Joshua",
             @"Judges",
             @"I Samuel",
             @"II Samuel",
             @"I Kings",
             @"II Kings",
             @"Isaiah",
             @"Jeremiah",
             @"Ezekiel",
             @"Hosea",
             @"Joel",
             @"Amos",
             @"Obadiah",
             @"Jonah",
             @"Micah",
             @"Nahum",
             @"Habakkuk",
             @"Haggai",
             @"Zechariah",
             @"Malachi",
             ];
}

- (NSArray*) foundationWritings
{
    return @[@"Psalms",
             @"Proverbs",
             @"Job",
             @"Song of Songs",
             @"Ruth",
             @"Lamentations",
             @"Ecclesiastes",
             @"Esther",
             @"Daniel",
             @"Ezra",
             @"Nehemiah",
             @"I Chronicles",
             @"II Chronicles",
             ];
}



@end
