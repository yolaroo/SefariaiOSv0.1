//
//  BestStringClass.h
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BestStringClass : NSObject

- (NSAttributedString*) myAttributedString : (NSString*) myString withSize : (NSInteger) fontSize withFont : (NSString*) fontName;

- (NSAttributedString* )setTextHighlighted :(NSString *) theString withSentence : (NSString*) theSentence;

@end
