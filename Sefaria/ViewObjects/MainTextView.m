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

#import "MainFoundation+ChapterReadAnimations.h"

#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"

#import "MainFoundation+GestureActions.h"

@interface MainTextView  ()

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

#define DK 2
#define LOG if(DK == 1)

#define TORAH_TAG 1000
#define PROPHET_TAG 1001
#define WRITINGS_TAG 1002

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 246.0f/255.0f green:253.0f/255.0f blue:255.0f/255.0f alpha:0.4f]


//
//
////////
#pragma mark - Button Navigation Action
////////
//
//

- (IBAction)navigationShowButtonPress:(UIButton *)sender {
    [self showNavBar];
}

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
    [self updateText];
}

- (void) chapterPreviousAction {
    self.theChapterNumber --;
    [self updateText];
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
    self.chapterListArray = @[];
    [self.menuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self updateMenu];
}
- (void) updateMenu {
    [UIView transitionWithView:self.chapterTable
                      duration:.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ {
                        [self.chapterTable reloadData];
                    }
                    completion:NULL];
    
    [UIView transitionWithView:self.menuTable
                      duration:.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ {
                        [self.menuTable reloadData];
                    }
                    completion:NULL];
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
    else if (tableView.tag == ENGLISH_TAG) {
        return [self.primaryEnglishTextArray count] ? [self.primaryEnglishTextArray count] : 0;
    }
    else if (tableView.tag == HEBREW_TAG) {
        return [self.primaryHebrewTextArray count] ? [self.primaryHebrewTextArray count] : 0;
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
#pragma mark - Cell Color
////////
//
//

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:COLOR_CELL_HIGHLIGHT ForCell:cell]; //highlight color
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor whiteColor] ForCell:cell];  //normal colour
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
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
    if (tableView.tag == MENU_TAG){
        [self tableViewMenuAction:tableView.tag didSelectRowAtIndexPath:indexPath];
    }
    else if (tableView.tag == CHAPTER_TAG) {
        self.theChapterNumber = indexPath.row;
        [self updateText];
        [self theMenuActionComplete];
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

- (void) extraMenuPress {
    self.theChapterNumber = 0;
    [self.chapterTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self updateText];
}

- (void) updateText {
    [self setTextData];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
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

        [self setChapterData];
        [self setTextView];
    }
    else {
        NSLog(@"-- Error : Text Data --");
    }
}

- (void) setChapterData {    
    self.theChapterMax = [[self.primaryDataArray objectAtIndex:4] integerValue];
    self.chapterListArray = [self chapterNumberArray: self.theChapterMax];

    self.chapterTable.alpha = 0.3;
    [UIView transitionWithView:self.chapterTable
                      duration:.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ {
                        self.chapterTable.alpha = 1;
                        [self.chapterTable reloadData];
                    }
                    completion:NULL];
    
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
    self.menuListArray = self.myTanachTextClass.foundationTorah;
    [self viewStyleForLoad];
    
    self.thePrimarybook = kTanachTorah;
    self.theWritingsText = kTorahGenesis;
    self.theChapterNumber = 1;
    self.isMenuShowing = false;
    [self setTextData];
    [self foundationRunSpeech:@[@"Welcome"]];
    [self menuAnimationOnLoad : self.mainMenuView withChapterView:self.mainChapterView];
    
    [self gestureLoader : self.mainMenuView withChapterView:self.mainChapterView];
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
#pragma mark - Gestures
////////
//
//

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


@end
