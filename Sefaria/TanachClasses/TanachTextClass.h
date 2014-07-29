//
//  TextClass.h
//  Sefaria
//
//  Created by MGM on 7/6/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TanachTextClass : NSObject

typedef NS_ENUM(NSInteger, kTextLanguage)  {
    kLanguageEnglish,
    kLanguageHebrew,
};

typedef NS_ENUM(NSInteger, kTexts)  {
    kTextsTanach,
};

typedef NS_ENUM(NSInteger, kTanachBooks)  {
    kTanachTorah,
    kTanachProphets,
    kTanachWritings,
};

typedef NS_ENUM(NSInteger, kTorah)  {
    kTorahGenesis = 0,
    kTorahExodus,
    kTorahLeviticus,
    kTorahNumbers,
    kTorahDeuteronomy,
};

typedef NS_ENUM(NSInteger, kProphets)  {
    kProphetsJoshua = 0,
    kProphetsJudges,
    kProphetsISamuel,
    kProphetsIISamuel,
    kProphetsIKings,
    kProphetsIIKings,
    kProphetsIsaiah,
    kProphetsJeremiah,
    kProphetsEzekiel,
    kProphetsHosea,
    kProphetsJoel,
    kProphetsAmos,
    kProphetsObadiah,
    kProphetsJonah,
    kProphetsMicah,
    kProphetsNahum,
    kProphetsHabakkuk,
    kProphetsHaggai,
    kProphetsZechariah,
    kProphetsMalachi,
};

typedef NS_ENUM(NSInteger, kWritings)  {
    kWritingsPsalms = 0,
    kWritingsProverbs,
    kWritingsJob,
    kWritingsSongOfSongs,
    kWritingsRuth,
    kWritingsLamentations,
    kWritingsEcclesiastes,
    kWritingsEsther,
    kWritingsDaniel,
    kWritingsEzra,
    kWritingsNehemiah,
    kWritingsIChronicles,
    kWritingsIIChronicles,
};

//
////
//

@property (nonatomic, strong) NSArray* foundationLanguages;
@property (nonatomic, strong) NSArray* foundationTexts;
@property (nonatomic, strong) NSArray* foundationTanach;
@property (nonatomic, strong) NSArray* foundationTorah;
@property (nonatomic, strong) NSArray* foundationProphets;
@property (nonatomic, strong) NSArray* foundationWritings;



@end
