//
//  BestStringClass.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BestStringClass.h"

@interface BestStringClass ()

@property (nonatomic, strong) NSMutableParagraphStyle *mutableParagraphStyle;
@property (nonatomic, strong) NSMutableAttributedString *mutableAttributedString;
@property (nonatomic, strong) NSMutableAttributedString *highlightMutableAttributedString;

@property (nonatomic, strong) NSShadow *shadow;

@end

@implementation BestStringClass

@synthesize mutableParagraphStyle=_mutableParagraphStyle,mutableAttributedString=_mutableAttributedString,shadow=_shadow,highlightMutableAttributedString=_highlightMutableAttributedString;

#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.3f]

- (NSAttributedString*) myAttributedString : (NSString*) myString withSize : (NSInteger) fontSize withFont : (NSString*) fontName
{
    self.mutableParagraphStyle.alignment = NSTextAlignmentCenter;
    //self.mutableParagraphStyle.lineSpacing = fontSize/2;
    UIFont * labelFont = [UIFont fontWithName:fontName size:fontSize];
    UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
    
    [[self.mutableAttributedString mutableString] setString:myString];

    [self.mutableAttributedString addAttributes : @{
                  NSParagraphStyleAttributeName : self.mutableParagraphStyle,
                            NSKernAttributeName : @2.5,
                            NSFontAttributeName : labelFont,
                 NSForegroundColorAttributeName : labelColor,
                          NSShadowAttributeName : self.shadow }
                                          range : NSMakeRange(0,[myString length])];
    
    return [self.mutableAttributedString copy];
}

//
////
//

- (NSAttributedString* )setTextHighlighted :(NSString *) theString withSentence : (NSString*) theSentence
{
    if ([theString length]){
        [[self.highlightMutableAttributedString mutableString] setString:theSentence];
        
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:theString options:NSRegularExpressionCaseInsensitive error:nil];
        NSRange range = NSMakeRange(0,[theSentence length]);
        [expression enumerateMatchesInString : theSentence
                                     options : 0 range:range
                                  usingBlock : ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange theTextRange = [result rangeAtIndex:0];
            [self.highlightMutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:theTextRange];
        }];
        return [self.highlightMutableAttributedString copy];
    }
    else {
        return [[NSAttributedString alloc]initWithString:theSentence];
    }
}

//
////
//

- (NSMutableParagraphStyle*) mutableParagraphStyle {
    if (!_mutableParagraphStyle){
        _mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return _mutableParagraphStyle;
}

- (NSMutableAttributedString* )  mutableAttributedString {
    if (!_mutableAttributedString){
        _mutableAttributedString = [[NSMutableAttributedString alloc] init];
    }
    return _mutableAttributedString;
}

- (NSMutableAttributedString* )  highlightMutableAttributedString {
    if (!_highlightMutableAttributedString){
        _highlightMutableAttributedString = [[NSMutableAttributedString alloc] init];
    }
    return _highlightMutableAttributedString;
}

- ( NSShadow*) shadow {
    if (!_shadow) {
        _shadow = [[NSShadow alloc]init];
        [_shadow setShadowColor : BLACK_SHADOW];
        [_shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
        [_shadow setShadowBlurRadius : 1];
    }
    return _shadow;
}

@end
