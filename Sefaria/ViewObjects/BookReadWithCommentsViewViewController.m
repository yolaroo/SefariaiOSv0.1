//
//  BookReadWithCommentsViewViewController.m
//  Sefaria
//
//  Created by MGM on 8/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookReadWithCommentsViewViewController.h"

#import "MainFoundation+FetchTextLineForReading.h"
#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTheLineText.h"
#import "MainFoundation+FetchTheBookTitle.h"

#import "MainFoundation+MainViewActions.h"
#import "MainFoundation+ChapterReadAnimations.h"
#import "MainFoundation+MenuActions.h"

#import "MainFoundation+CommentStyle.h"
#import "MainFoundation+TableViewStyles.h"

#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"

#import "MainFoundation+GestureActions.h"

#import "CellWithLeftSideNumberTableViewCell.h"

#import "MainFoundation+NavBarButtons.h"

#import "MainFoundation+BookMarkActions.h"


//
////
//

#import "MainFoundation+ChapterReadActions.h"

@interface BookReadWithCommentsViewViewController ()
{
    bool commentHasBeenClicked;
}

@property (weak, nonatomic) IBOutlet UITableView *hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView *englishTextTable;

@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UITableView *chapterTable;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;

@property (weak, nonatomic) IBOutlet UIView *mainMenuView;
@property (weak, nonatomic) IBOutlet UIView *mainChapterView;
@property (weak, nonatomic) IBOutlet UIView *mainCommentView;
@property (weak, nonatomic) IBOutlet UIView *mainHebrewView;

//
////
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
//// BUTTON
//

@property (weak, nonatomic) IBOutlet UIButton *hebrewTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewChapterButton;
@property (weak, nonatomic) IBOutlet UIButton *englishTextButton;
@property (weak, nonatomic) IBOutlet UIButton *englishChapterButton;

//
////
//

@property (weak, nonatomic) IBOutlet UIButton *soundToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkToggleButton;

//
@property (weak, nonatomic) IBOutlet UIButton *bookmarkChapterToggleButton;

//
//// Cell expand trackers
//

@end

@implementation BookReadWithCommentsViewViewController

@synthesize searchNavTextField=_searchNavTextField;

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]
#define COMMENT_CELL [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath]

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400
#define COMMENT_TAG 600

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 246.0f/255.0f green:253.0f/255.0f blue:255.0f/255.0f alpha:0.4f]

//
//
////////
#pragma mark - Button Action
////////
//
//

- (IBAction)bookmarkChapterButtonPress:(UIButton *)sender {
    UIButton* myButton = (UIButton*) sender;
    [self bookMarkChapterPress: (UIButton*) myButton withContext : self.managedObjectContext];
}


//
////
//

- (IBAction)soundToggleButtonPress:(UIButton *)sender {
    [self soundPressAction : self.soundToggleButton];
}

#warning here
- (IBAction)fontTogglePress:(UIButton *)sender {
    NSLog(@"press here");
    [self fontPressAction : self.englishTextTable withHebrewTableView:self.hebrewTextTable];
}

- (IBAction)bookmarkTogglePress:(UIButton *)sender {
    [self bookmarkPressAction : self.bookmarkToggleButton];
}

- (IBAction)navHideTogglePress:(UIButton *)sender {
    [self navHidePressAction];
}

- (BOOL) textFieldShouldReturn : (UITextField *)textField {
    self.theSearchTerm = [textField.text mutableCopy];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
    [self.commentTable reloadData];
    [textField resignFirstResponder];
    return NO;
}


//
////
//

- (IBAction)languageChangePress:(UIButton *)sender {
    [self changeLanguageAction];
}

//
////
//

- (IBAction)navigationShowButtonPress:(UIButton *)sender {
    if (self.self.navHideSet){
        self.navHideSet = !self.navHideSet;
        [self showNavBar];
    }
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
////
//

- (void) changeLanguageAction {
    self.mainHebrewView.hidden = !self.mainHebrewView.hidden;
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
    [self chapterReadBackMenuActionStatus];
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
    else if (tableView.tag == COMMENT_TAG){
        UITableViewCell *cell = COMMENT_CELL;
        Comment* myComment = [self.commentArray objectAtIndex:indexPath.row];
        NSString* myString = [self commentTextFromObject:myComment];
        NSString* myInfo = [self commentDetailText : myComment];
        cell = [self setMyCommentCell:cell cellForRowAtIndexPath:indexPath withSelectedIndex:self.selectedIndex withText:myString withInfo:myInfo];
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
    if (tableView.tag == ENGLISH_TAG || tableView.tag == HEBREW_TAG) {
        return [self dualLanguagetableViewHeight:tableView cellForRowAtIndexPath:indexPath];
    } else if (tableView.tag == COMMENT_TAG) {
        if (self.selectedIndex == indexPath.row) {
            CGFloat myheight = [self commentHeight :tableView withIndexPath : (NSIndexPath *)  indexPath];
            if (myheight >= 150.0) {
                return myheight;
            } else {
                return 150.0;
            }
        } else {
            return 150.0;
        }
    } else{
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
    
    /*
    for (NSIndexPath* MIP in [self.commentTable indexPathsForVisibleRows]) {
        if (MIP.row == self.selectedIndex) {
            LOG NSLog(@"EQUAL");
        }
        else {
            LOG NSLog(@"NOT EQUAL");
            //[self performSelector:@selector(closeCellOnScroll) withObject:nil afterDelay:0.3];
        }
    }
    */
}

/*
- (void) closeCellOnScroll {
    if (self.selectedIndex != -1) {
        //NSInteger oldRow = self.selectedIndex;
        self.selectedIndex = -1;
        [self.commentTable beginUpdates];
        [self.commentTable reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.commentTable endUpdates];
        self.currentIndexPath = nil;
        //[self scrollToLocation:oldRow];
    }
}

- (void) scrollToLocation : (NSInteger) myRow {
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:myRow inSection:0];
    [self.commentTable scrollToRowAtIndexPath:indexPath
                             atScrollPosition:UITableViewScrollPositionTop
                                     animated:YES];
    
}
*/
 
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
    }
    else if (tableView.tag == CHAPTER_TAG) {
        self.theChapterNumber = indexPath.row;
        [self basicDataReload];
        [self theMenuActionComplete];
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
    else if (tableView.tag == COMMENT_TAG) {
        [self commentPressAction : indexPath withcommentTable:self.commentTable];
    }
}

//
////
//

- (void) menuPress:(NSString*)myCellText {
    if (self.isTextLevel) {
        self.myCurrentTextTitle = myCellText;
        self.theChapterNumber = 0;
        self.theChapterMax = [self getChapterCount:myCellText withContext:self.managedObjectContext];
        [self updateTheData];
        
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
    else {
        [self.menuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.menuChoiceArray addObject:myCellText];
        self.menuListArray = [self menuFetchFromClick:myCellText withContext:self.managedObjectContext];
        
        [self updateTheData];
        [self.menuTable reloadData];
    }
}

//
//
////////
#pragma mark - Update the Data
////////
//
//


- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) updateTheData {
    self.primaryDataArray = [self myArraySetter];
    [self bookmarkChapterViewSetter : self.bookmarkChapterToggleButton];

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
            
            //
            self.commentArray = [self fetchCommentByTextAndChapter:self.myCurrentTextTitle withChapter:self.theChapterNumber+1 withContext:self.managedObjectContext];
            
            [self hideCommentViewIfEmpty];
            [self.commentTable reloadData];
            //text writer
            mydata = [self fetchTextTitleByTitleAndChapter:myText withChapter : self.theChapterNumber withContext:self.managedObjectContext];
            
            [self saveReadingPreferences];

        }
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
////
//

- (void) hideCommentViewIfEmpty {
    if ([self.commentArray count] <= 0){
        self.mainCommentView.alpha = 0.1;
    }
    else {
        self.mainCommentView.alpha = 1.0;
        self.mainCommentView.hidden = false;
    }
}

//
////
//

- (void) initialLoad {
    self.menuListArray = [self menuFetchToZero:self.managedObjectContext];
    [self loadingReadingPreferences];
    [self.menuChoiceArray removeAllObjects];
    [self basicDataReload];
    [self.menuTable reloadData];
}

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.commentTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
    [self.commentTable reloadData];
    [self buttonSetter];
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
    self.navigationController.navigationBarHidden = false;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isNavBarShowing = true;
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
    self.selectedIndex = -1;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBarHidden = false;
    [self viewStyleForLoad];
    [self gestureLoader : self.mainMenuView withChapterView:self.mainChapterView];
    
    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
    [self menuAnimationOnLoad : self.mainMenuView withChapterView:self.mainChapterView];
}

- (void) viewStyleForLoad {
    [self.englishTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.hebrewTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.commentTable setSeparatorInset:UIEdgeInsetsZero];

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

@end
