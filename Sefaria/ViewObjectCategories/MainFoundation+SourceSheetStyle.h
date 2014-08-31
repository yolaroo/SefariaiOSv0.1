//
//  MainFoundation+SourceSheetStyle.h
//  Sefaria
//
//  Created by MGM on 8/28/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SourceSheetStyle)

- (NSInteger) setHeadingTextObjectView : (NSInteger) viewCurrentSize withHeadingText : (NSArray*) myHeadingText withScrollView : (UIScrollView*) myScrollView;
- (NSInteger) setLineTextObjectView : (NSInteger) viewCurrentSize withLineText : (LineText*) myLineText withScrollView : (UIScrollView*) myScrollView;
- (NSInteger) setCommentTextObjectView :(NSInteger) viewCurrentSize withCommentText : (NSString*) myCommentText withScrollView : (UIScrollView*) myScrollView;

@end
