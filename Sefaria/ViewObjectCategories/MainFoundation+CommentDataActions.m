//
//  MainFoundation+CommentDataActions.m
//  Sefaria
//
//  Created by MGM on 7/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+CommentDataActions.h"

#import "CommentListDataModel.h"
#import "FileRecursion.h"
#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheLineText.h"

#import "Comment+Create.h"
#import "CommentAuthor+Create.h"
#import "CommentCollectionTitle+Create.h"

#import "MainFoundation+FetchTheComment.h"

@implementation MainFoundation (CommentDataActions)

#define COMMENT_DIRECTORY_II @"Tanach/Prophets/II Kings/Metzudat David on II Kings/English/merged"

#define DK 2
#define LOG if(DK == 1)

- (void) buildCoreDataStackForComments : (NSManagedObjectContext*)context
{
    CommentListDataModel* myCommentListDataModel = [[CommentListDataModel alloc]init];
    NSArray*myCompleteList = myCommentListDataModel.superCommentList;
    
    for (NSString* STR in myCompleteList) {
        LOG NSLog(@"-- Comment %@ --",STR);
        CommentListDataModel* myCommentData = [CommentListDataModel newCommentDataLoader:STR];
        [self commentUnwrap:myCommentData withContext:context];
    }

    [self saveData:context];
    NSLog(@"Finished Comment Loop");
}

//
//
/////
#pragma mark - Get List of Comments Texts
/////
//
//

- (NSArray*) getCommentListData: (NSString*)textName
{
    CommentListDataModel* textData = [CommentListDataModel newCommentDataLoader:textName];
    NSArray* myTextArray = textData.theCompleteTextArray;
    return myTextArray;
}


//
//
/////
#pragma mark - Core Data - Comment Builder Action
/////
//
//

- (void) commentUnwrap :  (CommentListDataModel*) myCommentData withContext: (NSManagedObjectContext*)context
{
    //NSInteger theArrayCount = [theTextArray count];
    //NSLog(@"-- TAC %d--",theArrayCount);
    NSArray* theTextArray = myCommentData.theCompleteTextArray;
    
    if ([theTextArray isKindOfClass:[NSArray class]]) {
        for (int i = 0; i < [theTextArray count]; i++) {
            
            id myChapter = [theTextArray objectAtIndex:i];
            NSInteger chapterNumber = i+1;
            LOG NSLog(@"-- CH %d --",chapterNumber);
            
            if ([myChapter isKindOfClass:[NSArray class]]){

                for (int j = 0; j < [(NSArray*)myChapter count]; j++) {
                    id theText = [(NSArray*)myChapter objectAtIndex:j];
                    
                    
                    if ([theText isKindOfClass:[NSArray class]]){
                        NSMutableString* myTempLineString = [[NSMutableString alloc]initWithString:@""];

                        for (int k = 0; k < [(NSArray*)theText count]; k++) {
                            
                            id theSecondText = [(NSArray*)theText objectAtIndex:k];
                            NSInteger lineNumber = j+1;
                            LOG NSLog(@"-- LN %d --",lineNumber);

                            if (k != 0){
                                [myTempLineString appendString:(NSString*)@" "];
                            }
                            
                            if ([theSecondText isKindOfClass:[NSString class]]) {
                                [myTempLineString appendString:(NSString*)theSecondText];
                            }
                            else {
                                NSLog(@"comment Error");
                            }
                        }
                        
                        LOG NSLog(@"-- STRING %@--",myTempLineString);
                        LOG NSLog(@"-- going to comment create --");
                        NSInteger myLineNumber = j+1;
                        
                        LOG NSLog(@"comment unwrap");
                        [self masterCommentBuildAction:myCommentData withChapter:chapterNumber withLineNumber:myLineNumber withCommentContents : myTempLineString withContext:context];
                        LOG NSLog(@"-- finished creation --");
                        
                    }
                    if ([theText isKindOfClass:[NSString class]]){ //error
                        //NSLog(@"-- Error the text is empty %@--",theText);
                    }
                }
            }
            if ([myChapter isKindOfClass:[NSString class]]){ //error
                NSLog(@"-- Error the chapter had an error %@--",myChapter);
            }
        }
    }
    else if ([theTextArray isKindOfClass:[NSString class]]) {
        NSLog(@"Error comment text is String");
    }
    else {
        NSLog(@"-- main object comment error --");
    }
    

}

- (void) masterCommentBuildAction: (CommentListDataModel*) myCommentData withChapter: (NSInteger) theChapterNumber withLineNumber: (NSInteger) theLineNumber withCommentContents : (NSString*) myCommentContents withContext: (NSManagedObjectContext*)context
{
    CommentAuthor* theAuthor = [self createCommentAuthorForComment: myCommentData withContext:context];
    LOG NSLog(@"-- Author Name %@ --",theAuthor.name);
    CommentCollectionTitle* theCollection = [self createCommentCollectionTitleForComment:myCommentData withContext:context];
    theCollection.whatCommentAuthor = theAuthor;
    LOG NSLog(@"-- CommentCollectionTitle Name %@ --",theCollection.englishName);
    
    NSString* theText = myCommentData.theTextName;
    NSString* theLanguage = myCommentData.theLanguage;
    
    TextTitle* theTextTitle = [[self fetchTextTitleByNameString:theText withContext:context]firstObject];
    LOG NSLog(@"-- theTextTitle  %@ --",theTextTitle.englishName);
    
    LineText* theLineText = [[self fetchLineTextByAttributes:theTextTitle withLineNumber:theLineNumber withChapterNumber:theChapterNumber withContext:context]firstObject];
    LOG NSLog(@"-- LineText  %@ --",theLineText.englishText);
    
    Comment* theComment;
    if ([theLanguage isEqualToString:@"en"]) {
        LOG NSLog(@"is english");
        theComment = [Comment newComment:theTextTitle withEnglishText:myCommentContents withHebrewText:@"" withAuthor:theAuthor withCollectionTitle:theCollection withLineText:theLineText withChapterNumber:theChapterNumber withLineNumber:theLineNumber withContext:context];
        theComment.isEnglish = [NSNumber numberWithBool:true];
    }
    else if ([theLanguage isEqualToString:@"he"]) {
        LOG NSLog(@"is hebrew");
        theComment = [Comment newComment:theTextTitle withEnglishText:@"" withHebrewText:myCommentContents withAuthor:theAuthor withCollectionTitle:theCollection withLineText:theLineText withChapterNumber:theChapterNumber withLineNumber:theLineNumber withContext:context];
        theComment.isHebrew = [NSNumber numberWithBool:true];
    }
}

//
//// Create Author
//

- (CommentAuthor*) createCommentAuthorForComment : (CommentListDataModel*)myCommentData withContext: (NSManagedObjectContext*)context
{
    CommentAuthor* newAuthor = [CommentAuthor newCommentAuthor:myCommentData.theCommentator withContext:context];
    return newAuthor;
}

//
//// Create Collection Title
//

- (CommentCollectionTitle*) createCommentCollectionTitleForComment : (CommentListDataModel*)myCommentData withContext: (NSManagedObjectContext*)context
{
    CommentCollectionTitle* newAuthor = [CommentCollectionTitle newCommentCollectionTitle: myCommentData.theEnglishTitle withHebrewTitle:myCommentData.theHebrewTitle withContext:context];
    return newAuthor;
}

//
//
/////
#pragma mark - Line Text Fetch
/////
//
//

- (LineText*) fetchLineTextForComment : (CommentListDataModel*) myCommentData withChapter: (NSInteger) theChapterNumber withLineNumber: (NSInteger)theLineNumber withContext: (NSManagedObjectContext*)context
{
    NSString* theEnglishTitle = myCommentData.theEnglishTitle;
    TextTitle* theText = [[self fetchTextTitleByNameString:theEnglishTitle withContext:context]firstObject];
    return [[self fetchLineTextByAttributes:theText withLineNumber:theLineNumber withChapterNumber:theChapterNumber withContext:context]firstObject];
}

//
//
/////
#pragma mark - Comment Data Check
/////
//
//

- (void) allCommentTest : (NSManagedObjectContext*)context
{
    CommentListDataModel* myCommentListDataModel = [[CommentListDataModel alloc]init];
    NSArray*myCompleteList = myCommentListDataModel.superCommentList;
    for (NSString* STR in myCompleteList) {
        [self createCommentDataFromName:STR withContext:self.managedObjectContext];
    }
    NSLog(@"Finished Comment Loop");
}

- (void) testForCommentData : (CommentListDataModel*) myCommentData withContext: (NSManagedObjectContext*)context
{
    NSString* theLanguage = myCommentData.theLanguage;
    NSString* theText = myCommentData.theTextName;
    NSString* theCommentator = myCommentData.theCommentator;
    NSString* theEnglishTitle = myCommentData.theEnglishTitle;
    NSString* theHebrewTitle = myCommentData.theHebrewTitle;
    //NSInteger theChapterCount = myCommentData.theChapterCount;
    
    NSLog(@"-- theLanguage : %@ --",theLanguage);
    NSLog(@"-- theText : %@ --",theText);
    NSLog(@"-- theCommentator : %@ --",theCommentator);
    NSLog(@"-- theEnglishTitle : %@ --",theEnglishTitle);
    NSLog(@"-- theHebrewTitle : %@ --",theHebrewTitle);
    //NSLog(@"-- Chapter Count %d--",theChapterCount);
    
    NSArray* theTextArray = myCommentData.theCompleteTextArray;
    NSLog(@"-- THETEXT %@ --",theTextArray);
    //[self commentUnwrap:myCommentData withContext:context];
}

//
//
/////
#pragma mark - Build Comments
/////
//
//

- (void) testCommentDataAction
{
    NSLog(@"loaded comment data");
    [self createCommentDataFromName:COMMENT_DIRECTORY_II withContext:self.managedObjectContext];
}

- (void) createCommentDataFromName : (NSString*) textName withContext: (NSManagedObjectContext*)context {
    CommentListDataModel* myCommentData = [CommentListDataModel newCommentDataLoader:textName];
    //NSLog(@"-- MCDM %@ --",myCommentData);
    [self testForCommentData : myCommentData withContext:context];
}

//
////
//

- (void) testCommentBuild : (NSManagedObjectContext*)context
{
    CommentListDataModel* myCommentListDataModel = [[CommentListDataModel alloc]init];
    NSArray*myCompleteList = myCommentListDataModel.superCommentList;
    NSString* STR = [myCompleteList objectAtIndex:0];
    NSLog(@"-- Comment %@ --",STR);
    
    CommentListDataModel* myCommentData = [CommentListDataModel newCommentDataLoader:STR];
    [self testForCommentData:myCommentData withContext:context];
    [self commentUnwrap:myCommentData withContext:context];
}

//
//
/////
#pragma mark - Test Fetch
/////
//
//

- (void) testTempCommentFetch
{
    NSLog(@"Comment Fetch");
    NSArray* myFetch = [self fetchAllComments : self.managedObjectContext];
    for (Comment* MCT in myFetch) {
        CommentAuthor* author = MCT.whatAuthor;
        TextTitle* textTitle = MCT.whatTextTitle;
        NSLog(@"-- English Text: %@ - HebrewText: %@ - LineNumber : %@ - ChapterNumber : %@ - Author %@ - Text %@--",MCT.englishText,MCT.hebrewText,MCT.lineNumber,MCT.chapterNumber,author.name, textTitle.englishName);
    }
}

//
////
//

- (void) testFetchCommentByText : (NSManagedObjectContext*)context
{
    TextTitle* mytextTitle = [[self fetchTextTitleByNameString:@"Genesis" withContext:context]firstObject];
    NSArray* myCommentArray = [self fetchBookCommentForChapterByTextName:mytextTitle withChapterNumber:1 withContext:context];
    for (Comment* CMT in myCommentArray) {
        //NSLog(@"-- EC : %@ HC : %@ CN : %@ LN : %@ --",CMT.englishText,CMT.hebrewText,CMT.chapterNumber, CMT.lineNumber);
        NSLog(@"-- CN %@ - LN %@ - TT %@ - CA %@ --",CMT.chapterNumber,CMT.lineNumber, CMT.whatTextTitle.englishName, CMT.whatAuthor.name);
    }
}

@end
