//
//  MainTextView.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainTextView.h"
#import "MainFoundation+TextDataActionLayer.h"
#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+MenuActions.h"


@interface MainTextView  ()

//
////
//

@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer * edgeLeftPanGesture;
@property (strong,nonatomic) UIScreenEdgePanGestureRecognizer * edgeRightPanGesture;

@property (strong,nonatomic) UISwipeGestureRecognizer * closeMenuGesture;
@property (strong,nonatomic) UISwipeGestureRecognizer * closeChapterGesture;

@property (strong,nonatomic) UITapGestureRecognizer * showNavigationBarGesture;
@property (strong,nonatomic) UITapGestureRecognizer * hideBothMenuGesture;

@property (strong,nonatomic) UISwipeGestureRecognizer * nextChapterGesture;
@property (strong,nonatomic) UISwipeGestureRecognizer * previousChapterGesture;

//
//// STYLE COLLECTION
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
//// TABLES
//

@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UITableView *chapterTable;

@property (weak, nonatomic) IBOutlet UITableView *englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView *hebrewTextTable;

//
//// AUX Views
//

@property (weak, nonatomic) IBOutlet UIView *mainMenuView;
@property (weak, nonatomic) IBOutlet UIView *mainChapterView;

@property (weak, nonatomic) IBOutlet UIView *underNavBarView;

//
//// BUTTON
//

@property (weak, nonatomic) IBOutlet UIButton *englishTextButton;
@property (weak, nonatomic) IBOutlet UIButton *englishChapterButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewChapterButton;

@end

@implementation MainTextView

@synthesize edgeLeftPanGesture=_edgeLeftPanGesture,edgeRightPanGesture=_edgeRightPanGesture,closeMenuGesture=_closeMenuGesture,showNavigationBarGesture=_showNavigationBarGesture;

#define DK 2
#define LOG if(DK == 1)

#define TORAH_TAG 1000
#define PROPHET_TAG 1001
#define WRITINGS_TAG 1002

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define HIDE_CG CGPointMake(-150.0, 490.0)
#define SHOW_CG CGPointMake(260.0, 428.0)

#define HIDE_CH CGPointMake(1174.0, 490.0)
#define SHOW_CH CGPointMake(764.0, 428.0)

#define ANIMATE_DURATION 0.6
#define ANIMATE_OPACITY 0.2

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]

//
//
////////
#pragma mark - Button Action
////////
//
//

- (IBAction)hebrewTextButtonPress:(UIButton *)sender {
    [self moveMenuAction];
    [self moveChapterAction];
}

- (IBAction)EnglishTextButtonPress:(UIButton *)sender {
    [self moveMenuAction];
    [self moveChapterAction];
}

//
////
//

- (IBAction)hebrewChapterButtonPress:(UIButton *)sender {
    [self chapterPreviousAction];
}

- (IBAction)englishChapterButtonPress:(UIButton *)sender {
    [self chapterNextAction];
}

- (void) chapterNextAction {
    self.theChapterNumber ++;
    [self updateText];
}

- (void) chapterPreviousAction {
    self.theChapterNumber --;
    [self updateText];
}

//
//
////////
#pragma mark - NavigationBar Hide Action
////////
//
//

- (void) hideNavBar {
    if (!self.isNavBarShowing) {
        return;
    }
    self.isNavBarShowing = false;
    [UIView animateWithDuration:ANIMATE_DURATION*2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.navigationController.navigationBar.frame =  CGRectOffset(self.navigationController.navigationBar.frame, 0, -40 );
                     }
                     completion:^(BOOL finished){
                     //empty
                     }];
}

- (void) showNavBar {
    if (self.isNavBarShowing) {
        return;
    }
    
    self.isNavBarShowing = true;
    [UIView animateWithDuration:ANIMATE_DURATION/2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.navigationController.navigationBar.frame =  CGRectOffset(self.navigationController.navigationBar.frame, 0, 40 );
                     }
                     completion:^(BOOL finished){
                         [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:2.2];
                     }];
}

//
//
////////
#pragma mark - Menu Animation
////////
//
//

- (void) moveMenuAction {
    if (!self.menuIsMoving) {
        if (self.isMenuShowing) {
            [self hideMenu];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
        else {
            [self showMenu];
            self.menuIsMoving = true;
            self.isMenuShowing = !self.isMenuShowing;
        }
    }
}

- (void) hideMenu {
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainMenuView.center = HIDE_CG;
                         self.mainMenuView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

- (void) showMenu {
    [self.view bringSubviewToFront:self.mainMenuView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainMenuView.center = SHOW_CG;
                         self.mainMenuView.alpha = 1;

                     }
                     completion:^(BOOL finished){
                         self.menuIsMoving = false;
                     }];
}

//
//
////////
#pragma mark - Chapter Animation
////////
//
//

- (void) moveChapterAction {
    if (!self.chapterIsMoving) {
        if (self.isChapterShowing) {
            [self hideChapter];
            self.chapterIsMoving = true;
            self.isChapterShowing = !self.isChapterShowing;
        }
        else {
            [self showChapter];
            self.chapterIsMoving = true;
            self.isChapterShowing = !self.isChapterShowing;
        }
    }
}

- (void) hideChapter {
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainChapterView.center = HIDE_CH;
                         self.mainChapterView.alpha = ANIMATE_OPACITY;
                     }
                     completion:^(BOOL finished){
                         self.chapterIsMoving = false;
                     }];
}

- (void) showChapter {
    [self.view bringSubviewToFront:self.mainChapterView];
    [UIView animateWithDuration:ANIMATE_DURATION
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainChapterView.center = SHOW_CH;
                         self.mainChapterView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         self.chapterIsMoving = false;
                     }];
}

//
//
////////
#pragma mark - Button Selection For Menu
////////
//
//

- (IBAction)menuButtonPress:(UIButton *)sender {
    UIButton* mybutton = (UIButton*)sender;
    NSInteger mynumber = mybutton.tag;
    [self menuButtonAction : mynumber];
}

//
////
//

- (void) menuButtonAction : (NSInteger) buttonNumber {
    [self menuForTorahAction:buttonNumber];
    [self.menuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self updateMenu];
}


- (void) updateMenu {
    [self.menuTable reloadData];
    [self.chapterTable reloadData];
}

//
//
////////
#pragma mark - Table View
////////
//
//

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == MENU_TAG){
        return [self.menuListArray count] ? [self.menuListArray count] : 0;
    }
    else if (tableView.tag == ENGLISH_TAG) {
        return [self.primaryEnglishTextArray count] ? [self.primaryEnglishTextArray count] : 0;
    }
    else if (tableView.tag == HEBREW_TAG) {
        return [self.primaryHebrewTextArray count] ? [self.primaryHebrewTextArray count] : 0;
    }
    else if (tableView.tag == CHAPTER_TAG) {
        return [self.chapterListArray count] ? [self.chapterListArray count] : 0;
    }
    else {
        NSLog(@"Error on cell load");
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MENU_TAG) {
        NSString* myString = [self.menuListArray objectAtIndex:indexPath.row];
        return [self setMenuCell:MENU_CELL withString:myString];
    }
    else if (tableView.tag == ENGLISH_TAG){
        NSString* myString = [self englishTextFromArray : indexPath];
        return [self setMyEnglishTextCell:ENGLISH_CELL withString:myString];
    }
    else if (tableView.tag == HEBREW_TAG) {
        NSString* myString = [self hebrewTextFromArray : indexPath];
        return [self setMyHebrewTextCell:HEBREW_CELL withString:myString];
    }
    else if (tableView.tag == CHAPTER_TAG) {
        NSString* myString = [self.chapterListArray objectAtIndex:indexPath.row];
        return [self setChapterCell:CHAPTER_CELL withString:myString];
    }
    else {
        NSLog(@"Error - Cell");
        return nil;
    }
}

- (NSString*) englishTextFromArray:(NSIndexPath *)indexPath {
    if ([self.primaryEnglishTextArray count] > indexPath.row){
        return [self.primaryEnglishTextArray objectAtIndex:indexPath.row] ? [self.primaryEnglishTextArray objectAtIndex:indexPath.row] : @"error";
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}

- (NSString*) hebrewTextFromArray:(NSIndexPath *)indexPath {
    if ([self.primaryHebrewTextArray count] > indexPath.row){
        return [self.primaryHebrewTextArray objectAtIndex:indexPath.row] ? [self.primaryHebrewTextArray objectAtIndex:indexPath.row] : @"error";
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}

//
//
////////
#pragma mark - Table Height
////////
//
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self tableViewHeightTwoTables:tableView cellForRowAtIndexPath:indexPath];
}


//
//
////////
#pragma mark - TableView Animation Match
////////
//
//

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == ENGLISH_TAG){
        self.hebrewTextTable.contentOffset = self.englishTextTable.contentOffset;
    }
    else if (scrollView.tag == HEBREW_TAG){
        self.englishTextTable.contentOffset = self.hebrewTextTable.contentOffset;
    }
}

//
//
////////
#pragma mark - Table Press
////////
//
//

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MENU_TAG || tableView.tag == CHAPTER_TAG){
        [self tableViewMenuAction:tableView.tag didSelectRowAtIndexPath:indexPath];
        [self updateText];
    }
    else if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;
        [self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == HEBREW_TAG){
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        NSString*myCellText = cell.textLabel.text;
//        [self foundationRunSpeech:@[myCellText]];
    }
}

- (void) updateText {
    [self setTextData];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
    [self.chapterTable reloadData];
}

//
//
////////
#pragma mark - Text Data
////////
//
//

- (NSArray*) myArraySetter {
    @try {
        NSArray* mydata = [self getBilingualData: (kTanachBooks) self.thePrimarybook theText: (TanachAttributeClass*) self.thePrimaryAttribute];
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
////
//

- (void) setTextData {
    self.primaryDataArray = [self myArraySetter];
    if (self.primaryDataArray != nil && [self.primaryDataArray count] >= 4) {
        self.viewTitleEnglish = [self.primaryDataArray objectAtIndex:0];
        self.viewTitleHebrew = [self.primaryDataArray objectAtIndex:1];
        self.primaryEnglishTextArray = [self setTextFromChapter : [self.primaryDataArray objectAtIndex:2] theChapterNumber : self.theChapterNumber];
        self.primaryHebrewTextArray =  [self setTextFromChapter : [self.primaryDataArray objectAtIndex:3] theChapterNumber : self.theChapterNumber];
        self.theChapterMax = [[self.primaryDataArray objectAtIndex:4] integerValue];
        
        self.chapterListArray = [self chapterNumberArray: self.theChapterMax];

        [self setTextView];
    }
    else {
        NSLog(@"-- Error : Text Data --");
    }
}

//
////
//

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    [self.englishTextButton setTitle:self.viewTitleEnglish forState:UIControlStateNormal];
    [self.hebrewTextButton setTitle:self.viewTitleHebrew forState:UIControlStateNormal];
    
    NSString* englishChapterString = [NSString stringWithFormat:@"Chapter %ld",(long)self.theChapterNumber+1];
    
    [self.englishChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
    [self.hebrewChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
}

//
//
////////
#pragma mark - On Load
////////
//
//

- (void) initialSetUp {
    self.menuListArray = self.myTanachTextClass.foundationTorah;
    [self viewStyleForLoad];

    self.thePrimarybook = kTanachTorah;
    self.theWritingsText = kTorahGenesis;
    self.theChapterNumber = 0;
    self.isMenuShowing = false;
    [self setTextData];
    [self foundationRunSpeech:@[@"Welcome"]];

    [self gestureRecognizerGroup];
}

- (void) gestureRecognizerGroup {
    [self.view addGestureRecognizer:self.edgeLeftPanGesture];
    [self.view addGestureRecognizer:self.edgeRightPanGesture];
    [self.view addGestureRecognizer:self.hideBothMenuGesture];
    
    [self.mainMenuView addGestureRecognizer: self.closeMenuGesture];
    [self.mainChapterView addGestureRecognizer:self.closeChapterGesture];
    
    [self.underNavBarView addGestureRecognizer:self.showNavigationBarGesture];
    
    [self.view addGestureRecognizer:self.nextChapterGesture];
    [self.view addGestureRecognizer:self.previousChapterGesture];

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
    [self initialSetUp];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self performSelector:@selector(menuAnimationOnLoad) withObject:nil afterDelay:0.6];
    self.navigationController.navigationBarHidden = false;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.isNavBarShowing = true;
    [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.6];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//
//
////////
#pragma mark - View Style
////////
//
//

- (void) menuAnimationOnLoad {
    [self showMenu];
    self.menuIsMoving = true;
    self.isMenuShowing = true;
    
    [self showChapter];
    self.chapterIsMoving = true;
    self.isChapterShowing = true;
}

- (void) viewStyleForLoad {
    [self.englishTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.hebrewTextTable setSeparatorInset:UIEdgeInsetsZero];

    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}

















//
//
////////
#pragma mark - Tests
////////
//
//

- (void) testLoadII {
    self.thePrimarybook = kTanachWritings;
    self.theWritingsText = kWritingsIIChronicles;
    
    NSArray* mydata = [self getBilingualData: (kTanachBooks) self.thePrimarybook theText: (TanachAttributeClass*) self.thePrimaryAttribute];
    NSLog(@"title -- %@", [mydata objectAtIndex:0]);
    NSLog(@"title -- %@", [mydata objectAtIndex:1]);
}

- (void) testLoadI {
    //[self setMyTextDataModel];
    
    TanachAttributeClass* theAttribute = [[TanachAttributeClass alloc]init];
    //kTanachBooks theBook = kTanachWritings;
    //theAttribute.writings = kWritingsEzra;
    kTanachBooks theBook = kTanachTorah;
    theAttribute.torah = kTorahNumbers;
    
    NSArray* mydata = [self getBilingualData: (kTanachBooks) theBook theText: (TanachAttributeClass*) theAttribute];
    NSLog(@"title -- %@", [mydata objectAtIndex:0]);
    NSLog(@"title -- %@", [mydata objectAtIndex:1]);
    
}













//
//
////////
#pragma mark - Gesture Setters
////////
//
//

- (UIScreenEdgePanGestureRecognizer *) edgeLeftPanGesture {
    if (!_edgeLeftPanGesture){
        _edgeLeftPanGesture =
        [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(leftEdgeCheck:)];
        [_edgeLeftPanGesture setEdges:UIRectEdgeLeft];
    }
    return _edgeLeftPanGesture;
}

- (void) leftEdgeCheck:(UISwipeGestureRecognizer *)recognizer {
    [self moveMenuAction];
}

- (UIScreenEdgePanGestureRecognizer *) edgeRightPanGesture {
    if (!_edgeRightPanGesture){
        _edgeRightPanGesture =
        [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(rightEdgeCheck:)];
        [_edgeRightPanGesture setEdges:UIRectEdgeRight];
    }
    return _edgeRightPanGesture;
}

- (void) rightEdgeCheck:(UISwipeGestureRecognizer *)recognizer {
    [self moveChapterAction];
}

//
////
//

- (UISwipeGestureRecognizer *) closeMenuGesture {
    if (!_closeMenuGesture){
        _closeMenuGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(closeMenu:)];
        [_closeMenuGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _closeMenuGesture;
}

- (void) closeMenu:(UISwipeGestureRecognizer *)recognizer {
    [self moveMenuAction];
}

- (UISwipeGestureRecognizer *) closeChapterGesture {
    if (!_closeChapterGesture){
        _closeChapterGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(closeChapter:)];
        [_closeChapterGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _closeChapterGesture;
}

- (void) closeChapter:(UISwipeGestureRecognizer *)recognizer {
    [self moveChapterAction];
}

//
////
//

- (UITapGestureRecognizer *) showNavigationBarGesture {
    if (!_showNavigationBarGesture){
        _showNavigationBarGesture =
        [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(showNavBarTap:)];
        [_showNavigationBarGesture setNumberOfTapsRequired:1];
    }
    return _showNavigationBarGesture;
}

- (void) showNavBarTap:(UITapGestureRecognizer*) recognizer{
    [self showNavBar];
}

- (UITapGestureRecognizer *) hideBothMenuGesture {
    if (!_hideBothMenuGesture){
        _hideBothMenuGesture =
        [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(hideMenus:)];
        [_hideBothMenuGesture setNumberOfTapsRequired:2];
    }
    return _hideBothMenuGesture;
}

- (void) hideMenus:(UITapGestureRecognizer*) recognizer{
    [self moveMenuAction];
    [self moveChapterAction];
}

//
////
//

- (UISwipeGestureRecognizer *) nextChapterGesture {
    if (!_nextChapterGesture){
        _nextChapterGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(nextAction:)];
        [_nextChapterGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _nextChapterGesture;
}

- (void) nextAction:(UISwipeGestureRecognizer *)recognizer {
    [self chapterNextAction];
}

- (UISwipeGestureRecognizer *) previousChapterGesture {
    if (!_previousChapterGesture){
        _previousChapterGesture =
        [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(previousAction:)];
        [_previousChapterGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _previousChapterGesture;
}

- (void) previousAction:(UISwipeGestureRecognizer *)recognizer {
    [self chapterPreviousAction];
}




@end
