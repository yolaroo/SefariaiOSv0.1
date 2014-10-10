//
//  SingleTableView.m
//  Sefaria
//
//  Created by MGM on 8/26/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SingleTableView.h"
#import "MainFoundation+GestureActions.h"
#import "MainFoundation+FetchTheLineText.h"
#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+MenuActions.h"
#import "MainFoundation+MainViewActions.h"
#import "MainFoundation+BookMarkStyle.h"
#import "CellWithLeftSideNumberTableViewCell.h"
#import "MainFoundation+FetchTextLineForReading.h"
#import "MainFoundation+NavBarButtons.h"
#import "MainFoundation+GestureActions.h"
#import "MainFoundation+BookMarkActions.h"
#import <objc/message.h>

@interface SingleTableView ()

//
//// STYLE COLLECTION
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView * hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView * bookmarkTable;
@property (weak, nonatomic) IBOutlet UITableView * bookmarkChapterTable;

@property (weak, nonatomic) IBOutlet UITableView * chapterTextTable;

@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UITableView *chapterTable;

//
////
//

@property (weak, nonatomic) IBOutlet UIButton *bookmarkChoiceSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *chapterChoiceSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *textChoiceSelectionButton;

@property (weak, nonatomic) IBOutlet UIButton *hebrewLanguageSelection;


@property (weak, nonatomic) IBOutlet UIButton *readingLanguageSelectionButton;
@property (weak, nonatomic) IBOutlet UILabel *readingChapterLabel;

//
@property (weak, nonatomic) IBOutlet UIButton *soundToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkToggleButton;

@end

@implementation SingleTableView

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400
#define BOOKMARK_TAG 800
#define BOOKMARK_CHAPTER_TAG 900

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]
#define BOOKMARK_CELL [tableView dequeueReusableCellWithIdentifier:@"BookmarkCell" forIndexPath:indexPath]
#define BOOKMARK_CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"BookmarkChapterCell" forIndexPath:indexPath]

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 242.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f]

#define SELECTED_COLOR [UIColor colorWithRed: 100.0f/255.0f green:200.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

#define isDeviceIPhone UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone


//
//
////////
#pragma mark - Empty Gesture
////////
//
//

- (void) chapterNextAction {
}

- (void) chapterPreviousAction {
}

- (void) theMenuActionComplete {
}

- (void) theMenuBookActionSingle {
}

- (void) theChapterActionsingle {
}

//
//
////////
#pragma mark - Button
////////
//
//

- (IBAction)soundToggleButtonPress:(UIButton *)sender {
    [self soundPressAction : self.soundToggleButton];
}

- (IBAction)bookmarkTogglePress:(UIButton *)sender {
    [self bookmarkPressAction : self.bookmarkToggleButton];
}

//
////
//

- (IBAction)readingLanguageSelectionButtonPress:(UIButton *)sender {
    [self setCurrentTextChoiceView];
}

- (void) setCurrentTextChoiceView {
    if (!self.englishTextTable.hidden) {
        self.hebrewTextTable.hidden = false;
        self.englishTextTable.hidden = true;
        [self.readingLanguageSelectionButton setTitle:@"A" forState:UIControlStateNormal];
    }
    else {
        self.hebrewTextTable.hidden = true;
        self.englishTextTable.hidden = false;
        [self.readingLanguageSelectionButton setTitle:@"א" forState:UIControlStateNormal];
    }
}

//
////
//

- (IBAction)hebrewLanguageChoiceButtonPress:(UIButton *)sender {
    [self hebrewLanguageChoiceAction];

}

- (void) hebrewLanguageChoiceAction {
    self.isSingleViewEnglish = !self.isSingleViewEnglish;
    [self singleViewLanguageButtonSet];
}

- (void) singleViewLanguageButtonSet {
    if (self.isSingleViewEnglish) {
        [self.hebrewLanguageSelection setTitle:@"א" forState:UIControlStateNormal];
    }
    else {
        [self.hebrewLanguageSelection setTitle:@"A" forState:UIControlStateNormal];
    }
    [self.bookmarkTable reloadData];
}

//
////
//

//isSingleViewEnglish


- (IBAction)bookmarkSelectionButtonPress:(UIButton *)sender {
    [self bookmarkSelectionAction];
}

- (IBAction)chapterSelectionButtonPress:(UIButton *)sender {
    [self chapterBookmarkSelectionAction];
}

- (IBAction)textSelectionButtonPress:(UIButton *)sender {
    [self textSelectionAction];
}

- (void) bookmarkSelectionAction {
    self.hebrewLanguageSelection.hidden = false;
    self.bookmarkChapterTable.hidden = true;
    self.bookmarkTable.hidden = false;
    self.readingChapterLabel.hidden = true;
    self.readingLanguageSelectionButton.hidden = true;
}

- (void) chapterBookmarkSelectionAction {
    self.hebrewLanguageSelection.hidden = true;
    self.bookmarkChapterTable.hidden = false;
    self.bookmarkTable.hidden = true;
    self.readingChapterLabel.hidden = true;
    self.readingLanguageSelectionButton.hidden = true;
}

- (void) textSelectionAction {
    
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
    return [self tableViewCellNumberForCoreData:tableView numberOfRowsInSection:section];
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
        cell.accessoryView = [self labelForNumberRightSide:indexPath.row withCell:cell];
        return cell;
    }
    else if (tableView.tag == HEBREW_TAG) {
        CellWithLeftSideNumberTableViewCell *cell = HEBREW_CELL;
        NSString* myString = [self hebrewTextFromObject:indexPath];
        cell = [self setMyCustomHebrewTextCell:cell withString:myString];
        cell.tag = indexPath.row;
        return cell;
    }
    else if (tableView.tag == BOOKMARK_TAG) {
        UITableViewCell *cell = BOOKMARK_CELL;
        NSString* myString = [self bookmarkTextFromObject:indexPath];
        NSString* myDetail = [self bookmarkDetailFromObject:indexPath];
        cell = [self setMyBookmarkTextCell:cell withString:myString withDetailText : myDetail];
        return cell;
    }
    else if (tableView.tag == BOOKMARK_CHAPTER_TAG) {
        UITableViewCell *cell = BOOKMARK_CHAPTER_CELL;
        NSString* myString = [self bookmarkChapterTextFromObject:indexPath];
        cell = [self setMyBookmarkChapterTextCell:cell withString:myString];
        return cell;
    }
    else {
        NSLog(@"Error - Cell");
        return nil;
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
    //return 200;
    return [self tableViewHeightForCoreData:tableView cellForRowAtIndexPath:indexPath];
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == BOOKMARK_TAG || tableView.tag == BOOKMARK_CHAPTER_TAG) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == BOOKMARK_TAG) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [tableView beginUpdates];
            LineText*myLine = [self.bookmarkArray objectAtIndex:indexPath.row];
            myLine.isBookmarked = [NSNumber numberWithBool:false];

            [self saveData : self.managedObjectContext];
            [tableView endUpdates];

            [self basicDataReload];
            [self.bookmarkTable reloadData];
        }
    }
    if (tableView.tag == BOOKMARK_CHAPTER_TAG) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [tableView beginUpdates];
            
            LineText*myLine = [self.bookmarkChapterArray objectAtIndex:indexPath.row];
            myLine.isBookmarkedChapter = [NSNumber numberWithBool:false];
            
            [self saveData : self.managedObjectContext];
            [tableView endUpdates];
            
            [self basicDataReload];
            [self.bookmarkTable reloadData];
        }
    } else {
        NSLog(@"can't edit");
    }
}

//
//
////////
#pragma mark - Table Press
////////
//
//

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath : (NSIndexPath *) indexPath
{
    if (tableView.tag == MENU_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self menuPress:myCellText];
    }
    else if (tableView.tag == CHAPTER_TAG) {
        //self.theChapterNumber = indexPath.row;
        //[self basicDataReload];
        //[self theMenuActionComplete];
    }
    else if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;
        [self foundationRunSpeech:@[myCellText]];
        [self addBookMarkValueToLineText :tableView withIndexPath:indexPath withContext:self.managedObjectContext];
    }
    else if (tableView.tag == HEBREW_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
        [self addBookMarkValueToLineText :tableView withIndexPath:indexPath withContext:self.managedObjectContext];
    }
    else if (tableView.tag == BOOKMARK_TAG){
        [self dataFetchForBookmarkPress : indexPath];
    }
    else if (tableView.tag == BOOKMARK_CHAPTER_TAG){
        [self dataFetchForBookmarkChapterPress : indexPath];
    }
}

- (void) dataFetchForBookmarkChapterPress : (NSIndexPath*) indexPath {
    if ([self.bookmarkChapterArray count] >= indexPath.row) {
        LineText* myLine = [self.bookmarkChapterArray objectAtIndex:indexPath.row];
        self.myCurrentTextTitle = myLine.whatTextTitle.englishName;
        self.theChapterNumber = [myLine.chapterNumber integerValue];
        [self selectionDataReload];
    }
}

- (void) dataFetchForBookmarkPress : (NSIndexPath*) indexPath {
    if ([self.bookmarkArray count] >= indexPath.row) {
        LineText* myLine = [self.bookmarkArray objectAtIndex:indexPath.row];
        self.myCurrentTextTitle = myLine.whatTextTitle.englishName;
        self.theChapterNumber = [myLine.chapterNumber integerValue];
        [self selectionDataReload];
    }
}

//
//
////////
#pragma mark - Text Data Loader
////////
//
//

- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) selectionDataReload {
    [self updateReadingData];
    [self setSelectionTextView];
}

- (void) updateTheData {
    self.bookmarkArray = [self myArraySetter];
    self.bookmarkChapterArray = [self mySecondaryArraySetter];
}

- (void) updateReadingData {
    self.primaryDataArray  = [self myPrimaryChapterTextArraySetter];
}

//
//
////////
#pragma mark - Set Text View
////////
//
//

- (void) setSelectionTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(30, 0, 1, 1) animated:NO];
    [self.englishTextTable reloadData];

    [self.hebrewTextTable scrollRectToVisible:CGRectMake(30, 0, 1, 1) animated:NO];
    [self.hebrewTextTable reloadData];
    
    self.bookmarkChapterTable.hidden=true;
    self.bookmarkTable.hidden=true;
    [self showReadingText];
    [self setReadingChapterInfo];
}

- (void) showReadingText {
    if (self.isSingleViewEnglish){
        self.englishTextTable.hidden = false;
        self.hebrewTextTable.hidden = true;
    }
    else {
        self.englishTextTable.hidden = true;
        self.hebrewTextTable.hidden = false;
    }
}

- (void) setReadingChapterInfo {
    self.readingChapterLabel.hidden = false;
    self.readingLanguageSelectionButton.hidden = false;
    self.hebrewLanguageSelection.hidden = true;

    if ([self.myCurrentTextTitle length]) {
        self.readingChapterLabel.text = [NSString stringWithFormat:@"%@  Chapter %ld", self.myCurrentTextTitle, (long)self.theChapterNumber+1];
    }
}

- (void) setTextView {
    [self.bookmarkTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.bookmarkChapterTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

    [self.bookmarkTable reloadData];
    [self.bookmarkChapterTable reloadData];
    //[self buttonSetter];
}

//
//
////////
#pragma mark - Text Data
////////
//
//

- (NSArray*) myPrimaryChapterTextArraySetter {
    @try {
        NSArray* mydata = [self fetchChapterTextByName:self.myCurrentTextTitle withChapterNumber:self.theChapterNumber withContext:self.managedObjectContext];
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (NSArray*) mySecondaryArraySetter {
    @try {
        NSArray* mydata;
        mydata = [self fetchAllBookMarkedChapterLineText:self.managedObjectContext];
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (NSArray*) myArraySetter {
    @try {
        NSArray* mydata;
        
            //text data
         mydata = [self fetchAllBookMarkedLineText : self.managedObjectContext];
         //NSLog(@"-- MDA %@ --",mydata);
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
//
////////
#pragma mark - Life cycle
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
    [self portraitLock];
    [self flipScreenPortrait];
    [self loadPreferences : self.soundToggleButton];

    //[self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.6];
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
    // get first data
    //[self menuAnimationOnLoad : self.mainMenuView withChapterView:self.mainChapterView];
    [self noMenuGesture];
    [self viewStyleForLoad];
    self.readingChapterLabel.hidden = true;
    self.readingLanguageSelectionButton.hidden = true;
    [self performSelector:@selector(basicDataReload) withObject:nil afterDelay:0.3];
}

- (void) viewStyleForLoad {
    //[self.englishTextTable setSeparatorInset:UIEdgeInsetsZero];
    //[self.hebrewTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.bookmarkTable setSeparatorInset:UIEdgeInsetsZero];
    self.automaticallyAdjustsScrollViewInsets = NO;

    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}


@end
