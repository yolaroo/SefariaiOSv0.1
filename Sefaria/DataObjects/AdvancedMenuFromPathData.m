//
//  AdvancedMenuFromPathData.m
//  Sefaria
//
//  Created by MGM on 7/18/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "AdvancedMenuFromPathData.h"

@interface AdvancedMenuFromPathData ()
{
    int XYZ;
}
@property (nonatomic,strong) NSFileManager *myFileManager;
@property (nonatomic) NSInteger depthCount;
@property (nonatomic,strong) NSMutableArray * myNumberArray;
@property (nonatomic,strong) NSMutableArray * myStringArray;



@end

@implementation AdvancedMenuFromPathData

@synthesize myFileManager=_myFileManager;

#define ROOT_DIRECTORY @"TextData"

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
        id xyz = [self fullArrayReturn:myString];
        if (xyz){
            [self.myStringArray replaceObjectAtIndex:self.depthCount+1 withObject:[self fullArrayReturn:myString]];
        }
        else {
            NSLog(@"no id");
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
////
//


- (void) simpleMenuArrayBuilderForPath:(NSString*)pathToDecend allowedDepth:(int)depth
{
    if(depth == 0) return;
    
    NSArray *fileNamesNextLevel = [self fullArrayReturn:pathToDecend];
    for(int i = 0; i < [fileNamesNextLevel count]; i++)
    {
        NSString *nextLevelPathName = [pathToDecend stringByAppendingPathComponent:[fileNamesNextLevel objectAtIndex:i]];
        if ([nextLevelPathName hasSuffix:@"json"]) {
            NSLog(@"-- %@ --",nextLevelPathName);
            XYZ++;
            NSLog(@" %d",XYZ);
        }
        //NSLog(@"Looking at %@", nextLevelPathName);
        [self simpleMenuArrayBuilderForPath:nextLevelPathName allowedDepth:depth-1];
    }
}


- (void) recursiveMenu {
    
    
    [self simpleMenuArrayBuilderForPath:ROOT_DIRECTORY allowedDepth:7];

    //[self advancedMenuArrayBuilder ];
    
//    NSArray *fileNamesLevel1 = [self fullArrayReturn:ROOT_DIRECTORY];
//    [self.myStringArray addObject:fileNamesLevel1];
//    [self recursiveAction:0];
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

- (void) recursiveMenuOld
{
    NSArray *fileNamesLevel1 = [self fullArrayReturn:ROOT_DIRECTORY];
    
    [self.myStringArray addObject:fileNamesLevel1];
    
    for(int i = 0; i < [[self.myStringArray objectAtIndex:0] count]; i++)
    {
        [self stringCombo:0 withNumberCount:i];
        
        if ([self.myStringArray count] > 1) {
            
        }
        
        for(int j = 0; j < [[self.myStringArray objectAtIndex:1] count]; j++)
        {
            [self stringCombo:1 withNumberCount:j];
            
            if ([self.myStringArray count] > 2) {
                
            }
            
            for(int k = 0; k < [[self.myStringArray objectAtIndex:2] count]; k++)
            {
                [self stringCombo:2 withNumberCount:k];
                
                if ([self.myStringArray count] > 3)
                {
                for(int l = 0; l < [[self.myStringArray objectAtIndex:3] count]; l++)
                {
                    [self stringCombo:3 withNumberCount:l];
                    
                    if ([self.myStringArray count] > 4)
                    {
                    for(int m = 0; m < [[self.myStringArray objectAtIndex:4] count]; m++)
                    {
                        [self stringCombo:4 withNumberCount:m];
                        
                        if ([self.myStringArray count] > 5)
                        {
                        for(int n = 0; n < [[self.myStringArray objectAtIndex:5] count]; n++)
                        {
                            [self stringCombo:5 withNumberCount:n];
                        }
                        }
                    }
                    }
                }
                }
            }
        }
    }
}



- (void) advancedMenuArrayBuilder {
    NSArray *fileNamesLevel1 = [self fullArrayReturn:ROOT_DIRECTORY];
    
// 1804
// 728
    
    [self.myStringArray addObject:fileNamesLevel1];
    
    for(int i = 0; i < [[self.myStringArray objectAtIndex:0] count]; i++)
    {
        [self stringCombo:0 withNumberCount:i];

        NSString *pathNameLevel2 = [NSString stringWithFormat:@"%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i]];
        NSArray *fileNamesLevel2 = [self fullArrayReturn:pathNameLevel2];

        for(int j = 0; j < [[self.myStringArray objectAtIndex:1] count]; j++)
        {
            [self stringCombo:1 withNumberCount:j];

            NSString *pathNameLevel3 = [NSString stringWithFormat:@"%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j] ];
            NSArray *fileNamesLevel3 = [self fullArrayReturn:pathNameLevel3];
            
            for(int k = 0; k < [[self.myStringArray objectAtIndex:2] count]; k++)
            {
                [self stringCombo:2 withNumberCount:k];

                NSString *pathNameLevel4 = [NSString stringWithFormat:@"%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k]  ];
                NSArray *fileNamesLevel4 = [self fullArrayReturn:pathNameLevel4];

                for(int l = 0; l < [[self.myStringArray objectAtIndex:3] count]; l++)
                {
                    [self stringCombo:3 withNumberCount:l];
                    
                    NSString *pathNameLevel5 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l]  ];
                    NSArray *fileNamesLevel5 = [self fullArrayReturn:pathNameLevel5];

                    for(int m = 0; m < [fileNamesLevel5 count]; m++)
                    {
                        
                        [self stringCombo:4 withNumberCount:m];

                        NSString *pathNameLevel6 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l], [fileNamesLevel5 objectAtIndex:m] ];
                        NSArray *fileNamesLevel6 = [self fullArrayReturn:pathNameLevel6];
                        //NSLog(@"-- LVL 6.0 %@ -- ",pathNameLevel6);
                        
                        for(int n = 0; n < [fileNamesLevel6 count]; n++)
                        {
                            NSString *pathNameLevel7 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l], [fileNamesLevel5 objectAtIndex:m],[fileNamesLevel6 objectAtIndex:n] ];
                            NSArray *fileNamesLevel7 = [self fullArrayReturn:pathNameLevel7];
//                            NSLog(@"-- LVL 7.0 %@ -- ",pathNameLevel7);
                            
                            for(int o = 0; 0 < [fileNamesLevel7 count]; o++) //empty
                            {
                                //NSString *pathNameLevel8 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l], [fileNamesLevel5 objectAtIndex:m],[fileNamesLevel6 objectAtIndex:n],[fileNamesLevel7 objectAtIndex: o] ];
                                //NSArray *fileNamesLevel8 = [self fullArrayReturn:pathNameLevel8];
//                                NSLog(@"-- LVL 8.0 %@ -- ",pathNameLevel8);
                                
                            }
                        }
                    }
                }
            }
        }
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
