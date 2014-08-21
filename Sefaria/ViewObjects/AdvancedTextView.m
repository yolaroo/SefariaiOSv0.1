//
//  AdvancedTextView.m
//  Sefaria
//
//  Created by MGM on 7/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "AdvancedTextView.h"

#import "BookListDataModel.h"
#import "MenuBuilderDataModel.h"

#import "FileRecursion.h"

#import "MainFoundation+MainViewActions.h"
#import "MainFoundation+ChapterReadAnimations.h"
#import "MainFoundation+TableViewStyles.h"
#import "MainFoundation+MenuActions.h"

#import "MainFoundation+ActionsForAdvancedText.h"

#import "MainFoundation+HebrewTextStyles.h"
#import "MainFoundation+EnglishTextStyle.h"
#import "MainFoundation+ChapterAndMenuTextStyles.h"

@class FileRecursion;

@interface AdvancedTextView ()

@property (nonatomic,strong) NSFileManager *myFileManager;

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

@property (nonatomic,strong) NSString *myTitleTempStore;

@property (strong, nonatomic) FileRecursion* myFileRecursionMenu;

@end

@implementation AdvancedTextView

@synthesize myFileManager=_myFileManager,myFileRecursionMenu=_myFileRecursionMenu;

#define ROOT_DIRECTORY @"TextData"

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]

#define MENU_TAG 100
#define ENGLISH_TAG 200
#define HEBREW_TAG 300
#define CHAPTER_TAG 400

#define MENU_CELL [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath]
#define ENGLISH_CELL [tableView dequeueReusableCellWithIdentifier:@"EnglishTextCell" forIndexPath:indexPath]
#define HEBREW_CELL [tableView dequeueReusableCellWithIdentifier:@"HebrewTextCell" forIndexPath:indexPath]
#define CHAPTER_CELL [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath]

#define CELL_CONTENT_WIDTH TABLE_WIDTH - CELL_CONTENT_MARGIN
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 40.0
#define TABLE_WIDTH 380.0f

//
//
////////
#pragma mark - Back Button For Menu
////////
//
//

- (IBAction)backMenuPress:(UIButton *)sender {
    [self backMenuAction];
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
        NSString* myString = [self.menuListArray objectAtIndex : indexPath.row];
        cell = [self setMenuCell:cell withString : myString];
        return cell;
    }
    else if (tableView.tag == CHAPTER_TAG) {
        NSString* myString = [self.chapterListArray objectAtIndex : indexPath.row];
        return [self setChapterCell:CHAPTER_CELL withString : myString];
    }
    else if (tableView.tag == ENGLISH_TAG){
        UITableViewCell *cell = ENGLISH_CELL;
        NSString* myString = [self englishTextFromArray : indexPath];
        cell = [self setMyEnglishTextCell:cell withString : myString];
        return cell;
    }
    else if (tableView.tag == HEBREW_TAG) {
        UITableViewCell *cell = HEBREW_CELL;
        NSString* myString = [self hebrewTextFromObject : indexPath];
        cell = [self setMyHebrewTextCell:cell withString : myString];
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

- (NSString*) englishTextFromArray:(NSIndexPath *)indexPath {
    if ([self.primaryDataArray count] > indexPath.row){
        NSString* myLine = [self.primaryDataArray objectAtIndex:indexPath.row];
        return myLine ? myLine : @"error";
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
            myStringEnglish = [self.primaryDataArray objectAtIndex: indexPath.row];
        }
        if ([myStringEnglish length]){
            sizeEnglish = [self frameForText:myStringEnglish sizeWithFont:IPAD_FONT constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
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
#pragma mark - Table Press
////////
//
//

- (void) tableView : (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MENU_TAG){
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //NSString*myCellText = cell.textLabel.text;
        //[self menuPress:myCellText];
        [self menuActionOnTableTouch:indexPath.row];
    }
    else if (tableView.tag == CHAPTER_TAG) {
        //self.theChapterNumber = indexPath.row;
        //[self basicDataReload];
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

//
//
////////
#pragma mark - Full Menu Data
////////
//
//

- (void) backMenuAction {
    if([self.menuChoiceArray count] <= 1) {
        [self theInitialMenuLoad];
    }
    else {
        [self.menuChoiceArray removeLastObject];
        [self.menuPathChoiceArray removeLastObject];
        self.menuListArray = [self.menuChoiceArray lastObject];
        self.menuListPathArray = [self.menuPathChoiceArray lastObject];
        [self.menuTable reloadData];
    }
    [self setTextView];
}

- (void) menuActionOnTableTouch : (NSInteger) myRow {
    NSString* myPathFromPress = [self.menuListPathArray objectAtIndex:myRow];
    if ([myPathFromPress hasSuffix:@".json"]) {
        LOG NSLog(@"-- The Path %@ --",myPathFromPress);

        self.myCurrentTextTitle = [self stringPathFormat:myPathFromPress];
        self.theChapterNumber = 0;
        [self basicDataReload];
        LOG NSLog(@"-- MPFP %@ --",myPathFromPress);
    }
    else {
        self.menuListArray = [[self.myFileRecursionMenu returnPath: myPathFromPress] firstObject];
        self.menuListPathArray = [[self.myFileRecursionMenu returnPath: myPathFromPress] lastObject];
        [self.menuChoiceArray addObject:self.menuListArray];
        [self.menuPathChoiceArray addObject:self.menuListPathArray];
    }
    [self.menuTable reloadData];
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
        //NSLog(@"-- SMCTT %@ --",self.myCurrentTextTitle);
        NSArray* myTextData = [self getTextListData:self.myCurrentTextTitle];
        mydata = [self textDataExtract:myTextData];
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) updateTheData {
    self.primaryDataArray = [self myArraySetter];
}

- (void) setTextView {
    [self.englishTextTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

    [self.menuTable reloadData];
    //[self.chapterTable reloadData];
    [self.englishTextTable reloadData];
    //[self.hebrewTextTable reloadData];
}

//
//
////////
#pragma mark - Initial Load
////////
//
//

- (void) initialLoad {
    [self theInitialMenuLoad];
    self.myCurrentTextTitle = @"Tanach/Torah/Exodus/Hebrew/merged";
    [self basicDataReload];
    
    //[self testMenuRecursion];
    
}

//
////
//

- (void) theInitialMenuLoad {
    [self.menuChoiceArray removeAllObjects];
    [self.menuPathChoiceArray removeAllObjects];

    self.menuListArray = [[self.myFileRecursionMenu returnPath: ROOT_DIRECTORY] firstObject];
    self.menuListPathArray = [[self.myFileRecursionMenu returnPath: ROOT_DIRECTORY] lastObject];
    
    [self.menuChoiceArray addObject:self.menuListArray];
    [self.menuPathChoiceArray addObject:self.menuListPathArray];
}

//
//
////////
#pragma mark - Setter
////////
//
//

- (FileRecursion*) myFileRecursionMenu {
    if (!_myFileRecursionMenu){
        _myFileRecursionMenu = [[FileRecursion alloc]init];
    }
    return _myFileRecursionMenu;
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
    self.navigationController.navigationBarHidden = false;
    //[self viewStyleForLoad];
    //[self gestureRecognizerGroup];
    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
    
    [self textDirectoryRecursionTest];
    //[self commentTest];
}

- (void)didReceiveMemoryWarning2
{
    [super didReceiveMemoryWarning];
}

//
//
////////
#pragma mark - Test
////////
//
//

#define COMMENT_DIRECTORY @"TextComments/Commentary"
#define COMMENT_DIRECTORY_II @"TextComments/Commentary/Tanach/Prophets/II Kings/Metzudat David on II Kings/English/Sefaria Community Translation"

- (void) commentTest {
    
    
    
//    NSArray* stuff = [[self.myFileRecursionMenu returnPath: COMMENT_DIRECTORY_II] firstObject];
//    NSArray* filePath = [[self.myFileRecursionMenu returnPath: COMMENT_DIRECTORY] lastObject];

    
    NSArray* myTextData = [self getTextListData:COMMENT_DIRECTORY_II];
    NSArray* mydata = [self textDataExtract:myTextData];

    
    NSLog(@"-- STUFF %@ --",mydata);
    
    
}

- (void) textDirectoryRecursionTest {
    

    
}








@end
