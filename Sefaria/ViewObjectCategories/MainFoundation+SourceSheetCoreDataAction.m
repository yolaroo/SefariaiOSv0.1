//
//  MainFoundation+SourceSheetCoreDataAction.m
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SourceSheetCoreDataAction.h"


#import "ContextGroup+Create.h"
#import "ContextGroupData+Create.h"
#import "ContextGroupComment+Create.h"

#import "MainFoundation+FetchTheContextGroup.h"

@implementation MainFoundation (SourceSheetCoreDataAction)


- (void) createSourceSheetCoreDataObject : (SourceSheetObject*) mySourceSheet withContext : (NSManagedObjectContext*) context
{
    __unused ContextGroup* myContextGroup = [ContextGroup newContextGroup:mySourceSheet.titleString withSubTitle:mySourceSheet.subTitleString withContext:context];
    
    //fetch all ContextGroup do count -- fetch by reverse order
    myContextGroup.displayOrder = 0;
    
    for (id MYID in mySourceSheet.dataArray) {
        if ([MYID isKindOfClass:[LineText class]]) {
            NSLog(@"add lineText");
            __unused ContextGroupData* myContextGroupData = [ContextGroupData newContextGroupLineText:myContextGroup withLineText:MYID withContext:context];
        }
        else if ([MYID isKindOfClass:[NSString class]]) {
            NSLog(@"add comment");
            ContextGroupData* myContextGroupData = [ContextGroupData newContextGroupComment:myContextGroup withGroupComment:MYID withContext:context];
            __unused ContextGroupComment* myContextGroupComment = [ContextGroupComment newContextGroupComment : MYID withDataGroup:myContextGroupData withContext:context];
        }
    }
    [self saveData:context];
}

- (void) testFetchSourceSheetwithContext : (NSManagedObjectContext*) context
{
    ContextGroup* testFetch = [[self fetchAllContextGroups : context] firstObject];
    
    NSLog(@"-- SourceFetch Title : %@ Subtitle : %@--",testFetch.title,testFetch.subTitle);
    
    NSArray* mydata = [testFetch.whatData allObjects];
    
    for (id  MYID in mydata) {
        ContextGroupData*myGCData = MYID;
        
        if (myGCData.isComment){
            
            ContextGroupComment* myComment = myGCData.whatComment;
            NSLog(@"-- comment text : %@ --",myComment.comment);
            
        }
        else if (myGCData.isLineText){
            LineText*myLineText = myGCData.whatLineText;
            NSLog(@"-- line text : %@ --",myLineText.englishText);
        }
    }
}



@end
