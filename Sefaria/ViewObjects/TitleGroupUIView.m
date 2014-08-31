//
//  TitleGroupUIView.m
//  Sefaria
//
//  Created by MGM on 8/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "TitleGroupUIView.h"

@implementation TitleGroupUIView

@synthesize titleLabel=_titleLabel,subTitleLabel=_subTitleLabel,thisViewHeight=_thisViewHeight,titleString=_titleString,theSubtitleString=_theSubtitleString;

#define TOP_MARGIN 20.0f
#define LEFT_MARGIN 30.0f
#define LEFT_DOUBLE_MARGIN 2*LEFT_MARGIN
#define LEFT_SUB_MARGIN 10.0f
#define LEFT_DOUBLE_SUB_MARGIN 2*LEFT_SUB_MARGIN

#define TOP_PADDING 10.0f
#define VIEW_PADDING 20.0f
#define SUB_VIEW_PADDING 10.0f

#define MAIN_FONT @"Georgia"

#define TITLE_FONT_SIZE 30.0f
#define SUBHEADING_FONT_SIZE 15.0f
#define SUBHEADING_FONT [UIFont fontWithName : MAIN_FONT size : SUBHEADING_FONT_SIZE]
#define TITLE_FONT [UIFont fontWithName : MAIN_FONT size : TITLE_FONT_SIZE]

#define TAG_BASE 20000

- (void)drawRect:(CGRect)rect
{
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor clearColor] setStroke];
    [roundedRect stroke];
    [self clipsToBounds];

    [self cleanTheSubview];

    _thisViewHeight = 0;
    
    _thisViewHeight = _thisViewHeight + [self addTitle:_titleString withCurrentOverallSize:_thisViewHeight withFont:TITLE_FONT];
    _thisViewHeight = _thisViewHeight + [self addEnglishCommentText:_theSubtitleString withCurrentOverallSize:_thisViewHeight withFont:SUBHEADING_FONT];
}

//
//
////////
#pragma mark - Add Title
////////
//
//

- (NSInteger) addTitle : (NSString*) myTitleString
withCurrentOverallSize : (NSInteger) myOveralSize
              withFont : (UIFont*) myFont
{
    CGFloat myHeight = [self frameForText : myTitleString sizeWithFont : myFont constrainedToSize : CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    CGRect myRect = CGRectMake(0, 2*TOP_PADDING, self.bounds.size.width, myHeight);//[self setCGRectMainSize : myTitleString withCurrentOverallSize : myHeight withFont: myFont];
    
    if (_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame:myRect];
    }
    _titleLabel.text = myTitleString;
    _titleLabel = [self titleLabelStyle:_titleLabel withFont : myFont];

    [self addSubview:_titleLabel];

    return _titleLabel.frame.size.height;
}

- (NSInteger) addEnglishCommentText : (NSString*) myTextString
      withCurrentOverallSize : (NSInteger) myOveralSize
                    withFont : (UIFont*) myFont
{
    CGFloat myHeight = [self frameForText : myTextString sizeWithFont : myFont constrainedToSize : CGSizeMake(0, CGFLOAT_MAX)];
    CGRect myRect = CGRectMake(LEFT_SUB_MARGIN, TOP_MARGIN+myOveralSize, self.bounds.size.width - 2*LEFT_SUB_MARGIN, VIEW_PADDING + myHeight);
    
    if (_subTitleLabel == nil){
        _subTitleLabel = [[UILabel alloc] initWithFrame:myRect];
    }
    
    _subTitleLabel.text = myTextString;
    _subTitleLabel = [self textLabelEnglishStyle:_subTitleLabel withFont : myFont];
    [self addSubview:_subTitleLabel];
    return _subTitleLabel.frame.size.height;
}

- (CGRect) setCGRectMainSize : (NSString*) myString
      withCurrentOverallSize : (NSInteger) myOveralSize
                    withFont : (UIFont*) myFont
{
    CGFloat myHeight = [self frameForText : myString sizeWithFont : myFont constrainedToSize : CGSizeMake(0, CGFLOAT_MAX)];
    CGRect myRect = CGRectMake(LEFT_MARGIN,myOveralSize, self.frame.size.width-LEFT_DOUBLE_MARGIN, myHeight);
    
    return myRect;
}

//
/////
//

- (UILabel*) titleLabelStyle : (UILabel*) myLabel withFont : (UIFont*) myFont{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    //
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
    myLabel.textAlignment = NSTextAlignmentCenter;
    return myLabel;
}

- (UILabel*) textLabelEnglishStyle : (UILabel*) myLabel withFont : (UIFont*) myFont
{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    //
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
    myLabel.textAlignment = NSTextAlignmentCenter;

    return myLabel;
}

//
/////
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//
////
//

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


@end
