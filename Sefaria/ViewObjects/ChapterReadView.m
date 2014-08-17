//
//  ChapterReadView.m
//  Sefaria
//
//  Created by MGM on 7/21/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ChapterReadView.h"

#import "MainFoundation+FetchTextLineForReading.h"
#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheLineText.h"
#import "MainFoundation+FetchTheBookTitle.h"

#import "MainFoundation+MainViewActions.h"
#import "MainFoundation+ChapterReadAnimations.h"
#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+MenuActions.h"

//
////
//

#import "MainFoundation+ChapterReadActions.h"

@interface ChapterReadView ()

@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView *hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UITableView *chapterTable;

@property (weak, nonatomic) IBOutlet UIView *mainMenuView;
@property (weak, nonatomic) IBOutlet UIView *mainChapterView;

//
////
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;


//
//// BUTTON
//

@property (weak, nonatomic) IBOutlet UIButton *englishTextButton;
@property (weak, nonatomic) IBOutlet UIButton *englishChapterButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewChapterButton;

//
////
//

@end

@implementation ChapterReadView

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 40.0

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

//
//
////////
#pragma mark - Button Action
////////
//
//

- (IBAction)navigationShowButtonPress:(UIButton *)sender {
    [self showNavBar];
}

//
////
//

- (IBAction)textNameButtonPress:(UIButton *)sender {
    [self moveMenuAction:self.mainMenuView];
    [self moveChapterAction : self.mainChapterView];
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
    [self basicDataReload];
}

- (void) chapterPreviousAction {
    self.theChapterNumber --;
    [self basicDataReload];
}


//
//
////////
#pragma mark - Table BackButton Press
////////
//
//

- (IBAction)menuBackButtonPress:(UIButton *)sender {
    [self menuButtonAction];
}

- (void) menuButtonAction {
    if([self.menuChoiceArray count] >= 1) {
        NSLog(@"Back Action");
        [self backAction];
    }
    else {
        NSLog(@"Empty");
    }
}

- (void) backAction {
    self.isTextLevel = false;
    self.isBookLevel = true;
    self.theChapterNumber = 0;
    self.theChapterMax = 0;
    if([self.menuChoiceArray count] == 1) {
        [self.menuChoiceArray removeLastObject];
        self.menuListArray = [self menuFetchToZero:self.managedObjectContext];
    }
    else {
        [self.menuChoiceArray removeLastObject];
        self.chapterListArray = @[];
        self.menuListArray = [self menuFetchFromClick:[self.menuChoiceArray lastObject] withContext:self.managedObjectContext];
    }
    [self setTextView];
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
    else if (tableView.tag == CHAPTER_TAG) {
        return [self.chapterListArray count] ? [self.chapterListArray count] : 0;
    }
    else if (tableView.tag == ENGLISH_TAG){
        return [self.primaryDataArray count] ? [self.primaryDataArray count] : 0;
    }
    else if (tableView.tag == HEBREW_TAG){
        return [self.primaryDataArray count] ? [self.primaryDataArray count] : 0;
    }
    else {
        NSLog(@"Error on cell load");
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MENU_TAG) {
        UITableViewCell *cell = MENU_CELL;
        NSString* myString = [self objectName : [self.menuListArray objectAtIndex:indexPath.row]];
        cell = [self setMenuCell:cell withString:myString];
        return cell;
    }
    else if (tableView.tag == CHAPTER_TAG) {
        NSString* myString = [self.chapterListArray objectAtIndex:indexPath.row];
        return [self setChapterCell:CHAPTER_CELL withString:myString];
    }
    else if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = ENGLISH_CELL;
        NSString* myString = [self englishTextFromObject:indexPath];
        cell = [self setMyEnglishTextCell:cell withString:myString];
        return cell;
    }
    else if (tableView.tag == HEBREW_TAG) {
        UITableViewCell *cell = HEBREW_CELL;
        NSString* myString = [self hebrewTextFromObject:indexPath];
        cell = [self setMyHebrewTextCell:cell withString:myString];
        return cell;
    }
    else {
        NSLog(@"Error - Cell");
        return nil;
    }
}

//
////
//

- (NSString*) englishTextFromObject:(NSIndexPath *)indexPath {
    if ([self.primaryDataArray count] > indexPath.row){
        LineText*myLine = [self.primaryDataArray objectAtIndex:indexPath.row];
        return myLine.englishText ? myLine.englishText : @"error";
    }
    else {
        NSLog(@"error conversion number");
        return @"error";
    }
}

- (NSString*) hebrewTextFromObject:(NSIndexPath *)indexPath {
    if ([self.primaryDataArray count] > indexPath.row){
        LineText*myLine = [self.primaryDataArray objectAtIndex:indexPath.row];
        return myLine.hebrewText ? myLine.hebrewText : @"error";
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
    if (tableView.tag == ENGLISH_TAG || tableView.tag == HEBREW_TAG) {
        CGSize sizeEnglish;
        NSString* myStringEnglish;
        if ([self.primaryDataArray count] > indexPath.row){
            myStringEnglish = [self englishTextFromObject:indexPath];
        }
        if ([myStringEnglish length]){
            sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
            return sizeEnglish.height+CELL_PADDING;
        }
        else {
            return 55.0;
        }
    }
    else{
        return 55.0;
    }
}

//
//
////////
#pragma mark - TableView Animation Match
////////
//
//

- (void) scrollViewDidScroll : (UIScrollView *)scrollView {
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

- (void) tableView : (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MENU_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;

        [self menuPress:myCellText];
        [self setTextView];
    }
    else if (tableView.tag == CHAPTER_TAG) {
        self.theChapterNumber = indexPath.row;
        [self basicDataReload];
    }
    else if (tableView.tag == ENGLISH_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == HEBREW_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
}

- (void) menuPress:(NSString*)myCellText {
    if (self.isTextLevel) {
        self.myCurrentTextTitle = myCellText;
        self.theChapterNumber = 0;
        
        //chapter number setter
        self.theChapterMax = [self getChapterCount:myCellText withContext:self.managedObjectContext];
        
        //data loader
        [self updateTheData];
    }
    else {
#warning
        [self.menuChoiceArray addObject:myCellText];
        self.menuListArray = [self menuFetchFromClick:myCellText withContext:self.managedObjectContext];
    }
}

//
////
//

- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) updateTheData {
    self.primaryDataArray = [self myArraySetter];
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
        NSArray* mydata;
        if ([self.myCurrentTextTitle length]){
            TextTitle* myText = [[self fetchTextTitleByNameString:self.myCurrentTextTitle withContext:self.managedObjectContext]firstObject];
            
            //label text string setter
            self.viewTitleEnglish = myText.englishName;
            self.viewTitleHebrew = myText.hebrewName;

            //chapter number writer
            self.chapterListArray = [self chapterNumberArray: self.theChapterMax];
            
            //text writer
            mydata = [self fetchTextTitleByTitleAndChapter:myText withChapter : self.theChapterNumber withContext:self.managedObjectContext];
        }
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void) initialLoad {
    self.menuListArray = [self menuFetchToZero:self.managedObjectContext];
#warning (set to random text)
    self.myCurrentTextTitle = @"Genesis";
    [self.menuChoiceArray removeAllObjects];
    self.theChapterNumber = 0;
    [self basicDataReload];
}

- (void) setTextView {
#warning animate needs work!
    [UIView animateWithDuration:0.1
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{

                         self.englishTextTable.alpha = 0.1;
                         self.hebrewTextTable.alpha = 0.1;
                         self.englishTextButton.alpha = 0.1;
                         self.hebrewTextButton.alpha = 0.1;
                         self.englishChapterButton.alpha = 0.1;
                         self.hebrewChapterButton.alpha = 0.1;
                     }
                     completion:^(BOOL finished){

                         [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                         [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                         [self.menuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                         [self.chapterTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

                         [self buttonSetter];
                         [self.menuTable reloadData];
                         [self.chapterTable reloadData];
                         [self.englishTextTable reloadData];
                         [self.hebrewTextTable reloadData];
                         
                         [self secondStageAnimation];
                     }];
}


- (void) secondStageAnimation {
    [UIView animateWithDuration:1.0
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.englishTextTable.alpha = 1.0;
                         self.hebrewTextTable.alpha = 1.0;
                         self.englishTextButton.alpha = 1.0;
                         self.hebrewTextButton.alpha = 1.0;
                         self.englishChapterButton.alpha = 1.0;
                         self.hebrewChapterButton.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                     }];
}


- (void) buttonSetter {
    
    [self.englishTextButton setTitle:self.viewTitleEnglish forState:UIControlStateNormal];
    [self.hebrewTextButton setTitle:self.viewTitleHebrew forState:UIControlStateNormal];
    
    NSString* englishChapterString = [NSString stringWithFormat:@"Chapter %ld",(long)self.theChapterNumber+1];
    
    [self.englishChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
    [self.hebrewChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
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
    
    //[self performSelector:@selector(menuAnimationOnLoad) withObject:nil afterDelay:0.6];
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

- (void) initialSetUp {
    self.navigationController.navigationBarHidden = false;
    [self viewStyleForLoad];
    [self gestureLoader];
    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
    [self menuAnimationOnLoad];
}

- (void) viewStyleForLoad {
    [self.englishTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.hebrewTextTable setSeparatorInset:UIEdgeInsetsZero];
    
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}

- (void) menuAnimationOnLoad {
    [self moveMenuAction:self.mainMenuView];
    self.menuIsMoving = true;
    self.isMenuShowing = true;
    
    [self moveChapterAction:self.mainChapterView];
    self.chapterIsMoving = true;
    self.isChapterShowing = true;
}

//
//
////////
#pragma mark - Gestures
////////
//
//

- (void) gestureLoader {
    [self.myGestureClass gestureRecognizerGroupForMainView:self.view];
    [self.myGestureClass gestureRecognizerGroupForSecondaryGroupA:self.mainChapterView];
    [self.myGestureClass gestureRecognizerGroupForSecondaryGroupB:self.mainMenuView];
    [self bookGestureNotificationLoader];
}

- (void) bookGestureNotificationLoader {
    [self basicNotifications:@"chapterNextAction" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeLeftMain]];
    [self basicNotifications:@"chapterPreviousAction" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeRightMain]];
    
    [self basicNotifications:@"theMenuActionComplete" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureDoubleTapMain]];
    
    [self basicNotifications:@"theMenuBookActionSingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureLeftEdge]];
    [self basicNotifications:@"theChapterActionsingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureRightEdge]];
    
    [self basicNotifications:@"theMenuBookActionSingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeLeftSecondary]];
    [self basicNotifications:@"theChapterActionsingle" withName:[[self.myGestureClass gestureNotificationNames]objectAtIndex:kGestureSwipeRightSecondary]];
}

- (void) theMenuActionComplete {
    [self moveMenuAction : self.mainMenuView];
    [self moveChapterAction : self.mainChapterView];
}

- (void) theMenuBookActionSingle {
    [self moveMenuAction : self.mainMenuView];
}

- (void) theChapterActionsingle {
    [self moveChapterAction : self.mainChapterView];
}

//
//
//////
#pragma mark - Test Data
//////
//
//

- (void) loadTestMishnah {
    NSLog(@"loaded");
    TextTitle* myText = [[self fetchTextTitleByNameString:@"Mishnah Arakhin" withContext:self.managedObjectContext]firstObject];
    NSLog(@"-- MTFF %@ --",myText.englishName);
    NSArray* myArray = [self fetchTextTitleByTitleAndChapter:myText withChapter : (NSInteger) 0 withContext: (NSManagedObjectContext*) self.managedObjectContext];
    for (LineText* MTT in myArray) {
        NSLog(@"-- PLZLOADENG %@--",MTT.englishText);
        NSLog(@"-- PLZLOADHBR %@--",MTT.hebrewText);
        
    }
}

- (void) loadTestTanach {
    NSLog(@"loaded");
    TextTitle* myText = [[self fetchTextTitleByNameString:@"Genesis" withContext:self.managedObjectContext]firstObject];
    NSLog(@"-- MTFF %@ --",myText.englishName);
    NSArray* myArray = [self fetchTextTitleByTitleAndChapter:myText withChapter : (NSInteger) 0 withContext: (NSManagedObjectContext*) self.managedObjectContext];
    for (LineText* MTT in myArray) {
        NSLog(@"-- PLZLOADENG %@--",MTT.englishText);
        NSLog(@"-- PLZLOADHBR %@--",MTT.hebrewText);
        
    }
}

- (void) TestLoadAction {
    //    [self testBookTitleFetch:self.managedObjectContext];
}

@end
