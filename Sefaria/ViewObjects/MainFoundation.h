//
//  MainFoundation.h
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SefariaAppDelegate.h"
@import AVFoundation;

#import "SefariaAppDelegate.h"

#import "TanachDataModel.h"
@class TanachDataModel;

#import "TanachTextClass.h"
@class TanachTextClass;

#import "SpeechClass.h"
@class SpeechClass;

#import "GestureClass.h"
@class GestureClass;

#import "BestStringClass.h"
@class BestStringClass;

#import "RestTextDataFetch.h"
@class RestTextDataFetch;

#import "RestMenuDataFetch.h"
@class RestMenuDataFetch;

#import "TextTitle.h"
#import "BookTitle.h"
#import "LineText.h"
#import "Comment.h"
#import "CommentAuthor.h"
#import "CommentCollectionTitle.h"



@interface MainFoundation : UIViewController

@property (strong,nonatomic) RestTextDataFetch* myRestTextDataFetch;
@property (strong,nonatomic) RestMenuDataFetch* myRestMenuDataFetch;

@property (nonatomic, strong) NSArray* fetchedRecordsArray;

@property (nonatomic, strong) TanachTextClass* myTanachTextClass;

@property (strong,nonatomic) NSMutableArray* searchTextArray;
@property (strong,nonatomic) NSMutableArray* searchInfoArray;
@property (strong,nonatomic) NSMutableArray* searchLineDataArray;
@property (nonatomic) bool isWideView;
@property (nonatomic) bool isSingleViewEnglish;


@property (nonatomic, strong) NSArray* primaryDataArray;
@property (nonatomic, strong) NSArray* primaryEnglishTextArray;
@property (nonatomic, strong) NSArray* primaryHebrewTextArray;
@property (nonatomic, strong) NSArray* menuListArray;
@property (nonatomic, strong) NSArray* menuListPathArray;
@property (nonatomic, strong) NSArray* commentArray;
@property (nonatomic, strong) NSArray* bookmarkArray;
@property (nonatomic, strong) NSArray* bookmarkChapterArray;


@property (nonatomic) NSInteger menuDepthCount;

@property (nonatomic, strong) NSArray* chapterListArray;

@property (nonatomic, strong) NSString* viewTitleEnglish;
@property (nonatomic, strong) NSString* viewTitleHebrew;
@property (nonatomic) NSInteger theChapterNumber;
@property (nonatomic) NSInteger theChapterMax;

@property (nonatomic) bool isNavBarShowing;
@property (nonatomic) bool isMenuShowing;
@property (nonatomic) bool menuIsMoving;

@property (nonatomic) bool isChapterShowing;
@property (nonatomic) bool chapterIsMoving;

@property (nonatomic) NSInteger menuDepthLevel;
@property (nonatomic) bool isTextLevel;
@property (nonatomic) bool isBookLevel;

@property (nonatomic) bool isSelectionText;
@property (nonatomic) bool isSelectionComments;

@property (nonatomic, strong) NSString* myCurrentTextTitle;
@property (nonatomic) NSInteger theCurrentChapterNumber;

@property (nonatomic, strong) NSMutableArray* menuChoiceArray;
@property (nonatomic, strong) NSMutableArray* menuPathChoiceArray;
@property (nonatomic, strong) NSMutableArray* menuTopPathChoiceArray;

@property (strong,nonatomic) NSMutableString* theSearchTerm;


@property (nonatomic,strong) UIActivityIndicatorView* myActivityIndicator;

//
////
//

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext* seedManagedObjectContext;

//
////
//
@property (nonatomic, strong) TanachAttributeClass* thePrimaryAttribute;
@property (nonatomic) kTanachBooks thePrimarybook;
@property (nonatomic) kProphets theProphetText;
@property (nonatomic) kWritings theWritingsText;
@property (nonatomic) kTorah theTorahText;
//
////
//

//
//// PERFORMANCE DATA LOAD CLASSES
//
@property (nonatomic, strong) TanachDataModel* myEnglishDataModel;
@property (nonatomic, strong) TanachDataModel* myHebrewDataModel;
@property (nonatomic, strong) NSMutableArray* myEnglishDataModelArray;
@property (nonatomic, strong) NSMutableArray* myHebrewDataModelArray;

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,strong) NSIndexPath* currentIndexPath;


//
#pragma mark - Save Data
//
- (void) saveData:(NSManagedObjectContext*)myContext;

//
#pragma mark - nav options
//
@property (nonatomic) BOOL soundSet;
@property (nonatomic) BOOL navHideSet;
@property (nonatomic) BOOL bookmarkSet;
@property (nonatomic) BOOL fontSizeLargeSet;

//
#pragma mark - Speech
//
- (void) foundationChangeSoudDefaults;

@property (strong,nonatomic) SpeechClass* mySpeechClass;
- (void) foundationRunSpeech: (NSArray*) speechArray;
- (void) foundationStopSpeech;

//
#pragma mark - Gesture
//
@property (strong,nonatomic) GestureClass* myGestureClass;

//
#pragma mark - NSATRString
//
@property (strong,nonatomic) BestStringClass* myBestStringClass;

//
#pragma mark - Notification
//
- (void) basicNotifications : (NSString*) mySelector withName : (NSString*) observerName;

//
#pragma mark - orientation lock
//
- (BOOL) isPortraitOrientation;
- (void) portraitLock;
- (void) portraitUnLock;



@end

