//
//  SearchTextViewController.m
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SearchTextViewController.h"

#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+TableViewStyles.h"

#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+HebrewTextStyles.h"

#import "MainFoundation+FetchTextLineForReading.h"
#import "MainFoundation+FetchTheTextTitle.h"

#import "MainFoundation+SeachTextActions.h"

#import "MainFoundation+SearchStyle.h"

#import "MainFoundation+NavBarButtons.h"

#import "MainFoundation+FetchSearchTitles.h"

#import "Searches+Create.h"

@interface SearchTextViewController ()

#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.3f]

@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView * hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView * searchTextTable;
@property (weak, nonatomic) IBOutlet UITableView * searchResultTextTable;

@property (weak, nonatomic) IBOutlet UIView *mainEnglishView;
@property (weak, nonatomic) IBOutlet UIView *mainHebrewView;
@property (weak, nonatomic) IBOutlet UIView *mainSearchView;


@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *hebrewLabel;

@property (weak, nonatomic) IBOutlet UIButton *searchEnglishButton;
@property (weak, nonatomic) IBOutlet UIButton *searchHebrewButton;


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;


//
////
//


//
////
//

@property (strong,nonatomic) NSString* myTextName;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;

//
////
//

@property (weak, nonatomic) IBOutlet UIButton *searchSelectionTextButton;
@property (weak, nonatomic) IBOutlet UIButton *searchSelectionCommentsButton;

//
////
//

@property (weak, nonatomic) IBOutlet UIButton *soundToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkToggleButton;

@end

@implementation SearchTextViewController

@synthesize searchTextField=_searchTextField;

#define RESET_DELAY 0.3

#define CELL_CONTENT_WIDTH 550.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 60.0

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]

#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define SEARCH_CELL [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath]
#define SEARCH_RESULT_CELL [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath]

#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define SEARCH_TAG 700
#define SEARCH_RESULT_TAG 750

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 242.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f]

#define SELECTED_COLOR [UIColor colorWithRed: 100.0f/255.0f green:200.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

//
//
////////
#pragma mark - Button Press
////////
//
//

- (IBAction)bookmarkTogglePress:(UIButton *)sender {
    [self bookmarkPressAction : self.bookmarkToggleButton];
}

- (IBAction)soundToggleButtonPress:(UIButton *)sender {
    [self soundPressAction : self.soundToggleButton];
}

//
////
//

- (IBAction)selectionChoiceTextPress:(UIButton *)sender {
    [self selectionChoiceTextButtonAction];
}

- (IBAction)selectionChoiceCommentPress:(UIButton *)sender {
    [self selectionChoiceCommentsButtonAction];
}

- (void) selectionChoiceTextButtonAction {
    if (!self.isSelectionComments && self.isSelectionText){
        //
    }
    else {
        self.isSelectionText = !self.isSelectionText;
        [self buttonChoiceViewChange];
    }
}

- (void) selectionChoiceCommentsButtonAction {
    if (self.isSelectionComments && !self.isSelectionText){
        //
    }
    else {
        self.isSelectionComments = !self.isSelectionComments;
        [self buttonChoiceViewChange];
    }
}

- (void) buttonChoiceViewChange {
    if (self.isSelectionText) {
        [self.searchSelectionTextButton setTitleColor: SELECTED_COLOR forState:UIControlStateNormal];
    } else {
        [self.searchSelectionTextButton setTitleColor:  [UIColor darkTextColor] forState:UIControlStateNormal];
    }
    if (self.isSelectionComments) {
        [self.searchSelectionCommentsButton setTitleColor: SELECTED_COLOR forState:UIControlStateNormal];
    } else {
        [self.searchSelectionCommentsButton setTitleColor:  [UIColor darkTextColor] forState:UIControlStateNormal];
    }
}

//
////
//

- (IBAction)searchViewShowHebrew:(UIButton *)sender {
    self.mainSearchView.hidden = true;
    self.mainEnglishView.hidden = true;
    self.mainHebrewView.hidden = false;
}

- (IBAction)searchViewShowEnglish:(UIButton *)sender {
    self.mainSearchView.hidden = true;
    self.mainHebrewView.hidden = true;
    self.mainEnglishView.hidden = false;
}

//
////
//

- (IBAction)englishViewShowHebrew:(UIButton *)sender {
    self.mainEnglishView.hidden = true;
    self.mainSearchView.hidden = true;
    self.mainHebrewView.hidden = false;
}

- (IBAction)englishViewShowSearch:(UIButton *)sender {
    self.mainEnglishView.hidden = true;
    self.mainHebrewView.hidden = true;
    self.mainSearchView.hidden = false;
}

//
////
//

- (IBAction)hebrewViewShowSearch:(UIButton *)sender {
    self.mainHebrewView.hidden = true;
    self.mainEnglishView.hidden = true;
    self.mainSearchView.hidden = false;
}

- (IBAction)hebrewViewShowEnglish:(UIButton *)sender {
    self.mainHebrewView.hidden = true;
    self.mainSearchView.hidden = true;
    self.mainEnglishView.hidden = false;
}

//
//
////////
#pragma mark - Text Field Return
////////
//
//

- (BOOL) textFieldShouldReturn : (UITextField *)textField { // INTERFACE
    if ([textField.text length]) {
        self.theSearchTerm = [textField.text mutableCopy];
        [self createSearchTitle : self.managedObjectContext];
        [self setSearchTitleView];
        [self searchAction];
    }
    [textField resignFirstResponder];
    return NO;
}

- (void) setSearchTitleView {
    [self fetchSearchTitleDataArray : self.managedObjectContext];
    [self.searchResultTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.searchResultTextTable reloadData];
}

//
//
////////
#pragma mark - Table View
////////
//
//

- (NSInteger) numberOfSectionsInTableView : (UITableView *) tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection : (NSInteger) section
{
    return [self tableViewCellNumberForCoreData : tableView numberOfRowsInSection : section];
}

- (UITableViewCell *) tableView : (UITableView *) tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath
{
    if (tableView.tag == ENGLISH_TAG){
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
    else if (tableView.tag == SEARCH_TAG) {
        UITableViewCell *cell = SEARCH_CELL;
        NSString* myString;
        NSString * myInfo;
        if ([self.searchLineDataArray count] >= indexPath.row){
            NSManagedObject* myLineObject = [self.searchLineDataArray objectAtIndex:indexPath.row];
            NSArray* writeData = [self combinedTextSearchLineWrite : myLineObject];
            
            
            myString = [writeData firstObject];
            myInfo = [writeData lastObject];
        }
        else {
            myString = @"error";
            myInfo = @"error";
        }
        
        cell = [self setMySearchTextCell:cell withText:myString withInfo:myInfo];
        return cell;
    }
    else if (tableView.tag == SEARCH_RESULT_TAG) {
        UITableViewCell *cell = SEARCH_RESULT_CELL;
        
        Searches* mySearchTitle = [self.searchTitlesArray objectAtIndex:indexPath.row];
        NSString* searchTitle = mySearchTitle.name;
        if ([searchTitle length]){
            cell.textLabel.text = searchTitle;
        }
        else {
            cell.textLabel.text = @"error";
        }
        return cell;
    }
    return nil;
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
    return [self tableViewHeightForCoreData:tableView cellForRowAtIndexPath:indexPath];
}

//
//
////////
#pragma mark - Table View Select
////////
//
//

- (void) tableView : (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;
        [self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == HEBREW_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == SEARCH_TAG){
        if ([self.theSearchTerm length]){
            NSManagedObject* objectAtIndex = [self.searchLineDataArray objectAtIndex:indexPath.row];
            [self loadReadingData:tableView withIndex:indexPath withManagedObject:objectAtIndex];
        }
    }
    else if (tableView.tag == SEARCH_RESULT_TAG){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString*myCellText = cell.textLabel.text;

        if ([myCellText length]) {
            self.theSearchTerm = [myCellText mutableCopy];
            [self searchFromTableTouch];
        }
    }
}

- (void) searchFromTableTouch {
    [self searchAction];

}

//
//
////////
#pragma mark - Delete
////////
//
//

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == SEARCH_RESULT_TAG) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [tableView beginUpdates];
            [self deleteSearchTitleObject:self.managedObjectContext withIndex:indexPath];
            [tableView endUpdates];
            [self setSearchTitleView];
        }
    }
    else {
        NSLog(@"can't edit");
    }
}

- (void) deleteSearchTitleObject : (NSManagedObjectContext*) context withIndex : (NSIndexPath*) indexPath{
    
    if ([self.searchTitlesArray count] >= indexPath.row){
        Searches* mySearchTitle = [self.searchTitlesArray objectAtIndex:indexPath.row];
        [context deleteObject:mySearchTitle];
        [self saveData:context];
    }
    
}


//
//
////////
#pragma mark - Load Reading Data
////////
//
//

- (void) loadReadingData : (UITableView *)tableView withIndex : (NSIndexPath *)indexPath withManagedObject : (NSManagedObject*) objectAtIndex {
    if ([objectAtIndex isKindOfClass:[LineText class]]){
        LineText* myLineText = [self.searchLineDataArray objectAtIndex:indexPath.row];
        TextTitle* title = myLineText.whatTextTitle;
        
        self.theChapterMax = [title.chapterCount integerValue];
        self.theChapterNumber = [myLineText.chapterNumber integerValue];
        self.myCurrentTextTitle = title.englishName;
        
        [self addBookMarkValueToSearchText:tableView withLineText:myLineText withIndexPath:indexPath withContext:self.managedObjectContext];
        
        [self setReadingDataView];
        [self updateTheData];
    }
}

- (void) setReadingDataView {
    self.searchEnglishButton.hidden = false;
    self.searchHebrewButton.hidden = false;
    [self setLabelsForName];
}

//
//
////////
#pragma mark - Data Set
////////
//
//

- (void) searchAction { // INTERFACE
    [self searchSelectionChoice];
    [self searchViewSetter];
}

- (void) searchViewSetter {
    [self.searchTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    self.mainSearchView.hidden = false;
    self.searchEnglishButton.hidden = true;
    self.searchHebrewButton.hidden = true;
    self.searchLabel.text = @" ";
    [self.searchTextTable reloadData];
}

//
//
////////
#pragma mark - Data Action
////////
//
//

- (void) searchSelectionChoice {
    if (self.isSelectionComments && !self.isSelectionText){
        [self setSearchDataCommentArray];
    }
    else if (!self.isSelectionComments && self.isSelectionText){
        [self setSearchDataTextArray];
    }
    else if (self.isSelectionComments && self.isSelectionText){
        [self setSearchDataCombinedArray];
    }
}

- (void) setSearchDataTextArray {
    self.wordCountLabel.text = [self searchDataSetterForTextOnly : self.theSearchTerm];
}

- (void) setSearchDataCommentArray {
    self.wordCountLabel.text = [self searchDataSetterForCommentsOnly: self.theSearchTerm];
}

- (void) setSearchDataCombinedArray {
    self.wordCountLabel.text = [self searchDataSetterForAllCases: self.theSearchTerm];
}

//
////
//

- (void) setLabelsForName {
    NSString* myString  = [NSString stringWithFormat:@"%@ %d",self.myCurrentTextTitle,self.theChapterNumber+1];
    self.hebrewLabel.text = myString;
    self.englishLabel.text = myString;
    self.searchLabel.text = myString;
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
            self.theChapterMax = [myText.chapterCount integerValue];
            self.chapterListArray = [self chapterNumberArray: self.theChapterMax];
            
            //text writer
            mydata = [self fetchTextTitleByTitleAndChapter:myText withChapter : self.theChapterNumber withContext:self.managedObjectContext];
            
            [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.3];

        }
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void) reloadTableView {
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
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
#pragma mark - Life Cycle
////////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPreferences : self.soundToggleButton];

    self.navigationController.navigationBarHidden = false;
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

- (void) initialLoad {
    [self viewStyleForLoad];
    [self performSelector:@selector(setSearchTitleView) withObject:nil afterDelay:0.3];
    self.searchEnglishButton.hidden = true;
    self.searchHebrewButton.hidden = true;
    self.isSelectionText = true;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}



@end
