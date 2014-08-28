//
//  FileRecursion.m
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "FileRecursion.h"



@interface FileRecursion ()
{
    int XYZ;
}

@property (nonatomic,strong) NSFileManager *myFileManager;
@property (nonatomic,strong) NSMutableArray *myPathNameArray;
@property (nonatomic,strong) NSMutableArray *myMenuNameArray;

@end

@implementation FileRecursion

@synthesize myFileManager=_myFileManager,myPathNameArray=_myPathNameArray,myMenuNameArray=_myMenuNameArray;

#define ROOT_DIRECTORY @"TextData"

#define DK 2
#define LOG if(DK == 1)



//
//
////
#pragma mark - Main Class
////
//
//

- (NSArray*) returnPath : (NSString*) pathName
{
    [self.myPathNameArray removeAllObjects];
    [self.myMenuNameArray removeAllObjects];
    [self menuBuildFromPath:pathName];
    return @[[self.myMenuNameArray copy],[self.myPathNameArray copy]];
}

- (void) menuBuildFromPath:(NSString*)pathName
{
    if([pathName length] <= 0) return;
    NSArray *fileNamesNextLevel = [self fullArrayReturn:pathName];
    for(int i = 0; i < [fileNamesNextLevel count]; i++)
    {
        NSString *nextLevelPathName = [pathName stringByAppendingPathComponent:[fileNamesNextLevel objectAtIndex:i]];
        [self.myPathNameArray addObject:nextLevelPathName];
    }
    self.myMenuNameArray = [NSMutableArray arrayWithArray:fileNamesNextLevel];
}

//
////
//

- (NSString*) resourcePath : (NSString*) pathName {
    return [[NSBundle mainBundle] pathForResource:pathName ofType:nil];
}

- (NSArray*) bundleArrayReturn : (NSString*)pathForResource {
    NSError* error;
    return [self.myFileManager contentsOfDirectoryAtPath:pathForResource error:&error];
}

- (NSArray*) fullArrayReturn : (NSString*) pathName  {
    return [self bundleArrayReturn:[self resourcePath: pathName]];
}

//
////
//

- (NSFileManager*) myFileManager {
    if(!_myFileManager) {
        _myFileManager = [NSFileManager defaultManager];
    }
    return _myFileManager;
}

//
////
//

- (NSMutableArray*) myPathNameArray {
    if(!_myPathNameArray) {
        _myPathNameArray = [[NSMutableArray alloc]init];
    }
    return _myPathNameArray;
}

- (NSMutableArray*) myMenuNameArray {
    if(!_myMenuNameArray) {
        _myMenuNameArray = [[NSMutableArray alloc]init];
    }
    return _myMenuNameArray;
}

//
//
////
#pragma mark - Mishnah Test
////
//
//



//
//
////
#pragma mark - Text List
////
//
//

- (NSArray*) textListOfMergeFiles
{
    XYZ = 0;
    NSMutableArray* myArray = [[NSMutableArray alloc]init];
    NSArray* myReturn =[self returnArrayBuilderForPath:myArray withPath : ROOT_DIRECTORY allowedDepth:8 findFilewithSuffix: @"merged.json"];
    LOG NSLog(@"-- %@ --",myReturn);
    [self pathCount:true];
    return [myReturn copy];
}

//
//
////
#pragma mark - Comment List
////
//
//

- (NSArray*) commentListOfMergeFiles
{
    XYZ = 0;
    NSMutableArray* myArray = [[NSMutableArray alloc]init];
    NSArray* myReturn =[self returnArrayBuilderForPath:myArray withPath : @"TextComments" allowedDepth:8 findFilewithSuffix: @"merged.json"];
    LOG NSLog(@"-- %@ --",myReturn);
    [self pathCount:true];
    return [myReturn copy];
}



//
////
//

- (void) simpleMenuArrayBuilderForPath:(NSString*)pathName allowedDepth:(NSInteger)depth findFilewithSuffix: (NSString*) theSuffix
{
    if(depth <= 0) return;
    if([pathName length] <= 0) return;
    NSArray *fileNamesNextLevel = [self fullArrayReturn:pathName];
    for(int i = 0; i < [fileNamesNextLevel count]; i++)
    {
        NSString *nextLevelPathName = [pathName stringByAppendingPathComponent:[fileNamesNextLevel objectAtIndex:i]];
        if ([nextLevelPathName hasSuffix:theSuffix]) {
            NSLog(@"%@", nextLevelPathName);
            [self pathCount:false];
        }
        if (depth == 1) {
            LOG NSLog(@"-- ILVL %d--",i);
            LOG NSLog(@"-- NH %@ --", nextLevelPathName);
            LOG NSLog(@"-- SFN %@ --", fileNamesNextLevel);
        }
        [self simpleMenuArrayBuilderForPath:nextLevelPathName allowedDepth:depth-1 findFilewithSuffix:theSuffix];
    }
}

//
//
//////
#pragma mark - Comment Recursion
//////
//
//

- (NSArray*) returnArrayBuilderForPath:(NSMutableArray*)theDataCollection withPath : (NSString*)pathName allowedDepth:(NSInteger)depth findFilewithSuffix: (NSString*) theSuffix
{
    if(depth <= 0) return [theDataCollection copy];
    if ([pathName length] <= 0) return [theDataCollection copy];
    NSArray * fileNamesNextLevel = [self fullArrayReturn:pathName];
    for(int i = 0; i < [fileNamesNextLevel count]; i++)
    {
        NSString *nextLevelPathName = [pathName stringByAppendingPathComponent:[fileNamesNextLevel objectAtIndex:i]];
        if ([nextLevelPathName hasSuffix:theSuffix]) {
            [theDataCollection addObject:nextLevelPathName];
            LOG NSLog(@"%@", nextLevelPathName);
            [self pathCount:false];
        }
        if (depth == 1) {
            LOG NSLog(@"-- ILVL %d--",i);
            LOG NSLog(@"-- NH %@ --", nextLevelPathName);
            LOG NSLog(@"-- SFN %@ --", fileNamesNextLevel);
        }
        [self returnArrayBuilderForPath: theDataCollection withPath: nextLevelPathName allowedDepth:depth-1 findFilewithSuffix:theSuffix];
    }
    return [theDataCollection copy];
}

//
//
//////
#pragma mark - Loop Count
//////
//
//

- (void) pathCount: (BOOL) displayNumber {
    XYZ++;
    if (displayNumber) {
        NSLog(@"--Count %d--", XYZ);
    }
}





//
//
////
#pragma mark - Test Class for Text
////
//
//


- (void) testClassForSingleTextExample
{
    [self simpleMenuArrayBuilderForPath:@"TextData" allowedDepth:1 findFilewithSuffix: @"json"];
    
    NSLog(@" -- ");
    
    [self simpleMenuArrayBuilderForPath:@"TextData/Talmud" allowedDepth:1 findFilewithSuffix: @"json"];
    
    NSLog(@" -- ");
    
    [self simpleMenuArrayBuilderForPath:@"TextData/Talmud/Yerushalmi" allowedDepth:1 findFilewithSuffix: @"json"];
    
    NSLog(@" -- ");
    
    [self simpleMenuArrayBuilderForPath:@"TextData/Talmud/Yerushalmi/Seder Moed" allowedDepth:1 findFilewithSuffix: @"json"];
    
    NSLog(@" -- ");
    
    [self simpleMenuArrayBuilderForPath:@"TextData/Talmud/Yerushalmi/Seder Moed/Jerusalem Talmud Beitzah" allowedDepth:1 findFilewithSuffix: @"json"];
    
    NSLog(@" -- ");
    
    [self simpleMenuArrayBuilderForPath:@"TextData/Talmud/Yerushalmi/Seder Moed/Jerusalem Talmud Beitzah/Hebrew" allowedDepth:1 findFilewithSuffix: @"json"];
}



@end
