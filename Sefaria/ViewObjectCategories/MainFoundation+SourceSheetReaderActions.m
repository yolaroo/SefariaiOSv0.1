//
//  MainFoundation+SourceSheetReaderActions.m
//  Sefaria
//
//  Created by MGM on 8/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SourceSheetReaderActions.h"



@implementation MainFoundation (SourceSheetReaderActions)

//
//
////////
#pragma mark - Load Sheet
////////
//
//

- (void) fullDataLoadToView : (ContextGroup*) groupObject
             withScrollView : (UIScrollView*) theScrollView
            withSourceSheet : (SourceSheetObject*) theSourceSheet
{
    NSLog(@"data fetch and draw");
    [theSourceSheet.dataArray removeAllObjects];
    [self loadSheetAction : groupObject withSourceSheet:theSourceSheet];
    [self drawSheet : theScrollView withSourceSheet:theSourceSheet];
}

//
////
//

- (void) loadSheetAction : (ContextGroup*) groupObject withSourceSheet : (SourceSheetObject*) theSourceSheet {// first step - load data
    theSourceSheet.titleString = groupObject.title;
    theSourceSheet.subTitleString = groupObject.subTitle;
    
    NSArray* dataObjects = [groupObject.whatData allObjects];
    
    NSMutableArray* orderedData = [[NSMutableArray alloc]init];
    for (int i = 0; i < [dataObjects count]; i++) {
        for (int j = 0; j < [dataObjects count]; j++) {
            ContextGroupData* myOBJ = [dataObjects objectAtIndex:j];
            if ([myOBJ.displayOrder integerValue] == i){
                [orderedData addObject:myOBJ];
            }
        }
    }
    [self coreDataUnpack : [orderedData copy] withSourceSheet : theSourceSheet];
}

- (void) coreDataUnpack : (NSArray*) dataObjects withSourceSheet : (SourceSheetObject*) theSourceSheet {
    for (id MYID in dataObjects) {
        ContextGroupData* myOBJ = MYID;
        if ([myOBJ.isLineText boolValue]) {
            LineText* lineText = myOBJ.whatLineText;
            [theSourceSheet.dataArray addObject : lineText];
        }
        else if ([myOBJ.isComment boolValue]) {
            ContextGroupComment* myComment = myOBJ.whatComment;
            NSString* commentString = myComment.comment;
            [theSourceSheet.dataArray addObject : commentString];
        }
    }
}

//
////
//

- (void) drawSheet : (UIScrollView*) theScrollView withSourceSheet : (SourceSheetObject*) theSourceSheet
{ // second step - draw data
    [self cleanView : theScrollView];
    
    //size
    theSourceSheet.theWidth = theScrollView.frame.size.width;
    theSourceSheet.completeHeight = 0;
    
    //title
    if ([theSourceSheet.titleString length] && [theSourceSheet.subTitleString length]){
        [theSourceSheet titleBuild : theScrollView];
        [theScrollView addSubview:theSourceSheet.thetitle];
    }
    
    //lineText
    if ([theSourceSheet.dataArray count]>0) {
        [self buildLineTextObject : theScrollView withSourceSheet : theSourceSheet];
        [self addLineTextToSubview : theScrollView withSourceSheet : theSourceSheet];
    }
    theScrollView.contentSize =  CGSizeMake(theScrollView.frame.size.width,theSourceSheet.completeHeight*1.1) ;
}

//
////
//

- (void) addLineTextToSubview : (UIScrollView*) theScrollView withSourceSheet : (SourceSheetObject*) theSourceSheet
{
    for (id MOBJ in theSourceSheet.contentArray) {
        [theScrollView addSubview:MOBJ];
    }
}

- (void) buildLineTextObject : (UIScrollView*) theScrollView withSourceSheet : (SourceSheetObject*) theSourceSheet
{
    [theSourceSheet.contentArray removeAllObjects];
    NSInteger sourceSheetDepth = 1;
    for (id MYID in theSourceSheet.dataArray) {
        if ([MYID isKindOfClass:[LineText class]]) {
            [theSourceSheet setLineTextObjectView : theSourceSheet.completeHeight withLineText:MYID withDepth:sourceSheetDepth withScrollView:theScrollView];
            sourceSheetDepth++;
        }
        else if ([MYID isKindOfClass:[NSString class]]) {
            [theSourceSheet setCommentTextObjectView:theSourceSheet.completeHeight withCommentText:MYID withDepth:sourceSheetDepth withScrollView:theScrollView];
            sourceSheetDepth++;
        }
    }
}

//
////
//

- (void) cleanView : (UIScrollView*) theScrollView{
    NSArray *viewsToRemove = [theScrollView subviews];
    for (UIView *VWS in viewsToRemove) {
        [VWS removeFromSuperview];
    }
}



@end
