//
//  LineText+Create.h
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "LineText.h"
#import "BookTitle.h"
#import "TextTitle.h"

@interface LineText (Create)

+ (LineText*) newLineText : (NSString*) theContentText
            withBookTitle : (BookTitle*) theBookTitle
            withTextTitle : (TextTitle*) theTextTitle
        withChapternumber : (NSInteger)  theChapterNumber
           withLineNumber : (NSInteger)  theLineNumber
             withLanguage : (NSString*) theLanguage
              withContext : (NSManagedObjectContext*) context;

@end
