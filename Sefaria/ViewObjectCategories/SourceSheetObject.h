//
//  SourceSheetObject.h
//  Sefaria
//
//  Created by MGM on 8/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TitleGroupUIView.h"
#import "LineTextGroupUIView.h"
#import "CommentTextUIView.h"

@class TitleGroupUIView;
@class LineTextGroupUIView;
@class CommentTextUIView;

@interface SourceSheetObject : NSObject

@property (nonatomic,strong) TitleGroupUIView* thetitle;


@property (nonatomic,strong) NSString* titleString;
@property (nonatomic,strong) NSString* subTitleString;
@property (nonatomic,strong) NSString* commentString;


@property (nonatomic) NSInteger titleHeight;


@property (nonatomic,strong) NSMutableArray* contentArray;

@property (nonatomic,strong) NSMutableArray* dataArray;

@property (nonatomic,strong) NSMutableArray* heightArray;

@property (nonatomic) NSInteger completeHeight;
@property (nonatomic) NSInteger theWidth;

//
////
//

- (NSInteger) setHeadingTextObjectView : (NSInteger) viewCurrentSize withHeadingText : (NSArray*) myHeadingText withScrollView : (UIScrollView*) myScrollView;
- (NSInteger) setLineTextObjectView : (NSInteger) viewCurrentSize withLineText : (LineText*) myLineText withDepth : (NSInteger) theDepth withScrollView : (UIScrollView*) myScrollView;
- (NSInteger) setCommentTextObjectView :(NSInteger) viewCurrentSize withCommentText : (NSString*) myCommentText withDepth : (NSInteger) theDepth withScrollView : (UIScrollView*) myScrollView;

- (void) titleBuild : (UIScrollView*)myScrollView;


@end
