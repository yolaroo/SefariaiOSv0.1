//
//  RecursiveMenu.m
//  Sefaria
//
//  Created by MGM on 7/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RecursiveMenu.h"

@interface RecursiveMenu ()
{
    int XYZ;
}

@property (nonatomic,strong) NSFileManager *myFileManager;
@property (nonatomic) NSInteger depthCount;
@property (nonatomic,strong) NSMutableArray * myNumberArray;
@property (nonatomic,strong) NSMutableArray * myStringArray;

@end

@implementation RecursiveMenu

@synthesize myFileManager=_myFileManager,depthCount=_depthCount,myNumberArray=_myNumberArray,myStringArray=_myStringArray;


#define ROOT_DIRECTORY @"TextData"


- (id)init
{
    if ((self = [super init])) {

    }
    return self;
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
//
//////
//
//////
//
//

- (void) setNumberArray: (NSInteger) theNumber{
    NSString * myNumber = [NSString stringWithFormat:@"%ld",(long)theNumber];
    if ([self.myNumberArray count] <= self.depthCount){
        [self.myNumberArray insertObject: myNumber atIndex:self.depthCount];
    }
    else {
        [self.myNumberArray replaceObjectAtIndex:self.depthCount withObject:myNumber];
    }
}

- (void) setStringArray: (NSString*) myString {
    if (([self.myStringArray count]-1) <= self.depthCount){
        [self.myStringArray insertObject: [self fullArrayReturn:myString] atIndex:self.depthCount+1];
    }
    else {
        id objectTest = [self fullArrayReturn:myString];
        if (objectTest){
            [self.myStringArray replaceObjectAtIndex:self.depthCount+1 withObject:[self fullArrayReturn:myString]];
        }
        else {
            NSLog(@"Error - no object");
        }
    }
}

//
////
//

- (NSString*) comboString {
    NSMutableString* myString  = [[NSMutableString alloc]initWithString:ROOT_DIRECTORY];
    for (int ii = 0; ii < self.depthCount+1; ii++) {
        [myString appendString:@"/"];
        NSInteger myInt = [[self.myNumberArray objectAtIndex:ii]integerValue];
        NSString* aString = [[self.myStringArray objectAtIndex:ii]objectAtIndex:myInt];
        [myString appendString:aString];
    }
    return [myString copy];
}

//
////
//

- (void) stringCombo: (NSInteger)level withNumberCount:(NSInteger)i {
    
    self.depthCount = level;
    [self setNumberArray: i];
    NSString* myStringPath = [self comboString];
    if ([myStringPath hasSuffix:@"json"]) {
        NSLog(@"-- %@ --",myStringPath);
        XYZ++;
        //        NSLog(@" %d",XYZ);
        
    }
    else {
        [self setStringArray: myStringPath];
    }
}

//
//
//////
//
//////
//
//

- (void) recursiveMenu
{
    
    //[self advancedMenuArrayBuilder ];
    
    NSArray *fileNamesLevel1 = [self fullArrayReturn:ROOT_DIRECTORY];
    [self.myStringArray addObject:fileNamesLevel1];
    [self recursiveAction:0];
}

- (void) recursiveAction: (NSInteger) myCurrentDepth {
    if ([self.myStringArray count] > myCurrentDepth)
    {
        for(int i = 0; i < [[self.myStringArray objectAtIndex:myCurrentDepth] count]; i++)
        {
            [self stringCombo:myCurrentDepth withNumberCount:i];
            [self recursiveAction: myCurrentDepth + 1];
        }
    }
    else {
        //        NSLog(@"no more recursion");
    }
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

- (NSMutableArray*) myNumberArray {
    if (!_myNumberArray) {
        _myNumberArray = [[NSMutableArray alloc] init];
    }
    return _myNumberArray;
}

- (NSMutableArray*) myStringArray {
    if (!_myStringArray) {
        _myStringArray = [[NSMutableArray alloc] init];
    }
    return _myStringArray;
}

@end
