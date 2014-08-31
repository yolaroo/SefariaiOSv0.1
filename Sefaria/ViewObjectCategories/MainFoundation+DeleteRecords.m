//
//  MainFoundation+DeleteRecords.m
//  Sefaria
//
//  Created by MGM on 8/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+DeleteRecords.h"

#import "MainFoundation+FetchTheComment.h"
#import "MainFoundation+FetchTheCommentCollectionTitle.h"
#import "MainFoundation+FetchTheCommentAuthor.h"

#import "MainFoundation+FetchTheContextGroupComment.h"
#import "MainFoundation+FetchTheContextGroupData.h"
#import "MainFoundation+FetchTheContextGroup.h"

@implementation MainFoundation (DeleteRecords)

- (void) masterCommentDelete
{
    NSLog(@"Deleting All Comments");
    [self deleteAllComments];
    [self deleteAllCommentsAuthors];
    [self deleteAllCommentsCollections];
}


- (void) deleteAllComments {
    NSArray* myFetch = [self fetchAllComments : self.managedObjectContext];
    for (Comment* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}

- (void) deleteAllCommentsAuthors {
    NSArray* myFetch = [self fetchAllCommentAuthors : self.managedObjectContext];
    for (CommentAuthor* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}

- (void) deleteAllCommentsCollections {
    NSArray* myFetch = [self fetchAllCommentCollectionTitles : self.managedObjectContext];
    for (CommentCollectionTitle* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}



- (void) masterSourceSheetDelete
{
    NSLog(@"delete source sheets");
    [self deleteAllContextGroups];
    [self deleteAllContextGroupData];
    [self deleteAllContextGroupComments];
    
}

- (void) deleteAllContextGroups {
    NSArray* myFetch = [self fetchAllContextGroups : self.managedObjectContext];
    for (Comment* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}

- (void) deleteAllContextGroupData {
    NSArray* myFetch = [self fetchAllContextGroupData : self.managedObjectContext];
    for (Comment* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}

- (void) deleteAllContextGroupComments {
    NSArray* myFetch = [self fetchAllContextGroupDataComment : self.managedObjectContext];
    for (Comment* theMCT in myFetch) {
        [self.managedObjectContext deleteObject:theMCT];
    }
    [self saveData : self.managedObjectContext];
}

@end
