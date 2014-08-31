//
//  LineTextGroupUIView.m
//  Sefaria
//
//  Created by MGM on 8/28/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "LineTextGroupUIView.h"

@implementation LineTextGroupUIView

#define DK 2
#define LOG if(DK == 1)

#define LEFT_SUB_MARGIN 50.0f
#define VIEW_PADDING 20.0f
#define SUB_VIEW_PADDING 10.0f

#define MAIN_FONT @"Georgia"

#define TEXT_FONT_SIZE 16.0f
#define TEXT_FONT_SIZE_LARGE 18.0f
#define INFO_TEXT_FONT_SIZE 12.0f
#define TEXT_FONT [UIFont fontWithName : MAIN_FONT size : TEXT_FONT_SIZE]
#define TEXT_FONT_LARGE [UIFont fontWithName : MAIN_FONT size : TEXT_FONT_SIZE_LARGE]
#define INFO_FONT [UIFont fontWithName : MAIN_FONT size : INFO_TEXT_FONT_SIZE]

#define SHADOW_ALPHA 0.1f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

#define TAG_BASE 20000

@synthesize superViewWidth=_superViewWidth,theLineText=_theLineText,leftMargin=_leftMargin,topMargin=_topMargin,thisViewHeight=_thisViewHeight,englishLabel=_englishLabel,hebrewLabel=_hebrewLabel,infoLabel=_infoLabel;

- (void)drawRect:(CGRect)rect
{
    CGFloat radius = self.frame.size.width / 50;

    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor clearColor] setStroke];
    [roundedRect stroke];
    [self clipsToBounds];
    
    NSString* myEnglishString = _theLineText.englishText;
    NSString* myHebrewString = _theLineText.hebrewText;

    NSString* textTitle = _theLineText.whatTextTitle.englishName;
    NSInteger chapterNumber = [_theLineText.chapterNumber integerValue];
    NSInteger lineNumber = [_theLineText.lineNumber integerValue];
    NSString* lineInfo = [NSString stringWithFormat:@"%@ Chapter %d Line %d", textTitle,chapterNumber+1,lineNumber+1];
    
    [self cleanTheSubview];

    _thisViewHeight = 0;
    _thisViewHeight = _thisViewHeight + [self addEnglishText : myEnglishString
                                      withCurrentOverallSize : _thisViewHeight
                                                    withFont : TEXT_FONT];
    
    _thisViewHeight = _thisViewHeight + [self addHebrewText : myHebrewString
                                     withCurrentOverallSize : _thisViewHeight
                                                   withFont : TEXT_FONT_LARGE];

    _thisViewHeight = _thisViewHeight + [self addComment : lineInfo
                                  withCurrentOverallSize : _thisViewHeight
                                                withFont : INFO_FONT];
    
    LOG NSLog(@"-- real height %ld --",(long)_thisViewHeight);
    CGRect myRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _thisViewHeight);
    self.frame = myRect;
    
    [self viewShadowDarkBorder :self];
}

//
////
//

- (NSInteger) addEnglishText : (NSString*) myTextString
      withCurrentOverallSize : (NSInteger) myOveralSize
                    withFont : (UIFont*) myFont
{
    NSInteger computedHeight = [self frameForText : myTextString
                                     sizeWithFont : myFont
                                constrainedToSize : CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    
    CGRect myRect = [self makeRect:computedHeight withCurrentOverallSize:myOveralSize];
    
    if (_englishLabel == nil){
        _englishLabel = [[UILabel alloc] initWithFrame : myRect];
    }
    _englishLabel.text = myTextString;
    _englishLabel = [self textLabelEnglishStyle :_englishLabel withFont : myFont];
    [self addSubview:_englishLabel];
    return _englishLabel.frame.size.height;
}

- (NSInteger) addHebrewText : (NSString*) myTextString
     withCurrentOverallSize : (NSInteger) myOveralSize
                   withFont : (UIFont*) myFont
{
    NSInteger computedHeight = [self frameForText : myTextString
                                     sizeWithFont : myFont
                                constrainedToSize : CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    
    CGRect myRect = [self makeRect:computedHeight withCurrentOverallSize:myOveralSize];
    
    if (_hebrewLabel == nil){
        _hebrewLabel = [[UILabel alloc] initWithFrame:myRect];
    }
    _hebrewLabel.text = myTextString;
    _hebrewLabel = [self textLabelHebrewStyle :_hebrewLabel withFont : myFont];
    [self addSubview:_hebrewLabel];
    return _hebrewLabel.frame.size.height;
}

- (NSInteger) addComment : (NSString*) myTextString
  withCurrentOverallSize : (NSInteger) myOveralSize
                withFont : (UIFont*) myFont
{
    NSInteger computedHeight = [self frameForText : myTextString
                                     sizeWithFont : myFont
                                constrainedToSize : CGSizeMake(self.bounds.size.width , CGFLOAT_MAX)];
    
    CGRect myRect = [self makeRect:computedHeight withCurrentOverallSize:myOveralSize];
    
    if (_infoLabel == nil){
        _infoLabel = [[UILabel alloc] initWithFrame:myRect];
    }
    _infoLabel.text = myTextString;
    _infoLabel = [self textLabelCommentStyle:_infoLabel withFont : myFont];
    [self addSubview:_infoLabel];
    return _infoLabel.frame.size.height;
}

- (CGRect) makeRect : (NSInteger) computedHeight
withCurrentOverallSize : (NSInteger) myOveralSize
{
    return CGRectMake(SUB_VIEW_PADDING, myOveralSize, self.bounds.size.width - 2 * SUB_VIEW_PADDING, VIEW_PADDING + 1.2 * computedHeight);
}

//
////
//

- (UILabel*) textLabelEnglishStyle : (UILabel*) myLabel withFont : (UIFont*) myFont
{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
    return myLabel;
}

- (UILabel*) textLabelHebrewStyle : (UILabel*) myLabel withFont : (UIFont*) myFont{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.textAlignment = NSTextAlignmentRight;
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
    return myLabel;
}

- (UILabel*) textLabelCommentStyle : (UILabel*) myLabel withFont : (UIFont*) myFont{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.textAlignment = NSTextAlignmentRight;
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
    return myLabel;
}

//
////
//

- (CGFloat)frameForText : (NSString*) text
           sizeWithFont : (UIFont*)font
      constrainedToSize : (CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin)
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size.height;
}

//
////
//

- (void) viewShadowDarkBorder: (UIView*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    [[shadowObject layer] setCornerRadius:radius];
}

//
////
//

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void) cleanTheSubview
{
    for(UIView *subview in [self subviews]) {
        if([subview isKindOfClass:[UIImageView class]])
        {
            [subview removeFromSuperview];
        }
        else if([subview isKindOfClass:[UILabel class]]) {
            [subview removeFromSuperview];
        }
        else if([subview isKindOfClass:[UIImage class]]) {
            [subview removeFromSuperview];
        }
        else
        {}
    }
}

//
////
//

- (void) testValues {
    NSLog(@"-- MVH %d --",_thisViewHeight);
    NSLog(@"-- MVW %f --",self.frame.size.width);
    
    NSLog(@"-- origin %f %f --",self.frame.origin.x,self.frame.origin.y);
    NSLog(@"-- size %f %f --",self.frame.size.height,self.frame.size.width);
}

@end
