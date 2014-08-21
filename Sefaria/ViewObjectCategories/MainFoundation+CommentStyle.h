//
//  MainFoundation+CommentStyle.h
//  Sefaria
//
//  Created by MGM on 8/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (CommentStyle)

- (NSString*) commentDetailText : (Comment*) myComment;
- (NSString*) commentTextFromObject:(Comment*) myComment;

@end
