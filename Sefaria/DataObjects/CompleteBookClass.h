//
//  CompleteBookClass.h
//  Sefaria
//
//  Created by MGM on 7/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompleteBookClass : NSObject

- (NSArray*) completeMishnahFileLocation;


typedef NS_ENUM(NSInteger, kBooks)  {
    kBooksChasidut,
    kBooksHalakhah,
    kBooksKabbalah,
    kBooksLiturgy,
    kBooksMidrash,
    kBooksMishnah,
    kBooksMusar,
    kBooksPhilosophy,
    kBooksTalmud,
    kBooksTanach,
    kBooksTosefta,
    kBooksOther,
    kBooksCommentary,
};


@end
