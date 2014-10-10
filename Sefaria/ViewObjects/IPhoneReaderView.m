//
//  IPhoneReaderView.m
//  Sefaria
//
//  Created by MGM on 9/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "IPhoneReaderView.h"

#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"

#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+CommentStyle.h"

#import "MainFoundation+MenuActions.h"
#import "MainFoundation+ChapterReadActions.h"
#import "MainFoundation+MainViewActions.h"
#import "MainFoundation+FetchTheTextTitle.h"
#import "MainFoundation+FetchTextLineForReading.h"
#import "MainFoundation+GestureActions.h"
#import "MainFoundation+ChapterReadAnimations.h"

#import "CellWithLeftSideNumberTableViewCell.h"
#import "MainFoundation+NavBarButtons.h"
#import "MainFoundation+BookMarkActions.h"

@interface IPhoneReaderView ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UIScrollView *mainViewContainer;

//tables
@property (weak, nonatomic) IBOutlet UITableView * smallMenuTable;
@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView * hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView * commentTable;

//views
@property (weak, nonatomic) IBOutlet UIView *mainHebrewView;
@property (weak, nonatomic) IBOutlet UIView *mainEnglishView;
@property (weak, nonatomic) IBOutlet UIView *mainSmallMenuView;
@property (weak, nonatomic) IBOutlet UIView *mainCommentView;

//buttons
@property (weak, nonatomic) IBOutlet UIButton *englishTextButton;
@property (weak, nonatomic) IBOutlet UIButton *englishChapterButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewChapterButton;

//
@property (weak, nonatomic) IBOutlet UIButton *englishLanguageSelection;
@property (weak, nonatomic) IBOutlet UIButton *hebrewLanguageSelection;
@property (weak, nonatomic) IBOutlet UIButton *commentLanguageSelection;

//
@property (weak, nonatomic) IBOutlet UIButton *soundToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkChapterToggleButton;
//

@end

@implementation IPhoneReaderView

@synthesize searchNavTextField=_searchNavTextField;

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]
#define SMALL_MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"SmallMenuCell" forIndexPath:indexPath]
#define COMMENT_CELL [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath]

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400
#define SMALL_MENU_TAG 1100
#define COMMENT_TAG 600

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 242.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f]

#define MENU_COLOR_CELL [UIColor colorWithRed: 224.0f/255.0f green:226.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

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

- (IBAction)soundToggleButtonPress:(UIButton *)sender {
    [self soundPressAction : self.soundToggleButton];
}

- (IBAction)bookmarkTogglePress:(UIButton *)sender {
    [self bookmarkPressAction : self.bookmarkToggleButton];
}

- (BOOL) textFieldShouldReturn : (UITextField *)textField {
    self.theSearchTerm = [textField.text mutableCopy];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
    [textField resignFirstResponder];
    return NO;
}

//
//
////////
#pragma mark - Language Button Press
////////
//
//

- (IBAction)englishLanguageSelectionButtonPress:(UIButton *)sender {
    [self englishLanguageAction];
}

- (IBAction)hebrewLanguageSelectionButtonPress:(UIButton *)sender {
    [self hebrewLanguageAction];
}

- (IBAction)commentLanguageSelectionButtonPress:(UIButton *)sender {
    [self commentLanguageAction];
}

//
////
//

- (void) hebrewLanguageAction {
    self.mainHebrewView.hidden = false;
    self.mainEnglishView.hidden = true;
    self.mainCommentView.hidden = true;
}

- (void) englishLanguageAction {
    self.mainHebrewView.hidden = true;
    self.mainEnglishView.hidden = false;
    self.mainCommentView.hidden = true;
}

- (void) commentLanguageAction {
    self.mainHebrewView.hidden = true;
    self.mainEnglishView.hidden = true;
    self.mainCommentView.hidden = false;
}

//
////
//

- (IBAction)textNameButtonPress:(UIButton *)sender {
    [self moveSmallMenuAction:self.mainSmallMenuView];
}

- (IBAction)ChapterButtonPress:(UIButton *)sender {
    [self chapterNextAction];
}

//
//
////////
#pragma mark - Gesture Control
////////
//
//

- (void) chapterNextAction {
    self.theChapterNumber ++;
    [self basicDataReload];
}

- (void) chapterPreviousAction {
    self.theChapterNumber --;
    [self basicDataReload];
}

- (void) theMenuActionComplete {
    [self moveSmallMenuAction:self.mainSmallMenuView];
}

- (void) theMenuBookActionSingle {
    [self moveSmallMenuAction:self.mainSmallMenuView];
}

- (void) theChapterActionsingle {
    [self moveSmallMenuAction:self.mainSmallMenuView];
}

//
//
////////
#pragma mark - Menu Table BackButton Press
////////
//
//

- (IBAction)menuBackButtonPress:(UIButton *)sender {
    [self menuButtonAction];
}

- (void) menuButtonAction {
    if([self.menuChoiceArray count] >= 1) {
        [self backAction];
    }
    else {
        //NSLog(@"Empty Pass");
    }
}

- (void) backAction {
    [self smallChapterMenuReadBackMenuActionStatus];
    [self.smallMenuTable reloadData];
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
    if (tableView.tag == SMALL_MENU_TAG) {
        UITableViewCell *cell = SMALL_MENU_CELL;
        NSString* myString = [ self dualMenuObjectToString : @[ [self.fullMenuArray objectAtIndex:indexPath.row] ] ];
        cell = [self setMenuCell:cell withString:myString];
        //cell.textLabel.backgroundColor = MENU_COLOR_CELL;//[UIColor clearColor];
        return cell;
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
#pragma mark - Table Height
////////
//
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
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
#pragma mark - Cell Color
////////
//
//

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == SMALL_MENU_TAG) {
    }
    else {
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [self setCellColor:COLOR_CELL_HIGHLIGHT ForCell:cell]; //highlight color
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == SMALL_MENU_TAG) {
    }
    else {
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [self setCellColor:[UIColor whiteColor] ForCell:cell];  //normal colour
    }
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
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
    if (tableView.tag == SMALL_MENU_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;
        [self menuPress:myCellText withIndex : indexPath];
    }
    else if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;
        [self foundationRunSpeech:@[myCellText]];
        [self addBookMarkValueToLineText :tableView withIndexPath:indexPath withContext:self.managedObjectContext];
    }
    else if (tableView.tag == HEBREW_TAG){
        [self addBookMarkValueToLineText :tableView withIndexPath:indexPath withContext:self.managedObjectContext];
    }
}

//
//
////////
#pragma mark - Menu Press in Text Choice
////////
//
//

- (void) menuPress:(NSString*) myCellText withIndex : (NSIndexPath*) indexPath {
    if (self.isTextLevel) {
        if (self.isChapterLevel) { // choice
            self.theChapterNumber = indexPath.row;
            [self basicDataReload];
            [self moveSmallMenuAction:self.mainSmallMenuView];
        }
        else {
            self.myCurrentTextTitle = myCellText;
            self.theChapterNumber = 0;
            [self.smallMenuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
            self.theChapterMax = [self getChapterCount:myCellText withContext:self.managedObjectContext];
            
            self.fullMenuArray = [self chapterNumberArray: self.theChapterMax];
            [self.smallMenuTable reloadData];
            self.isChapterLevel = true;
        }
    }
    else {
        [self.smallMenuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.menuChoiceArray addObject:myCellText];
        self.fullMenuArray = [self menuFetchFromClick:myCellText withContext:self.managedObjectContext];
        
        self.isChapterLevel = false;
        [self.smallMenuTable reloadData];
    }
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
            
            //text writer
            mydata = [self fetchTextTitleByTitleAndChapter:myText withChapter : self.theChapterNumber withContext:self.managedObjectContext];
            
            NSArray* commentArray;
            @try {
                commentArray =[self fetchCommentByTextAndChapter:self.myCurrentTextTitle withChapter:self.theChapterNumber+1 withContext:self.managedObjectContext];
            }
            @catch (NSException *exception) {
                NSLog(@"error in comment- %@",exception);
            }
            @finally {
                self.commentArray = commentArray;
            }
            [self saveReadingPreferences];
        }
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
//
////////
#pragma mark - Data Set
////////
//
//

- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) updateTheData {
    self.primaryDataArray = [self myArraySetter];
}

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
    [self.commentTable reloadData];

    [self iPhonebuttonSetter];
}

- (void) iPhonebuttonSetter {
    [self.englishTextButton setTitle:self.viewTitleEnglish forState:UIControlStateNormal];
    [self.hebrewTextButton setTitle:self.viewTitleHebrew forState:UIControlStateNormal];
    
    NSString* combinedStringForChapter = [NSString stringWithFormat:@"Chapter %ld",(long)self.theChapterNumber + 1];
    
    [self.hebrewChapterButton setTitle:combinedStringForChapter forState:UIControlStateNormal];
    [self.englishChapterButton setTitle:combinedStringForChapter forState:UIControlStateNormal];

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

    [self portraitLock];
    [self flipScreenPortrait];

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

- (void ) initialLoad {
    self.fullMenuArray = [self menuFetchToZero:self.managedObjectContext];
    
    [self loadingReadingPreferences];
    [self basicDataReload];
    
    [self.smallMenuTable reloadData];
    [self.menuChoiceArray removeAllObjects];
    
    self.mainViewContainer.contentSize =  CGSizeMake(self.mainViewContainer.frame.size.width,self.mainViewContainer.frame.size.height*1.01) ;

//    self.mainViewContainer
    
}

- (void) initialSetUp {
    
    self.navigationController.navigationBarHidden = false;
    [self viewStyleForLoad];

    self.menuIsMoving = false;
    self.isMenuShowing = true;

    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
    //[self menuAnimationOnLoad : self.mainMenuView withChapterView:self.mainChapterView];
    [self iphoneGestureLoader : self.mainSmallMenuView];
}

- (void) viewStyleForLoad {
    [self.englishTextTable setSeparatorInset:UIEdgeInsetsZero];
    [self.hebrewTextTable setSeparatorInset:UIEdgeInsetsZero];
    
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}



@end
