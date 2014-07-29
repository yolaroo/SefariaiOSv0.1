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

#import "TextTitle.h"
#import "BookTitle.h"
#import "LineText.h"

@interface MainFoundation : UIViewController

@property (nonatomic, strong) NSArray* fetchedRecordsArray;

@property (nonatomic, strong) TanachTextClass* myTanachTextClass;

@property (nonatomic, strong) NSArray* primaryDataArray;
@property (nonatomic, strong) NSArray* primaryEnglishTextArray;
@property (nonatomic, strong) NSArray* primaryHebrewTextArray;
@property (nonatomic, strong) NSArray* menuListArray;
@property (nonatomic, strong) NSArray* menuListPathArray;

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

@property (nonatomic, strong) NSString* myCurrentTextTitle;
@property (nonatomic, strong) NSMutableArray* menuChoiceArray;
@property (nonatomic, strong) NSMutableArray* menuPathChoiceArray;


//
////
//

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

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

//
#pragma mark - Save Data
//
- (void) saveData:(NSManagedObjectContext*)myContext;

//
#pragma mark - Speech
//
@property (strong,nonatomic) SpeechClass* mySpeechClass;
- (void) foundationRunSpeech: (NSArray*) speechArray;


@end

