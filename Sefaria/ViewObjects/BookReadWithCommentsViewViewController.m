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


//
////
//

#import "MainFoundation+ChapterReadActions.h"

@interface BookReadWithCommentsViewViewController ()
{
    bool commentHasBeenClicked;
}

@property (weak, nonatomic) IBOutlet UITableView *hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;

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
//// Cell expand trackers
//

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic,strong) NSIndexPath* currentIndexPath;

@end

@implementation BookReadWithCommentsViewViewController

//@synthesize edgeLeftPanGesture=_edgeLeftPanGesture,edgeRightPanGesture=_edgeRightPanGesture,closeMenuGesture=_closeMenuGesture,showNavigationBarGesture=_showNavigationBarGesture;

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define SMALL_FONT_SIZE 12.0

#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define SMALL_IPAD_FONT [UIFont fontWithName: FONT_NAME size: SMALL_FONT_SIZE]

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]
#define COMMENT_CELL [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath]

#define COMMENT_CELL_RID @"CommentCell"

#define CELL_CONTENT_WIDTH 380.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 40.0
#define TABLE_WIDTH 380.0f

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

- (IBAction)languageChangePress:(UIButton *)sender {
    [self changeLanguageAction];
}

//
////
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
    else if (tableView.tag == COMMENT_TAG){
        return [self.commentArray count] ? [self.commentArray count] : 0;
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        cell = [self setMyCommentCell:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else {
        NSLog(@"Error - Cell");
        return nil;
    }
}


#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]



- (CellWithLeftSideNumberTableViewCell *) setMyCustomHebrewTextCell: (CellWithLeftSideNumberTableViewCell*) cell withString :(NSString *) myString
{
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        cell.textLabel.font = IPAD_FONT_LARGE;
        
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
    else {
        cell.textLabel.text = @"error";
        return cell;
    }
}


//
////
//

- (UITableViewCell *) setMyCommentCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment* myComment = [self.commentArray objectAtIndex:indexPath.row];
    NSString* myString = [self commentTextFromObject:myComment];
    NSString* myInfo = [self commentDetailText : myComment];
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
        cell.textLabel.font = IPAD_FONT;
        if (self.selectedIndex == indexPath.row) {
            cell.textLabel.numberOfLines = 0;
        } else {
            cell.textLabel.numberOfLines = 5;
        }
        self.commentTable.contentInset = UIEdgeInsetsZero;

        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if ([myInfo length]) {
            cell.detailTextLabel.text = myInfo;
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
        return cell;
    }
    else {
        cell.textLabel.text = @"error";
        return cell;
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
        return [self primaryArrayHeight:indexPath];
    } else if (tableView.tag == COMMENT_TAG) {
        if (self.selectedIndex == indexPath.row) {
            CGFloat myheight = [self commentHeight : indexPath];
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
////
//

- (CGFloat) commentHeight : (NSIndexPath *)indexPath {
    CGSize sizeComment;
    NSString* myString;
    if ([self.commentArray count] > indexPath.row) {
        Comment* myComment = [self.commentArray objectAtIndex:indexPath.row];
        myString = [self commentTextFromObject:myComment];
    }
    if ([myString length]) {
        UIFont *myFont = IPAD_FONT;
        sizeComment = [self frameForText: myString sizeWithFont:myFont constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        return sizeComment.height*1.1 + CELL_PADDING;
    }
    else {
        return 55.0;
    }
}

- (CGFloat) primaryArrayHeight : (NSIndexPath *)indexPath{
    CGSize sizeEnglish;
    NSString* myStringEnglish;
    if ([self.primaryDataArray count] > indexPath.row){
        myStringEnglish = [self englishTextFromObject:indexPath];
    }
    if ([myStringEnglish length]){
        sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(TABLE_WIDTH, CGFLOAT_MAX)];
        return sizeEnglish.height+CELL_PADDING;
    }
    else {
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
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == HEBREW_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == COMMENT_TAG) {
        if (self.selectedIndex == -1) {
            LOG NSLog(@"first open");
            self.selectedIndex = indexPath.row;
            self.currentIndexPath = indexPath;
            [self.commentTable beginUpdates];
            [self.commentTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.commentTable endUpdates];
        }
        else if (self.selectedIndex == indexPath.row) {
            LOG NSLog(@"first close");
            self.selectedIndex = -1;
            self.currentIndexPath = nil;
            [self.commentTable beginUpdates];
            [self.commentTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.commentTable endUpdates];
        }
        else if (self.selectedIndex != -1 && self.selectedIndex != indexPath.row) {
            LOG NSLog(@"change index");
            self.selectedIndex = indexPath.row;
            [self.commentTable beginUpdates];
            [self.commentTable reloadRowsAtIndexPaths:@[self.currentIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.commentTable endUpdates];
            self.currentIndexPath = indexPath;
        }
    }
}

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
            
            //
            self.commentArray = [self fetchCommentByTextAndChapter:self.myCurrentTextTitle withChapter:self.theChapterNumber+1 withContext:self.managedObjectContext];
            
            [self hideCommentViewIfEmpty];
            [self.commentTable reloadData];
            //text writer
            mydata = [self fetchTextTitleByTitleAndChapter:myText withChapter : self.theChapterNumber withContext:self.managedObjectContext];
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
    self.myCurrentTextTitle = @"Genesis";
    [self.menuChoiceArray removeAllObjects];
    self.theChapterNumber = 0;
    [self basicDataReload];
    [self.menuTable reloadData];
}

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
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
