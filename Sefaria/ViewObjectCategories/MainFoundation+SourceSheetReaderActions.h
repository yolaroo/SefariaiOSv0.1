//
//  MainFoundation+SourceSheetReaderActions.h
//  Sefaria
//
//  Created by MGM on 8/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

#import "ContextGroup.h"
#import "ContextGroupData.h"
#import "ContextGroupComment.h"

#import "SourceSheetObject.h"
@class SourceSheetObject;

@interface MainFoundation (SourceSheetReaderActions)

- (void) fullDataLoadToView : (ContextGroup*) groupObject
             withScrollView : (UIScrollView*) theScrollView
            withSourceSheet : (SourceSheetObject*) theSourceSheet;


@end
