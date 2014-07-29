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
#pragma mark - Test Class
////
//
//

- (void) testClass
{
    //[self simpleMenuArrayBuilderForPath:ROOT_DIRECTORY allowedDepth:6 findFilewithSuffix: @"json"];
    //987
    
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
        }
        if (depth == 1) {
            NSLog(@"-- ILVL %d--",i);
            NSLog(@"-- NH %@ --", nextLevelPathName);
            NSLog(@"-- SFN %@ --", fileNamesNextLevel);
            
        }
        [self simpleMenuArrayBuilderForPath:nextLevelPathName allowedDepth:depth-1 findFilewithSuffix:theSuffix];
    }
}

@end
