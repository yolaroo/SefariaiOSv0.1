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
@property (nonatomic, strong) NSShadow *shadow;

@end

@implementation BestStringClass

@synthesize mutableParagraphStyle=_mutableParagraphStyle,mutableAttributedString=_mutableAttributedString,shadow=_shadow;

#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]

- (NSAttributedString*) myAttributedString : (NSString*) myString withSize : (NSInteger) fontSize withFont : (NSString*) fontName
{
    self.mutableParagraphStyle.alignment = NSTextAlignmentCenter;
    //self.mutableParagraphStyle.lineSpacing = fontSize/2;
    UIFont * labelFont = [UIFont fontWithName:fontName size:fontSize];
    UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor : BLACK_SHADOW];
    [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
    [shadow setShadowBlurRadius : 1];
    
    [[self.mutableAttributedString mutableString] setString:myString];

    [self.mutableAttributedString addAttributes : @{
                  NSParagraphStyleAttributeName : self.mutableParagraphStyle,
                            NSKernAttributeName : @2.5,
                            NSFontAttributeName : labelFont,
                 NSForegroundColorAttributeName : labelColor,
                          NSShadowAttributeName : shadow }
                                          range : NSMakeRange(0,[myString length])];
    
    return [self.mutableAttributedString copy];
}

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

- ( NSShadow*) shadow {
    if (_shadow) {
        _shadow = [[NSShadow alloc]init];
    }
    return _shadow;
}

@end
