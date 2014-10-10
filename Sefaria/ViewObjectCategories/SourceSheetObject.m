//
//  SourceSheetObject.m
//  Sefaria
//
//  Created by MGM on 8/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SourceSheetObject.h"

@implementation SourceSheetObject

@synthesize thetitle=_thetitle,contentArray=_contentArray,completeHeight=_completeHeight,theWidth=_theWidth,heightArray=_heightArray,titleString=_titleString,subTitleString=_subTitleString,titleHeight=_titleHeight,dataArray=_dataArray,commentString=_commentString;

#define LEFT_LINE_MARGIN 50.0f
#define SUB_VIEW_PADDING 10.0f

#define LEFT_MARGIN 30.0f
#define LEFT_DOUBLE_MARGIN 2*LEFT_MARGIN
#define LEFT_SUB_MARGIN 10.0f
#define LEFT_DOUBLE_SUB_MARGIN 2*LEFT_SUB_MARGIN

#define TOP_MARGIN 10.0f
#define VIEW_PADDING 20.0f
#define SUB_VIEW_PADDING 10.0f

#define MAIN_FONT @"Georgia"
#define COMMENT_FONT @"HelveticaNeue-Light"

#define TEXT_FONT_SIZE 16.0f
#define TEXT_FONT_SIZE_LARGE 18.0f
#define INFO_FONT_SIZE 12.0f
#define TEXT_FONT [UIFont fontWithName : MAIN_FONT size : TEXT_FONT_SIZE]
#define TEXT_FONT_LARGE [UIFont fontWithName : MAIN_FONT size : TEXT_FONT_SIZE_LARGE]
#define INFO_FONT [UIFont fontWithName : MAIN_FONT size : INFO_FONT_SIZE]

#define COMMENT_TEXT_FONT_SIZE 14.0f
#define COMMENT_TEXT_FONT [UIFont fontWithName : COMMENT_FONT size : COMMENT_TEXT_FONT_SIZE]

#define TITLE_FONT_SIZE 30.0f
#define SUBHEADING_FONT_SIZE 15.0f
#define TITLE_FONT [UIFont fontWithName : MAIN_FONT size : TITLE_FONT_SIZE]
#define SUBHEADING_FONT [UIFont fontWithName : MAIN_FONT size : SUBHEADING_FONT_SIZE]

#define TAG_BASE 20000

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - Object Creation
////////
//
//

//
//// title
//

- (void) titleBuild : (UIScrollView*)myScrollView
{
    LOG NSLog(@"-- passed %@ --",@[self.titleString,self.subTitleString]);
    self.titleHeight = [self setHeadingTextObjectView:0 withHeadingText:@[self.titleString,self.subTitleString] withScrollView:myScrollView];
    LOG NSLog(@"-- VCS check %ld --",(long)self.titleHeight);
}

- (NSInteger) setHeadingTextObjectView : (NSInteger) viewCurrentSize withHeadingText : (NSArray*) myHeadingText withScrollView : (UIScrollView*) myScrollView
{
    LOG NSLog(@"-- VCS %ld --",(long)viewCurrentSize);
    NSInteger computedHeight = [self computeTotalTextHeightForHeadingTextBlock : myHeadingText withSuperViewWidth : myScrollView.frame.size.width];
    CGRect myRect = CGRectMake(LEFT_MARGIN, viewCurrentSize, myScrollView.frame.size.width - 2*LEFT_MARGIN, computedHeight);
    TitleGroupUIView*myTitleView = [[TitleGroupUIView alloc]initWithFrame:myRect];
    myTitleView.titleString = [myHeadingText firstObject];
    myTitleView.theSubtitleString = [myHeadingText lastObject];
    myTitleView.tag = TAG_BASE;

    _thetitle = myTitleView;
    return myTitleView.frame.size.height;
}

- (NSInteger) computeTotalTextHeightForHeadingTextBlock : (NSArray*) myHeadingText  withSuperViewWidth : (NSInteger) superViewWidth
{
    NSString* heading = [myHeadingText firstObject];
    NSString* subHeading = [myHeadingText lastObject];
    CGSize headingSize = [self frameForText : heading sizeWithFont : TITLE_FONT constrainedToSize : CGSizeMake(superViewWidth, CGFLOAT_MAX)];
    CGSize subHeadingSize = [self frameForText : subHeading sizeWithFont : SUBHEADING_FONT constrainedToSize : CGSizeMake(superViewWidth, CGFLOAT_MAX)];
    NSInteger myTotal = 1.2*headingSize.height + 1.2*subHeadingSize.height + 2*VIEW_PADDING;
    self.completeHeight = self.completeHeight + myTotal;
    LOG NSLog(@"-- view size check - %ld - %ld --",(long)self.completeHeight,(long)self.titleHeight);
    return myTotal;
}

//
///// line
//

- (NSInteger) setLineTextObjectView : (NSInteger) viewCurrentSize
                       withLineText : (LineText*) myLineText
                          withDepth : (NSInteger) theDepth
                     withScrollView : (UIScrollView*) myScrollView
{
    LOG NSLog(@"-- view size check %ld - %ld - %ld --",(long)viewCurrentSize,(long)self.completeHeight,(long)self.titleHeight);

    NSInteger computedHeight = [self computeTotalTextHeightForLineTextBlock : myLineText
                                                         withSuperViewWidth : myScrollView.frame.size.width];
    
    CGRect myRect = CGRectMake(LEFT_LINE_MARGIN, VIEW_PADDING + viewCurrentSize, myScrollView.frame.size.width - 2 * LEFT_LINE_MARGIN, computedHeight);
    LineTextGroupUIView*myLTGView = [[LineTextGroupUIView alloc]initWithFrame:myRect];
    myLTGView.theLineText = myLineText;
    myLTGView.tag = TAG_BASE + theDepth;

    [self.contentArray addObject:myLTGView];
    return myLTGView.frame.size.height;
}

- (NSInteger) computeTotalTextHeightForLineTextBlock : (LineText*) myLineText withSuperViewWidth : (NSInteger) superViewWidth
{    
    NSString* myEnglishString = myLineText.englishText;
    NSString* myHebrewString = myLineText.hebrewText;
    
    NSString* textTitle = myLineText.whatTextTitle.englishName;
    NSInteger chapterNumber = [myLineText.chapterNumber integerValue];
    NSInteger lineNumber = [myLineText.lineNumber integerValue];
    NSString* lineInfo = [NSString stringWithFormat:@"%@ Chapter %ld Line %ld", textTitle,(long)chapterNumber+1,(long)lineNumber+1];
    
    CGSize engSize = [self frameForText:myEnglishString sizeWithFont:TEXT_FONT constrainedToSize:CGSizeMake(superViewWidth - 2 * LEFT_LINE_MARGIN, CGFLOAT_MAX)];
    CGSize hebSize = [self frameForText:myHebrewString sizeWithFont:TEXT_FONT_LARGE constrainedToSize:CGSizeMake(superViewWidth - 2 * LEFT_LINE_MARGIN, CGFLOAT_MAX)];
    CGSize commentSize = [self frameForText:lineInfo sizeWithFont:INFO_FONT constrainedToSize:CGSizeMake(superViewWidth - 2 * LEFT_LINE_MARGIN, CGFLOAT_MAX)];

    NSInteger myTotal = 1.2 * engSize.height + 1.2 * hebSize.height + 1.2 * commentSize.height + 3 * VIEW_PADDING;
    self.completeHeight = self.completeHeight + myTotal+10;

    LOG NSLog(@"-- computed title %ld --",(long)_completeHeight);
    return myTotal;
}

//
//// comment
//

- (NSInteger) setCommentTextObjectView : (NSInteger) viewCurrentSize
                       withCommentText : (NSString*) myCommentText
                             withDepth : (NSInteger) theDepth
                        withScrollView : (UIScrollView*) myScrollView
{
    NSInteger computedHeight = [self computeTotalTextHeightForCommentTextBlock : myCommentText withSuperViewWidth : myScrollView.frame.size.width];
    CGRect myRect = CGRectMake(0, viewCurrentSize + 30, myScrollView.frame.size.width, computedHeight);
    CommentTextUIView *myComment = [[CommentTextUIView alloc]initWithFrame:myRect];
    myComment.commentString = myCommentText;
    myComment.tag = TAG_BASE + theDepth;

    [self.contentArray addObject:myComment];
    return myComment.frame.size.height;
}

- (NSInteger) computeTotalTextHeightForCommentTextBlock : (NSString*) myCommentText  withSuperViewWidth : (NSInteger) superViewWidth {
    CGSize commentSize = [self frameForText : myCommentText sizeWithFont : COMMENT_TEXT_FONT constrainedToSize : CGSizeMake(superViewWidth - 2 * LEFT_LINE_MARGIN, CGFLOAT_MAX)];
    NSInteger myTotal = 1.2*commentSize.height + 2*VIEW_PADDING;
    LOG NSLog(@"-- Computed comment height %ld--",(long)myTotal);
    self.completeHeight = self.completeHeight + myTotal+10;
    return myTotal;
}

//
//
////////
#pragma mark - Setter
////////
//
//

- (NSMutableArray*) contentArray {
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc]init];
    }
    return _contentArray;
}

- (NSMutableArray*) heightArray {
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc]init];
    }
    return _heightArray;
}

- (NSMutableArray*) dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
    
}

//
//
////////
#pragma mark - Frame
////////
//
//

- (CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin)
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size;
}

//
//
////////
#pragma mark - Frame
////////
//
//

- (id)init
{
    //NSLog(@"init");
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
