//
//  CommentText.m
//  Sefaria
//
//  Created by MGM on 8/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentTextUIView.h"

@implementation CommentTextUIView

@synthesize commentString=_commentString,thisViewHeight=_thisViewHeight,commentLabel=_commentLabel;

#define DK 2
#define LOG if(DK == 1)

#define LEFT_SUB_MARGIN 50.0f
#define TOP_MARGIN 10.0f
#define VIEW_PADDING 20.0f

#define COMMENT_FONT @"HelveticaNeue-Light"

#define COMMENT_TEXT_FONT_SIZE 14.0f
#define COMMENT_TEXT_FONT [UIFont fontWithName : COMMENT_FONT size : COMMENT_TEXT_FONT_SIZE]

#define SHADOW_ALPHA 0.1f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

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
    
    _thisViewHeight = [self addEnglishText:_commentString withCurrentOverallSize:_thisViewHeight withFont:COMMENT_TEXT_FONT]+VIEW_PADDING;

    LOG NSLog(@"-- Comment in object height %ld--",(long)_thisViewHeight);
}

//
////
//

- (NSInteger) addEnglishText : (NSString*) myTextString
      withCurrentOverallSize : (NSInteger) myOveralSize
                    withFont : (UIFont*) myFont
{
    CGRect myRect = CGRectMake(LEFT_SUB_MARGIN, .5 * TOP_MARGIN+myOveralSize, self.bounds.size.width - 2*LEFT_SUB_MARGIN, VIEW_PADDING + 1.2*[self frameForText:myTextString sizeWithFont:myFont constrainedToSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)]);
    if (_commentLabel == nil){
        _commentLabel = [[UILabel alloc] initWithFrame:myRect];
    }
    _commentLabel.text = myTextString;
    _commentLabel = [self textLabelEnglishStyle:_commentLabel withFont : myFont];
    [self addSubview:_commentLabel];
    return _commentLabel.frame.size.height;
}

- (UILabel*) textLabelEnglishStyle : (UILabel*) myLabel withFont : (UIFont*) myFont
{
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor darkGrayColor];
    myLabel.textAlignment = NSTextAlignmentRight;
    myLabel.font = myFont;
    myLabel.tag = TAG_BASE;
    //
    myLabel.numberOfLines = 0;
    //[myLabel sizeToFit];
    //[myLabel setLineBreakMode:NSLineBreakByWordWrapping];
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//
//
/////
#pragma mark - Clear
/////
//
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
