//
//  MainFoundation.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation ()

@end

@implementation MainFoundation

@synthesize thePrimaryAttribute=_thePrimaryAttribute,thePrimarybook=_thePrimarybook,theProphetText=_theProphetText,theWritingsText=_theWritingsText,theTorahText=_theTorahText,menuListArray=_menuListArray,primaryDataArray=_primaryDataArray,primaryEnglishTextArray=_primaryEnglishTextArray,primaryHebrewTextArray=_primaryHebrewTextArray,viewTitleEnglish=_viewTitleEnglish,viewTitleHebrew=_viewTitleHebrew,theChapterNumber=_theChapterNumber,myTanachTextClass=_myTanachTextClass,theChapterMax=__theChapterMax,mySpeechClass=_mySpeechClass,managedObjectContext=_managedObjectContext,menuChoiceArray=_menuChoiceArray,menuListPathArray=_menuListPathArray,menuPathChoiceArray=_menuPathChoiceArray,myGestureClass=_myGestureClass,theCurrentChapterNumber=_theCurrentChapterNumber;

@synthesize myEnglishDataModel=_myEnglishDataModel,myHebrewDataModel=_myHebrewDataModel,myEnglishDataModelArray=_myEnglishDataModelArray,myHebrewDataModelArray=_myHebrewDataModelArray;

#define DK 2
#define LOG if(DK == 1)

//
//
///////
#pragma Mark - Save Data
///////
//
//

- (void) saveData:(NSManagedObjectContext*)myContext
{
    //NSLog(@"saved!!");
    @try {
        NSError *error;
        if (![myContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    @catch (NSException *exception) {
        //[self myAlert:@"Could Not Save"];
    }
}

//
//
////////
#pragma mark - Gesture
////////
//
//

- (GestureClass*) myGestureClass {
    if (!_myGestureClass) {
        _myGestureClass = [[GestureClass alloc]init];
    }
    return _myGestureClass;
}

//
//
////////
#pragma mark - Language Check
////////
//
//


//
//
////////
#pragma mark - Notification Loader
////////
//
//

- (void) basicNotifications : (NSString*) mySelector withName : (NSString*) observerName
{
    SEL selector = NSSelectorFromString(mySelector);
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:selector
     name:observerName
     object:nil];
}

//
//
////////
#pragma mark - speech
////////
//
//

- (id)mySpeechClass
{
    if (!_mySpeechClass){
        _mySpeechClass = [[SpeechClass alloc] init];
    }
    return _mySpeechClass;
}

-(void) foundationRunSpeech: (NSArray*) speechArray
{
    if ([self.mySpeechClass runSpeech:speechArray]){
        LOG NSLog(@"playing");
    }
    else {
        LOG NSLog(@"stopped");
    }
}

- (void) foundationStopSpeech {
    [self.mySpeechClass stopSpeech];
}

- (void) foundationChangeSoudDefaults:(NSNotification *)notification {
    [self.mySpeechClass changeSoundDefaults];
}

- (void) loadSoundDefaultsNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(foundationChangeSoudDefaults:)
     name:@"soundStatusChange"
     object:nil];
}

//
#pragma mark - loadG
//

- (UIImage*) loadBGImage: (NSString*) nameOfBG
{
    if ([nameOfBG length]) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",nameOfBG] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:fileName];
        return image;
    }
    return nil;
}

//
//
////
#pragma mark - Database Load
////
//
//

- (void) loadTheFoundationDataBase
{
    @try {
        SefariaAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                
        self.managedObjectContext = nil;
        self.managedObjectContext = appDelegate.managedObjectContext;
        
        
        LOG NSLog(@"Delegate Data Load");
    }
    @catch (NSException *exception) {
        LOG NSLog(@"Delegate Error");
        //[self myAlert:@"Could Not Load Delegate"];
    }
    @finally {
    }
}

//
//
////////
#pragma mark - Life Cycle
////////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadTheFoundationDataBase];
    [self commonViewStyle];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = true;
}

- (void) commonViewStyle {
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.title=@"";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//
//
////////
#pragma mark - Setters
////////
//
//

- (TanachAttributeClass*) thePrimaryAttribute {
    if (!_thePrimaryAttribute){
        _thePrimaryAttribute = [[TanachAttributeClass alloc] init];
    }
    return _thePrimaryAttribute;
}

- (TanachTextClass*) myTanachTextClass {
    if (!_myTanachTextClass){
        _myTanachTextClass = [[TanachTextClass alloc] init];
    }
    return _myTanachTextClass;
}

//
////
//

- (void) setTheProphetText:(kProphets)theProphetText {
    _theProphetText = theProphetText;
    self.thePrimaryAttribute.prophets = theProphetText;
}

- (void) setTheTorahText:(kTorah)theTorahText {
    _theTorahText = theTorahText;
    self.thePrimaryAttribute.torah = theTorahText;
}

- (void) setTheWritingsText:(kWritings)theWritingsText {
    _theWritingsText = theWritingsText;
    self.thePrimaryAttribute.writings = theWritingsText;
}

- (void) setTheChapterNumber:(NSInteger)theChapterNumber {
    _theChapterNumber = theChapterNumber;
    if (_theChapterNumber > __theChapterMax - 1) {
        NSLog(@"-- Chapter upper limit --");
        _theChapterNumber = 0;
    }
    else if (_theChapterNumber < 0) {
        NSLog(@"-- Chapter zero limit --");
        _theChapterNumber = self.theChapterMax - 1;
    }
}

//
//// Performance Array
//

- (NSMutableArray *)myEnglishDataModelArray {
    if (!_myEnglishDataModelArray){
        _myEnglishDataModelArray = [[NSMutableArray alloc] init];
    }
    return _myEnglishDataModelArray;
}

- (NSMutableArray *)myHebrewDataModelArray {
    if (!_myHebrewDataModelArray){
        _myHebrewDataModelArray = [[NSMutableArray alloc] init];
    }
    return _myHebrewDataModelArray;
}

//
//// Menu Array
//

- (NSMutableArray *) menuChoiceArray {
    if (!_menuChoiceArray){
        _menuChoiceArray = [[NSMutableArray alloc] init];
    }
    return _menuChoiceArray;
}

- (NSMutableArray *) menuPathChoiceArray {
    if (!_menuPathChoiceArray){
        _menuPathChoiceArray = [[NSMutableArray alloc] init];
    }
    return _menuPathChoiceArray;
}

//
//
////
#pragma mark - Cleaner
////
//
//

- (void) didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        [self myCleaner];
    }
}

- (void) myCleaner {
    UIViewController *vc = self;
    while ([vc presentingViewController] != NULL) {
        vc = [vc presentingViewController];
    }
    [self cleanTheSubview];
    [vc removeFromParentViewController];
    [vc dismissViewControllerAnimated:NO completion:nil];
}

- (void) cleanTheSubview
{
    for(UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
}

- (void) dealloc {
    LOG NSLog(@"Main Dealloc called");
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception) {
        LOG NSLog(@"Error: %@",exception);
    }
}



@end
