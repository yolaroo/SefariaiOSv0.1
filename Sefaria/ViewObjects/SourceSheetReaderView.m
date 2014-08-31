//
//  SourceSheetReaderView.m
//  Sefaria
//
//  Created by MGM on 8/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SourceSheetReaderView.h"

#import "MainFoundation+MainViewActions.h"

#import "SourceSheetObject.h"

#import "ContextGroup.h"
#import "ContextGroupData.h"
#import "ContextGroupComment.h"

#import "MainFoundation+FetchTheContextGroup.h"

#import "MainFoundation+ChapterReadAnimations.h"

#import "MainFoundation+SourceSheetCellStyle.h"

#import "SourceSheetObject.h"
@class SourceSheetObject;

#import "MainFoundation+SourceSheetReaderActions.h"


@interface SourceSheetReaderView ()

//
////
//

@property (strong,nonatomic) SourceSheetObject* mySourceSheet;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView * SourceSheetListTable;
@property (weak, nonatomic) IBOutlet UIView * searchInputBackgroundView;

@property (strong, nonatomic) NSArray* sourceSheetListDataArray;

@property (weak, nonatomic) IBOutlet UIScrollView *sourceSheetScrollView;

//
////
//

@end

@implementation SourceSheetReaderView

#define RESET_DELAY 0.3
#define SOURCE_SHEET_LIST_TAG 950
#define SOURCE_SHEET_LIST_CELL [tableView dequeueReusableCellWithIdentifier:@"SourceSheetTitleCell" forIndexPath:indexPath]
#define TABLE_CELL_COLOR [UIColor colorWithRed: 50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.3f]

//
//
////////
#pragma mark - Menu Animation
////////
//
//

- (IBAction)menuButtonPress:(UIButton *)sender {
    self.isMenuShowing = !self.isMenuShowing;
    if (self.isMenuShowing){
        [self hideSingleMenu: self.searchInputBackgroundView];
    }
    else {
        [self showSingleMenu: self.searchInputBackgroundView];
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
    return [self.sourceSheetListDataArray count] ? [self.sourceSheetListDataArray count] : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == SOURCE_SHEET_LIST_TAG) {
        UITableViewCell *cell = SOURCE_SHEET_LIST_CELL;
        NSString* myString = [self sourceSheetString : [self.sourceSheetListDataArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = myString;
        cell.textLabel.backgroundColor = TABLE_CELL_COLOR;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
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
    return 55.0; //[self tableViewHeightForCoreData:tableView cellForRowAtIndexPath:indexPath];
}

//
//
////////
#pragma mark - Select
////////
//
//

- (void) tableView : (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == SOURCE_SHEET_LIST_TAG){
        NSLog(@"selected from menu");
        //[self fullDataLoadToView : [self.sourceSheetListDataArray objectAtIndex:indexPath.row]];
        [self fullDataLoadToView:[self.sourceSheetListDataArray objectAtIndex:indexPath.row] withScrollView:self.sourceSheetScrollView withSourceSheet:self.mySourceSheet];
    }
}

//
//
////////
#pragma mark - Data
////////
//
//

- (NSArray*) myArraySetter {
    @try {
        NSArray* mydata;
        mydata = [self fetchAllContextGroups : self.managedObjectContext];
        return mydata;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
//
////////
#pragma mark - Data Setter
////////
//
//

- (void) basicDataReload {
    [self updateTheData];
    [self setTextView];
}

- (void) updateTheData {
    self.sourceSheetListDataArray = [self myArraySetter];
}

- (void) setTextView {
    [self.SourceSheetListTable scrollRectToVisible : CGRectMake(0, 0, 1, 1) animated : NO];
    [self.SourceSheetListTable reloadData];
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
    [self basicDataReload];
}

- (void) initialSetUp {
    [self viewStyleForLoad];
    [self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
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

@end
