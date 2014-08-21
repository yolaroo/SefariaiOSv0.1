//
//  BookFromRest.m
//  Sefaria
//
//  Created by MGM on 8/16/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "BookFromRestView.h"

#import "MainFoundation+RestTextActions.h"
#import "RestTextDataFetch.h"
#import "RestTextDataModel.h"

#import "RestMenuDataFetch.h"
#import "RestMenuDataModel.h"

#import "MainFoundation+TextDataActionLayer.h"
#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+MenuActions.h"

#import "MainFoundation+ChapterReadAnimations.h"

#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"

#import "MainFoundation+GestureActions.h"

@class RestTextDataFetch;
@class RestMenuDataFetch;

@interface BookFromRestView ()

@property (nonatomic, strong) RestTextDataFetch* myRestDataFetch;
@property (nonatomic, strong) RestMenuDataFetch* myMenuRestDataFetch;

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

//
//// BUTTON
//

@property (weak, nonatomic) IBOutlet UIButton *englishTextButton;
@property (weak, nonatomic) IBOutlet UIButton *englishChapterButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewTextButton;
@property (weak, nonatomic) IBOutlet UIButton *hebrewChapterButton;

@end

@implementation BookFromRestView

@synthesize myRestDataFetch=_myRestDataFetch;

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
#pragma mark - Button Action
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
    self.theCurrentChapterNumber ++;
    [self myArraySetter];
}

- (void) chapterPreviousAction {
    self.theCurrentChapterNumber --;
    [self myArraySetter];
}

//
//
////////
#pragma mark - Button Selection For Menu
////////
//
//

- (IBAction)menuButtonBackPress:(UIButton *)sender {
    if (self.menuDepthCount > 0) {
        self.menuDepthCount--;
    }
    [self backAction];
}

- (void) backAction {
    self.isTextLevel = false;
    self.isBookLevel = true;
    if(self.menuDepthCount == 0) { // reset
        NSLog(@"menu reset %d --",self.menuDepthCount);
        [self theZeroDepthMenuLoad];
    }
    else { //up  level
        NSLog(@"back press to up %d --",self.menuDepthCount);
    }
    [self menuTableScrollToTop];
    [self eraseChapterTableView];
    [self updateMenu];
}

- (void) eraseChapterTableView {
    self.chapterListArray = @[];
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

- (void) menuTableScrollToTop {
    [self.menuTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

- (void) updateMenu {
    [self.menuTable reloadData];
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
        [self didSelectRestMenuAtIndex : indexPath.row];
    }
    else if (tableView.tag == CHAPTER_TAG){
        [self didSelectRestChapterMenuAtIndex : indexPath.row];
    }
    else if (tableView.tag == ENGLISH_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self foundationRunSpeech:@[myCellText]];
    }
    else if (tableView.tag == HEBREW_TAG){
        //
    }
}

//
////
//

- (void) didSelectRestChapterMenuAtIndex : (NSInteger) indexPathRow {
    NSLog(@"Chapter Pressed");
    self.theCurrentChapterNumber = indexPathRow+1;

    [self myArraySetter];
    [self updateText];
}

- (void) didSelectRestMenuAtIndex : (NSInteger) indexPathRow {
    if (self.isTextLevel) {
        LOG NSLog(@"Select at text level");
        
        NSString* str = [self.menuListArray objectAtIndex:indexPathRow];
         str = [str stringByReplacingOccurrencesOfString:@" "
                                             withString:@"_"];
        self.myCurrentTextTitle = str;
        LOG NSLog(@"-- MCT %@ --",self.myCurrentTextTitle);
        
        if ([[[self.menuPathChoiceArray lastObject]firstObject] isKindOfClass: [NSArray class]]) {
            NSArray* myArray =  [[self.menuPathChoiceArray lastObject]firstObject];
            if ([myArray count] >= indexPathRow) {
                NSDictionary* myNewArray = [myArray objectAtIndex:indexPathRow];
                if ([[myNewArray objectForKey:@"length"]integerValue]) {
                    NSInteger myChapterMax = [[myNewArray objectForKey:@"length"]integerValue];
                    self.chapterListArray = [self chapterNumberArray: myChapterMax];
                    [self setMyChapterView];
                
                
                } else {
                    NSLog(@"Error - no chapter number 0.0 ");
                }
            } else {
                NSLog(@"Error - no dictionary 0.0");
            }
        }
        else {
            NSLog(@"-- Top Path --");
            if ([self.menuTopPathChoiceArray count]) {
                if ([[self.menuTopPathChoiceArray objectAtIndex:indexPathRow] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary* myNewArray = [self.menuTopPathChoiceArray objectAtIndex:indexPathRow];
                    if ([[myNewArray objectForKey:@"length"]integerValue]) {
                        NSInteger myChapterMax = [[myNewArray objectForKey:@"length"]integerValue];
                        self.chapterListArray = [self chapterNumberArray: myChapterMax];
                        [self setMyChapterView];

                        
                        
                        
                    } else {
                        
                        if([myNewArray objectForKey:@"availableCounts"]) {
                            //NSLog(@"-- Available count %@ --",[myNewArray objectForKey:@"availableCounts"]);
                            
                            id englishGroup = [[myNewArray objectForKey:@"availableCounts"]objectForKey:@"en"];
                            id hebrewGroup= [[myNewArray objectForKey:@"availableCounts"]objectForKey:@"he"];
                            
                            NSArray* keyGroup = [englishGroup allKeys];

                            
                            for (NSString* STR in keyGroup) {
                                id eGroup = [englishGroup objectForKey:STR];
                                NSLog(@"-- EG - %@ - %@ %@ --",self.myCurrentTextTitle,STR,eGroup);
                                id hGroup = [hebrewGroup objectForKey:STR];
                                NSLog(@"-- HG - %@ - %@ %@ --",self.myCurrentTextTitle,STR,hGroup);

                            }
                            
#warning - Here!!!
                  
                            // level question on Nefesh_HaChaim.1.1
                            
                            //Paragraph
                            //Perek
                            //Shar
                            //Parashah
                            //Parsha
                            //section
                            //torah

                        }
                        else {
                            NSLog(@"-- Error - no chapter number 0.1 %@ --",myNewArray);
                            [self noContentError];

                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                } else {
                    NSLog(@"Error - No Dictionary 0.1");
                }
            } else {
                NSLog(@"Error - Empty Array 0.1");
            }
        }
    } else {
        NSLog(@"NOT Text Level");
        //self.menuDepthCount++;
        [self basicRestMenuLoad : indexPathRow];
        [self menuTableScrollToTop];
        [self updateMenu];
    }
}


- (void) noContentError {
    [self emptyTextAlert];
}

- (void) setMyChapterView {
    NSLog(@"-- chapter set here --");
    if (self.isTextLevel){//chapter number writer
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
    else {
        LOG NSLog(@"error - array setter not text level");
    }
    //[self.chapterTable reloadData];
}


//
//
////////
#pragma mark - Full Menu Data
////////
//
//

- (void) theZeroDepthMenuLoad {
    LOG NSLog(@"initial menu set");
    NSArray* myMenu0 = [self intialRestMenuFetch: self.myMenuRestDataFetch withDataArray:self.myMenuRestDataFetch.myMenuRestData.theCompleteDictionary];
    self.menuListArray = [myMenu0 firstObject];
    self.menuListPathArray = [myMenu0 lastObject];
    [self.menuTopPathChoiceArray removeAllObjects];
    self.isTextLevel = false;
    self.isBookLevel = true;
    
    [self.menuChoiceArray removeAllObjects];
    [self.menuPathChoiceArray removeAllObjects];
}

//
////
//

- (void) basicRestMenuLoad : (NSInteger) indexPathRow {
    NSArray* myMenu;
    NSLog(@"second lvl");
    if ([self.menuListPathArray count] > 0){
        if ([[self normalRestMenuFetch: self.myMenuRestDataFetch withDataArray:[self.menuListPathArray objectAtIndex:indexPathRow]] isKindOfClass:[NSArray class]]) {
            myMenu = [self normalRestMenuFetch: self.myMenuRestDataFetch withDataArray:[self.menuListPathArray objectAtIndex:indexPathRow]];
            NSLog(@"!!!!!!");
            self.menuTopPathChoiceArray = [[[[self intialRestMenuFetch: self.myMenuRestDataFetch withDataArray:self.myMenuRestDataFetch.myMenuRestData.theCompleteDictionary]lastObject]objectAtIndex:indexPathRow]mutableCopy];
        } else {
            NSLog(@"error - not an array 0.X1");
        }
    } else {
        NSLog(@"error - empty array 0.X2");
    }
    
    self.menuListArray = [myMenu firstObject];
    self.menuListPathArray = [myMenu lastObject];
    
    if ([self isMenuTextLevel : myMenu]) {
        self.isTextLevel = true;
        self.isBookLevel = false;
        NSLog(@"is text level");

        LOG NSLog(@"-- TDPLZ %@ --",self.menuListArray);
    }
    else {
        NSLog(@"is not text level 0.X3");
        [self.menuChoiceArray addObject:[myMenu firstObject]];
        [self.menuPathChoiceArray addObject:[myMenu lastObject]];
        self.isTextLevel = false;
        self.isBookLevel = true;
    }
}

- (bool) isMenuTextLevel : (NSArray*) myRestMenuData  {
    if ([myRestMenuData count] >= 1){
        bool isTextLevelTest = [[myRestMenuData objectAtIndex:1]boolValue];
        return isTextLevelTest;
    }
    return false;
}

//
//
////////
#pragma mark - Text Data
////////
//
//

- (void) updateText {
    [self setTextData];
    [self.englishTextTable reloadData];
    [self.hebrewTextTable reloadData];
}

- (void) setTextData {
    if (self.myRestDataFetch.myRestData != nil) {
        RestTextDataModel* myData = self.myRestDataFetch.myRestData;
        LOG NSLog(@"-- Text Info %@ %@ --",myData.theTitle,myData.theHebrewTitle);
        
        if (myData.theCompleteEnglishTextArray != nil) {
            self.primaryEnglishTextArray = myData.theCompleteEnglishTextArray;
        } else {
            NSLog(@"Error - english text fetch");
        }
        
        if (myData.theCompleteHebrewTextArray != nil) {
            self.primaryHebrewTextArray = myData.theCompleteHebrewTextArray;
        } else {
            NSLog(@"Error - hebrew text fetch");
        }
        
        if (myData.theHebrewTitle != nil) {
            self.viewTitleHebrew = myData.theHebrewTitle;
        } else {
            NSLog(@"Error - hebrew title fetch");
        }
        
        if (myData.theTitle != nil) {
            self.viewTitleEnglish = myData.theTitle;
        } else {
            NSLog(@"Error - english title fetch");
        }
        
        if (myData.theDataChapterMax > 0) {
            self.theChapterMax = myData.theDataChapterMax;
        } else {
            NSLog(@"Error - chapter number max");
        }
        [self.englishTextButton setTitle:self.viewTitleEnglish forState:UIControlStateNormal];
        [self.hebrewTextButton setTitle:self.viewTitleHebrew forState:UIControlStateNormal];
    }
    else {
        NSLog(@"Error - data fetch");
    }
    [self setTextView];
    //NSLog(@"-- PHT %@ --",self.primaryHebrewTextArray);
    //NSLog(@"-- PET %@ --",self.primaryEnglishTextArray);
}

//
////
//

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.hebrewTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    NSString* englishChapterString = [NSString stringWithFormat:@"Chapter %ld",(long)self.theCurrentChapterNumber];
    [self.englishChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
    [self.hebrewChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
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
#pragma mark - Rest Method Data Fetch
////////
//
//

- (void) myArraySetter {
    [self startAI];
    NSLog(@"-- TCN %d --",self.theCurrentChapterNumber);
    [self restTextAccessAction : self.myRestDataFetch withTextName:self.myCurrentTextTitle withChapterNumber:self.theCurrentChapterNumber];
    
    //label text string setter
    [self.englishTextButton setTitle:self.myCurrentTextTitle forState:UIControlStateNormal];

    NSString* englishChapterString = [NSString stringWithFormat:@"Chapter %ld",(long)self.theCurrentChapterNumber];
    [self.englishChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
    [self.hebrewChapterButton setTitle:englishChapterString forState:UIControlStateNormal];
}

- (void) notificationOfData { // notification paired function
    LOG NSLog(@"Notification Of Data in Main View");
    [self updateText];
    [self stopAI];
    if (self.isMenuShowing){
        [self theMenuActionComplete];
    }
}

- (void) notificationOfMenuData { // notification paired function
    LOG NSLog(@"Notification Of Menu Data in Main View");
    [self theZeroDepthMenuLoad];
    [self updateMenu];
    [self stopAI];
}

//
//
////////
#pragma mark - Setter
////////
//
//

- (RestTextDataFetch*) myRestDataFetch {
    if (!_myRestDataFetch){
        _myRestDataFetch = [[RestTextDataFetch alloc] init];
    }
    return _myRestDataFetch;
}


- (RestMenuDataFetch*) myMenuRestDataFetch {
    if (!_myMenuRestDataFetch){
        _myMenuRestDataFetch = [[RestMenuDataFetch alloc] init];
    }
    return _myMenuRestDataFetch;
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
    [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.6];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//
////////
#pragma mark - View Style
////////
//
//

- (void) initialSetUp {

    [self loadDataListener];

    //get menu
    [self startAI];

    [self restMenuFirstLoad];

    // data set
    self.myCurrentTextTitle = @"Ezra";
    self.theCurrentChapterNumber = 1;
    // get first data
    [self myArraySetter];

    [self menuAnimationOnLoad : self.mainMenuView withChapterView:self.mainChapterView];
    [self viewStyleForLoad];
    [self gestureLoader : self.mainMenuView withChapterView:self.mainChapterView];

}

- (void) restMenuFirstLoad {
    [self loadMenuDataListener];
    [self.myMenuRestDataFetch basicRestMenuRequest];
    
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

- (void) restMenuViewTest {
    NSString* theURLString = @"http://www.sefaria.org/api/index";
    //NSString* theURLString = @"http://www.sefaria.org/api/texts/Ezra.5";
    NSURL *pathURL = [NSURL URLWithString: theURLString];
    NSLog(@"-- request... --");
    NSURLRequest *request = [NSURLRequest requestWithURL:pathURL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:10.0];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *myData,
                                               NSError *connectionError)
     {
         NSLog(@"-- Request fetched --");
         if (myData.length > 0 && connectionError == nil) {
             NSInteger httpStatus = [((NSHTTPURLResponse *)response) statusCode];
             NSLog(@"http Status : %d",httpStatus);

             NSError* error;
             __unused NSArray* myCompleteDataArray = [NSJSONSerialization JSONObjectWithData:myData
                                                                     options:kNilOptions
                                                                       error:&error];

             //[self recursiveTitleDataModel: myCompleteDataArray withDepth : 0];
         }
     }];
}

//
////
//

- (void) TestTitleDataModel : (NSArray*) myCompleteDataArray {
    
    for (int i = 0; i < [myCompleteDataArray count]; i++) {
        //
    }
    NSDictionary* myFirstLevelBookGroupDictionary = [myCompleteDataArray firstObject]; //FO
    //NSLog(@"-- MFLD %@ --",myFirstLevelBookGroupDictionary);
    //NSLog(@"-- AK %@ --",[myBookGroupDictionary allKeys]);
    //NSLog(@"-- MD %@ --",myBookGroupDictionary);
    
    __unused NSString* myTitleL1 = [myFirstLevelBookGroupDictionary objectForKey:@"category"];
    //NSLog(@"-- MT %@ --",myTitleL1);
    //add title
    
    if ([myFirstLevelBookGroupDictionary objectForKey:@"contents"]) {
        // Has a next Level of depth!
        // object is an array
    }
    
        NSArray* mySecondLevelArray = [myFirstLevelBookGroupDictionary objectForKey:@"contents"];
        //NSLog(@"-- MSLA %@ --",[myFirstLevelBookGroupDictionary objectForKey:@"contents"]);

        for (int j = 0; j < [mySecondLevelArray count]; j++) {
            //
        }
    
        NSDictionary* mySecondLevelBookGroupDictionary = [mySecondLevelArray firstObject]; //FO
        __unused NSString* myTitleL2 = [mySecondLevelBookGroupDictionary objectForKey:@"category"];

        if ([mySecondLevelBookGroupDictionary objectForKey:@"title"]) {
                // check to find title!!
                // shows no more depth
        }
        if ([mySecondLevelBookGroupDictionary objectForKey:@"category"]) {
            // check to find category!!
            // show there IS more depth
        }
    
        //NSLog(@"-- MD %@ --",mySecondLevelBookGroupDictionary);
        //NSLog(@"-- MT %@ --",myTitleL2);

        if ([mySecondLevelBookGroupDictionary objectForKey:@"contents"]) {
            // Has a next Level of depth!
            // object is an array
        }
    
        for (int k = 0; k < [mySecondLevelArray count]; k++) {
            //
        }
    
            NSArray* myThirdLevelArray = [mySecondLevelBookGroupDictionary objectForKey:@"contents"];
            //NSLog(@"-- MTLA %@ --",[mySecondLevelBookGroupDictionary objectForKey:@"contents"]);

            NSDictionary* myThirdLevelBookGroupDictionary = [myThirdLevelArray firstObject]; //FO
            //NSLog(@"-- MD3 %@ --",myThirdLevelBookGroupDictionary);
            NSString* myTitleL3 = [myThirdLevelBookGroupDictionary objectForKey:@"title"];
            NSLog(@"-- MT3 %@ --",myTitleL3);
            NSInteger myChapterNumber = [[myThirdLevelBookGroupDictionary objectForKey:@"length"]integerValue];
            NSLog(@"-- MCN %d --",myChapterNumber);
    
    // L1 = category (title)
    // L1 = content...
}

//
////
//

- (void) notificationTest {
    NSArray* myMenu0 = [self intialRestMenuFetch: self.myMenuRestDataFetch withDataArray:self.myMenuRestDataFetch.myMenuRestData.theCompleteDictionary];
    //NSLog(@"-- MM %@ --",[myMenu0 firstObject]);
    
    NSArray* pathArray = [myMenu0 lastObject];
    
    if ([self isMenuTextLevel: myMenu0]) {
        NSLog(@"0.0 is text level");
    }
    
    NSArray* myMenu01 = [self normalRestMenuFetch: self.myMenuRestDataFetch withDataArray:[pathArray objectAtIndex:0] ]; //needs to be chosen
    //NSLog(@"-- MM %@ --",[myMenu01 firstObject]);
    
    if ([self isMenuTextLevel: myMenu01]) {
        NSLog(@"is text level");
    }
    
    NSArray* newPathArray = [myMenu01 lastObject];
    
    NSArray* myMenu02 = [self normalRestMenuFetch: self.myMenuRestDataFetch withDataArray:[newPathArray objectAtIndex:0] ]; //needs to be chosen
    //NSLog(@"-- MM %@ --",[myMenu02 firstObject]);
    
    if ([self isMenuTextLevel: myMenu02]) {
        NSLog(@"is text level");
    }
}





@end
