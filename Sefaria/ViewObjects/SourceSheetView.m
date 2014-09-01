//
//  SourceSheetView.m
//  Sefaria
//
//  Created by MGM on 8/28/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SourceSheetView.h"

#import "UIScrollViewWithTouch.h"

#import "MainFoundation+TableViewStyles.h"

#import "MainFoundation+TableViewStyles.h"

#import "MainFoundation+ChapterAndMenuTextStyles.h"

#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+SearchStyle.h"

#import "MainFoundation+MenuActions.h"

#import "MainFoundation+ChapterReadActions.h"

#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+FetchTheTextTitle.h"

#import "MainFoundation+FetchTextLineForReading.h"

#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+SourceSheetStyle.h"

#import "MainFoundation+SourceSheetCoreDataAction.h"

#import "MainFoundation+SeachTextActions.h"


#import "TitleGroupUIView.h"
@class TitleGroupUIView;

#import "LineTextGroupUIView.h"
@class LineTextGroupUIView;

#import "CommentTextUIView.h"
@class  CommentTextUIView;

#import "SourceSheetObject.h"
@class SourceSheetObject;

@interface SourceSheetView ()

//
////
//

@property (strong,nonatomic) SourceSheetObject* mySourceSheet;

//
////
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
////
//

@property (weak, nonatomic) IBOutlet UIScrollViewWithTouch *sourceSheetScrollView;

@property (weak, nonatomic) IBOutlet UITableView * smallMenuTable;
@property (weak, nonatomic) IBOutlet UITableView * englishTextTable;
@property (weak, nonatomic) IBOutlet UITableView *hebrewTextTable;
@property (weak, nonatomic) IBOutlet UITableView *searchTextTable;

@property (weak, nonatomic) IBOutlet UIButton *languageSelectionButton;
@property (nonatomic) bool commentFrameHasMoved;
@property (nonatomic) bool titleFrameHasMoved;


@property (strong,nonatomic) LineText* myLineText;

//
////
//

@property (weak, nonatomic) IBOutlet UIView *menuInputBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *titleInputBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *commentInputBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *searchInputBackgroundView;

//
////
//

@end

@implementation SourceSheetView

@synthesize myLineText=_myLineText,titleTextField = _titleTextField,titleTextView = _titleTextView,commentTextView=_commentTextView,searchTextField=_searchTextField;

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400
#define BOOKMARK_TAG 800
#define BOOKMARK_CHAPTER_TAG 900
#define SMALL_MENU_TAG 1100

#define SEARCH_TEXT_VIEW 1300
#define SEARCH_TAG 700

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]
#define BOOKMARK_CELL [tableView dequeueReusableCellWithIdentifier:@"BookmarkCell" forIndexPath:indexPath]
#define BOOKMARK_CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"BookmarkChapterCell" forIndexPath:indexPath]
#define SEARCH_CELL [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath]
#define SMALL_MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"SmallMenuCell" forIndexPath:indexPath]

#define COLOR_CELL_HIGHLIGHT [UIColor colorWithRed: 242.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f]

#define TEXT_VIEW_MOVE 150

#define TAG_BASE 20000


//
//
////////
#pragma mark - Save Sheet
////////
//
//

- (IBAction)saveSheetButtonPress:(UIButton *)sender {
    if ([self contentCheck]){
        [self mainSourceSheetSaveToCoreDataAction];
    }
}

- (bool) contentCheck {
    if ([self.mySourceSheet.dataArray count]>1 && self.mySourceSheet.titleString && self.mySourceSheet.subTitleString){
        return true;
    }
    return false;
}

- (void) mainSourceSheetSaveToCoreDataAction { //INTERFACE
   
    // create object
    // create data

    NSLog(@"attempt at source CD ");
    [self createSourceSheetCoreDataObject:self.mySourceSheet withContext:self.managedObjectContext];
    //[self testFetchSourceSheetwithContext:self.managedObjectContext];
    [self performSelector:@selector(cleanSourceSheet) withObject:nil afterDelay:RESET_DELAY];

}

- (void) cleanSourceSheet {
    [self.mySourceSheet.dataArray removeAllObjects];
    self.mySourceSheet.titleString = nil;
    self.mySourceSheet.subTitleString = nil;
    self.titleTextField.text = @"";
    self.titleTextView.text = @"";
    self.commentTextView.text = @"";
    self.searchTextField.text = @"";
    
    [self cleanView];
}

//
////
//

- (void) saveCommentDataAction { //INTERFACE
    [self.mySourceSheet.dataArray addObject:self.mySourceSheet.commentString];
    [self drawSheet];
}

- (void) saveTitle { //INTERFACE
    [self drawSheet];
}

- (void) lineBuildDataAddAction { //INTERFACE
    [self.mySourceSheet.dataArray addObject:self.myLineText];
    [self drawSheet];
}

//
////
//

- (void) drawSheet {
    [self cleanView];
    
    //size
    self.mySourceSheet.theWidth = self.sourceSheetScrollView.frame.size.width;
    self.mySourceSheet.completeHeight = 0;

    //title
    if ([self.mySourceSheet.titleString length] && [self.mySourceSheet.subTitleString length]){
        [self.mySourceSheet titleBuild : self.sourceSheetScrollView];
        [self.sourceSheetScrollView addSubview:self.mySourceSheet.thetitle];
    }
    
    //lineText
    if ([self.mySourceSheet.dataArray count]>0) {
        [self buildLineTextObject];
        [self addLineTextToSubview];
    }
    self.sourceSheetScrollView.contentSize =  CGSizeMake(self.sourceSheetScrollView.frame.size.width,self.mySourceSheet.completeHeight*1.1) ;
}

//
////
//

- (void) addLineTextToSubview {
    for (id MOBJ in self.mySourceSheet.contentArray) {
        //NSLog(@"-- my id %@ --",MOBJ);
        [self.sourceSheetScrollView addSubview:MOBJ];
    }
}

- (void) buildLineTextObject {
    [self.mySourceSheet.contentArray removeAllObjects];
    
    NSInteger sourceSheetDepth = 1;
    for (id MYID in self.mySourceSheet.dataArray) {
        if ([MYID isKindOfClass:[LineText class]]) { // add lineText
            [self.mySourceSheet setLineTextObjectView : self.mySourceSheet.completeHeight withLineText:MYID withDepth : sourceSheetDepth withScrollView:self.sourceSheetScrollView];
            sourceSheetDepth ++;
        }
        else if ([MYID isKindOfClass:[NSString class]]) { // add comment
            [self.mySourceSheet setCommentTextObjectView:self.mySourceSheet.completeHeight withCommentText:MYID withDepth : sourceSheetDepth withScrollView:self.sourceSheetScrollView];
            sourceSheetDepth ++;
        }
    }
}

//
////
//

- (void) cleanView {
    NSArray *viewsToRemove = [self.sourceSheetScrollView subviews];
    for (UIView *VWS in viewsToRemove) {
        [VWS removeFromSuperview];
    }
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
    UIView* viewYouWishToObtain = [self.view hitTest:locationPoint withEvent:event];
    NSLog(@"-- touch tag %d --",viewYouWishToObtain.tag);
}
*/

//
//
////////
#pragma mark - Textfield Return
////////
//
//

- (IBAction) titleSaveButtonPress:(UIButton *)sender {
    NSLog(@"pressed");
    if ([self.mySourceSheet.subTitleString length] && [self.mySourceSheet.titleString length]){
        [self saveTitle];
    }
    else {
        NSLog(@"not entered");
    }
}

//
////
//

- (void) searchResultAction {
    [self combinedTextSearch : self.theSearchTerm];
    [self.searchTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.searchTextTable reloadData];
}

- (BOOL) textFieldShouldReturn : (UITextField *) textField {
    if ([textField.text length]) {
        if (textField.tag == SEARCH_TEXT_VIEW) {
            if ([textField.text length]){
                NSLog(@"search text return");
                self.theSearchTerm = [textField.text mutableCopy];
                [self searchResultAction];
            }
        }
        else {
            self.mySourceSheet.titleString = textField.text;
        }
    }
    [textField resignFirstResponder];
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"started !!");
    [self moveCommentTextViewUp];
    [self moveSubtitleTextViewUp];
}

/*
- (BOOL) textView : (UITextView *) textView shouldChangeTextInRange : (NSRange)range replacementText : (NSString *) text {
    if([text isEqualToString:@"\n"])
    {
        if (textView.tag == 2600) {
            self.mySourceSheet.subTitleString = textView.text;
        }
        else if (textView.tag == 2500) {
            self.mySourceSheet.commentString = textView.text;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
*/

-(void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"ended !!");
    if (textView.tag == 2600) {
        self.mySourceSheet.subTitleString = textView.text;
    }
    else if (textView.tag == 2500) {
        self.mySourceSheet.commentString = textView.text;
    }
    [self moveCommentTextViewDown];
    [self moveSubtitleTextViewDown];
    
}

//
//
////////
#pragma mark - Bottom Title Button Choice
////////
//
//

- (IBAction)titleBarButtonPress:(UIButton *)sender {
    [self titleBarAction];
}

- (IBAction)textBarButtonPress:(UIButton *)sender {
    [self textBarAction];
}

- (IBAction)searchBarButtonSearch:(UIButton *)sender {
    [self searchBarAction];
}

- (IBAction)commentBarButtonPress:(UIButton *)sender {
    [self commentBarAction];
}

//
////
//

- (void) titleBarAction {
    [self moveCommentTextViewDown];
    self.titleInputBackgroundView.hidden=false;
    self.menuInputBackgroundView.hidden=true;
    self.commentInputBackgroundView.hidden=true;
    self.searchInputBackgroundView.hidden=true;
}

- (void) textBarAction {
    [self moveCommentTextViewDown];
    [self moveSubtitleTextViewDown];
    self.menuInputBackgroundView.hidden=false;
    self.titleInputBackgroundView.hidden=true;
    self.commentInputBackgroundView.hidden=true;
    self.searchInputBackgroundView.hidden=true;

}

- (void) searchBarAction {
    [self moveCommentTextViewDown];
    [self moveSubtitleTextViewDown];
    self.searchInputBackgroundView.hidden=false;
    self.menuInputBackgroundView.hidden=true;
    self.titleInputBackgroundView.hidden=true;
    self.commentInputBackgroundView.hidden=true;


}

- (void) commentBarAction {
    [self moveSubtitleTextViewDown];
    self.commentInputBackgroundView.hidden=false;
    self.menuInputBackgroundView.hidden=true;
    self.titleInputBackgroundView.hidden=true;
    self.searchInputBackgroundView.hidden=true;
}

//
//
////////
#pragma mark - Move text view box
////////
//
//

- (void) moveCommentTextViewUp {
    if (!self.commentFrameHasMoved && !self.commentInputBackgroundView.hidden){
        CGRect currentFrame = self.commentInputBackgroundView.frame;
        self.commentInputBackgroundView.frame =  CGRectOffset(currentFrame,0,-1*TEXT_VIEW_MOVE);
        self.commentFrameHasMoved = true;
    }
}

- (void) moveCommentTextViewDown {
    if (self.commentFrameHasMoved && !self.commentInputBackgroundView.hidden){
        CGRect currentFrame = self.commentInputBackgroundView.frame;
        self.commentInputBackgroundView.frame =  CGRectOffset(currentFrame,0,TEXT_VIEW_MOVE);
        self.commentFrameHasMoved = false;
    }
}

- (void) moveSubtitleTextViewUp {
    if (!self.titleFrameHasMoved && !self.titleInputBackgroundView.hidden){
        CGRect currentFrame = self.titleInputBackgroundView.frame;
        self.titleInputBackgroundView.frame =  CGRectOffset(currentFrame,0,-1*TEXT_VIEW_MOVE);
        self.titleFrameHasMoved = true;
    }
}

- (void) moveSubtitleTextViewDown {
    if (self.titleFrameHasMoved && !self.titleInputBackgroundView.hidden){
        CGRect currentFrame = self.titleInputBackgroundView.frame;
        self.titleInputBackgroundView.frame =  CGRectOffset(currentFrame,0,TEXT_VIEW_MOVE);
        self.titleFrameHasMoved = false;
    }
}

//
//
////////
#pragma mark - Comment Button Save to Source Sheet
////////
//
//

- (IBAction)saveCommentButtonPress:(UIButton *)sender {
    if (self.mySourceSheet.commentString !=nil){
        [self saveCommentDataAction];
    }
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
    else if (tableView.tag == SEARCH_TAG) {
        UITableViewCell *cell = SEARCH_CELL;
        NSString* myString = [self.searchTextArray objectAtIndex:indexPath.row];
        NSString * myInfo = [self.searchInfoArray objectAtIndex:indexPath.row];
        cell = [self setMySearchTextCell:cell withText:myString withInfo:myInfo];
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
        [self setCurrentLineText : indexPath.row];
    }
    else if (tableView.tag == HEBREW_TAG){
        [self setCurrentLineText : indexPath.row];
    }
    else if (tableView.tag == SEARCH_TAG) {
        [self setCurrentSearchLineText : indexPath.row];
    }
}

//
//
////////
#pragma mark - Text Selection Press
////////
//
//

- (void) setCurrentLineText : (NSInteger) selectedIndex {
    if ([self.primaryDataArray count] >= selectedIndex) {
        self.myLineText = [self.primaryDataArray objectAtIndex:selectedIndex];
    }
}

- (void) setCurrentSearchLineText : (NSInteger) selectedIndex {
    if ([self.searchLineDataArray count] >= selectedIndex) {
        self.myLineText = [self.searchLineDataArray objectAtIndex:selectedIndex];
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
        if (self.isChapterLevel) {
            self.theChapterNumber = indexPath.row;
            [self basicDataReload];
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
#pragma mark - Text Menu Button Press
////////
//
//

- (IBAction)languageSelectionButtonPress:(UIButton *)sender {
    [self languageSelectionButtonAction];
}

- (IBAction)saveLineTextButtonPress:(UIButton *)sender {
    if (self.myLineText != nil) {
        [self lineBuildDataAddAction];
    }
}

//
////
//

- (void) languageSelectionButtonAction {
    if (self.hebrewTextTable.isHidden) {
        [self.languageSelectionButton setTitle:@"A" forState:UIControlStateNormal];
        self.hebrewTextTable.hidden = false;
        self.englishTextTable.hidden = true;
    }
    else {
        [self.languageSelectionButton setTitle:@"א" forState:UIControlStateNormal];
        self.hebrewTextTable.hidden = true;
        self.englishTextTable.hidden = false;
    }
}

//
//
////////
#pragma mark - Save Search Button
////////
//
//

- (IBAction)saveSearchButtonPress:(UIButton *)sender {
    [self saveSearchAction];
}

- (void) saveSearchAction {
    if (self.myLineText != nil) {
        [self lineBuildDataAddAction];
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
            
            //[self saveReadingPreferences];
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
    [self.englishTextTable reloadData];
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable reloadData];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
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
    [self.smallMenuTable reloadData];
    [self.menuChoiceArray removeAllObjects];
    self.titleTextView.delegate = self;
    [self addDeleteGesture];
}

- (void) initialSetUp {
    self.navigationController.navigationBarHidden = false;
    [self viewStyleForLoad];
    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
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
#pragma mark - Delete Section
////////
//
//

- (void) addDeleteGesture {
    NSLog(@"delete gesture loaded");
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deleteAction:)
     name:@"deleteSheetObject"
     object:nil];
}

- (void)deleteAction : (NSNotification *) notification {
    NSDictionary* userInfo = notification.userInfo;
    if ([userInfo objectForKey:@"numberIndexForDelete"]){
        LOG NSLog(@"-- data info %@ --",[userInfo objectForKey:@"numberIndexForDelete"]);
        NSInteger index = [[userInfo objectForKey:@"numberIndexForDelete"] integerValue]-1;
        if ([self.mySourceSheet.dataArray count] >= index){
            [self.mySourceSheet.dataArray removeObjectAtIndex:index];
            [self drawSheet];
        }
    }
}

//
//
////////
#pragma mark - Setter
////////
//
//

- (SourceSheetObject*) mySourceSheet {
    if (!_mySourceSheet){
        _mySourceSheet = [[SourceSheetObject alloc]init];
    }
    return _mySourceSheet;
}













//
//
////////
#pragma mark - Test
////////
//
//

-(void) testBuildCharacterSheet {
    __unused NSInteger myDepth = 0;
    __unused NSString* mytext =@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    __unused NSString* myTitleTwo =@"On Chocolate.";
    
    //myOveralSize = myOveralSize + [self addTitle : myTitleTwo withCurrentOverallSize:myOveralSize withFont:TITLE_FONT withScrollView:self.sourceSheetScrollView];
    
    
    NSString* heading = @"On Chocolate";
    NSString* subHeading = @"Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.";
    
    NSInteger viewCurrentSize = 0;
    
    
    SourceSheetObject* myObject = [[SourceSheetObject alloc]init];
    myObject.theWidth = self.sourceSheetScrollView.frame.size.width;
    viewCurrentSize = viewCurrentSize + [myObject setHeadingTextObjectView:viewCurrentSize withHeadingText:@[heading,subHeading] withScrollView:self.sourceSheetScrollView];
//    viewCurrentSize = viewCurrentSize + [myObject setLineTextObjectView : viewCurrentSize withLineText:self.myLineText MYID withDepth : 0 withScrollView:self.sourceSheetScrollView];
//    viewCurrentSize = viewCurrentSize + [myObject setCommentTextObjectView:viewCurrentSize withCommentText:subHeading MYID withDepth : 0 withScrollView:self.sourceSheetScrollView];
    
    NSLog(@"-- my obj %@ --",myObject.contentArray);
    
    
    
    [self.sourceSheetScrollView addSubview:myObject.thetitle];
    for (id MOBJ in myObject.contentArray) {
        //NSLog(@"-- my id %@ --",MOBJ);
        [self.sourceSheetScrollView addSubview:MOBJ];
    }
    
    
    /*
     viewCurrentSize = viewCurrentSize + [self setHeadingTextObjectView:viewCurrentSize withHeadingText:headingText withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setLineTextObjectView : viewCurrentSize withLineText:self.myLineText withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setCommentTextObjectView:viewCurrentSize withCommentText:subHeading withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setLineTextObjectView : viewCurrentSize withLineText:self.myLineText withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setCommentTextObjectView:viewCurrentSize withCommentText:subHeading withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setLineTextObjectView : viewCurrentSize withLineText:self.myLineText withScrollView:self.sourceSheetScrollView];
     viewCurrentSize = viewCurrentSize + [self setCommentTextObjectView:viewCurrentSize withCommentText:subHeading withScrollView:self.sourceSheetScrollView];
     */
    
    self.sourceSheetScrollView.contentSize =  CGSizeMake(self.sourceSheetScrollView.frame.size.width,viewCurrentSize*1.1) ;
}




@end
