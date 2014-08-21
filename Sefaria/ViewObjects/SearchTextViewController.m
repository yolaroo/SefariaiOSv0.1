//
//  SearchTextViewController.m
//  Sefaria
//
//  Created by MGM on 7/24/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SearchTextViewController.h"

#import "MainFoundation+FetchTheLineText.h"
#import "MainFoundation+MainViewActions.h"

#import "MainFoundation+TableViewStyles.h"

#import "MainFoundation+FetchTheComment.h"

@interface SearchTextViewController ()


@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *myTextTable;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;


//
////
//

@property (strong,nonatomic) NSMutableArray* myTextArray;
@property (strong,nonatomic) NSMutableArray* myTextInfoArray;

@property (strong,nonatomic) NSString* myTextName;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;

@end

@implementation SearchTextViewController

@synthesize myTextArray=_myTextArray,myTextInfoArray=_myTextInfoArray;

#define RESET_DELAY 0.3

#define CELL_CONTENT_WIDTH 550.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_PADDING 60.0

#define FONT_NAME @"Georgia"
#define FONT_SIZE 20.0
#define IPAD_FONT [UIFont fontWithName: FONT_NAME size: FONT_SIZE]
#define IPAD_FONT_LARGE [UIFont fontWithName: FONT_NAME size: FONT_SIZE*1.4]

#warning - Click on box to go to text!

//
//
////////
#pragma mark - Button Press
////////
//
//

- (IBAction)searchButtonPress:(UIButton *)sender {
    [self englishSearchAction];
}

- (IBAction)hebrewSearchButton:(UIButton *)sender {
    [self hebrewSearchAction];
}

- (void) hebrewSearchAction {
    NSString* myText = self.searchTextField.text;
    if ([myText length]) {
        [self hebrewTextSearch:myText];
        [self.myTextTable reloadData];
    }
}

- (void) englishSearchAction {
    NSString* myText = self.searchTextField.text;
    if ([myText length]) {
        [self englishTextSearch:myText];
        [self.myTextTable reloadData];
    }
}

//
//
////////
#pragma mark - Search Action
////////
//
//

- (void) hebrewTextSearch : (NSString*) myString {
    NSArray*myentries = [self fetchLineTextFromHebrewWordSearch:myString withContext : self.managedObjectContext];
    
    [self.myTextArray removeAllObjects];
    [self.myTextInfoArray removeAllObjects];
    for (LineText* TLT in myentries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.hebrewName;
        
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        [self.myTextArray addObject:TLT.hebrewText];
        [self.myTextInfoArray addObject:myTextInfo];
    }
    
    NSString* myCountString = [NSString stringWithFormat:@"Word Count: %lu",(unsigned long)[self.myTextArray count]];
    self.wordCountLabel.text = myCountString;
}

- (void) englishTextSearch : (NSString*) myString {
    NSArray*myentries = [self fetchLineTextFromEnglishWordSearch:myString withContext : self.managedObjectContext];
    
    [self.myTextArray removeAllObjects];
    [self.myTextInfoArray removeAllObjects];
    for (LineText* TLT in myentries) {
        NSInteger line = [TLT.lineNumber integerValue]+1;
        NSInteger chapter = [TLT.chapterNumber integerValue]+1;
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.englishName;
        
        NSString* myTextInfo = [NSString stringWithFormat:@"Text: %@ Chapter: %ld Line: %ld",text,(long)chapter,(long)line];
        
        [self.myTextArray addObject:TLT.englishText];
        [self.myTextInfoArray addObject:myTextInfo];
    }
    
    NSString* myCountString = [NSString stringWithFormat:@"Word Count: %lu",(unsigned long)[self.myTextArray count]];
    self.wordCountLabel.text = myCountString;
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
    return [self.myTextArray count] ? [self.myTextArray count] : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    cell = [self setMyTextCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

//
////
//

- (UITableViewCell *) setMyTextCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* myString = [self.myTextArray objectAtIndex:indexPath.row];
    NSString * myInfo = [self.myTextInfoArray objectAtIndex:indexPath.row];
    if (myString != nil){
        cell.textLabel.text = myString;
        cell.textLabel.textAlignment = UIControlContentHorizontalAlignmentFill;
        cell.textLabel.font = IPAD_FONT;

        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if ([myInfo length]) {
            cell.detailTextLabel.text = myInfo;
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
#pragma mark - Table Height
////////
//
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGSize sizeEnglish;
    NSString* myString;
    if ([self.myTextArray count] > indexPath.row) {
        myString = [self.myTextArray objectAtIndex:indexPath.row];
    }
    if ([myString length]) {
        UIFont *myFont = [ UIFont fontWithName: FONT_NAME size: FONT_SIZE ];
        sizeEnglish = [self frameForText: myString sizeWithFont:myFont constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)];
        return sizeEnglish.height+CELL_PADDING;
    }
    else {
        return 55.0;
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
    [self viewStyleForLoad];
    //[self performSelector:@selector(initialLoad) withObject:nil afterDelay:RESET_DELAY];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}

//
//
////////
#pragma mark - Setters
////////
//
//

- (NSMutableArray *)myTextArray {
    if (!_myTextArray){
        _myTextArray = [[NSMutableArray alloc] init];
    }
    return _myTextArray;
}

- (NSMutableArray *)myTextInfoArray {
    if (!_myTextInfoArray){
        _myTextInfoArray = [[NSMutableArray alloc] init];
    }
    return _myTextInfoArray;
}

//
//
////////
#pragma mark - Test
////////
//
//

- (void) testSearch {
    NSArray*myentries = [self fetchLineTextFromEnglishWordSearch:@"lord" withContext : self.managedObjectContext];
    for (LineText* TLT in myentries) {
        NSInteger line = [TLT.lineNumber integerValue];
        NSInteger chapter = [TLT.chapterNumber integerValue];
        TextTitle* title = TLT.whatTextTitle;
        NSString* text = title.englishName;
        NSLog(@"-- Text: %@ Chapter %ld Line %ld --",text,(long)chapter,(long)line);
        NSLog(@"-- %@ --",TLT.englishText);
    }
}



@end
