//
//  MenuBuilder.m
//  Sefaria
//
//  Created by MGM on 7/15/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MenuBuilderDataModel.h"

@implementation MenuBuilderDataModel

@synthesize theCompleteDictionary=_theCompleteDictionary,theCategoryList=_theCategoryList,theCompleteTextArray=_theCompleteTextArray,theBookTitle=_theBookTitle,theTextTitle=_theTextTitle;

+ (MenuBuilderDataModel*) newMenuBuilderDataModel {
    
    MenuBuilderDataModel* myTextClass = [[MenuBuilderDataModel alloc]init];
    
    NSString* filePathStringFromArray = @"SefariaTitle";
    
    NSString* fullString = [NSString stringWithFormat:@"%@",filePathStringFromArray];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: fullString ofType:@"json"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    //
    //
    //////
    //
    ////
    //
    //////
    //
    //
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSError *errorLevel = nil;

    // Level 1 names
    NSString *pathNameLevel1 = @"TextData";
    NSString *pathLevel1 = [[NSBundle mainBundle] pathForResource:pathNameLevel1 ofType:nil];
    NSArray *fileNamesLevel1 = [myFileManager contentsOfDirectoryAtPath:pathLevel1 error:&errorLevel];
    NSUInteger countLevel1 = [fileNamesLevel1 count];
    
    // Level 2 names
    NSMutableArray *mutableLevel2 = [NSMutableArray arrayWithCapacity:countLevel1];
    NSUInteger countLevel2;
    //
    NSUInteger countLevel3;

    for(int i=0;i<countLevel1;i++)
    {
        NSString *pathNameLevel2 = [NSString stringWithFormat:@"%@/%@",pathNameLevel1,[fileNamesLevel1 objectAtIndex:i]];
        NSString *pathLevel2 = [[NSBundle mainBundle] pathForResource:pathNameLevel2 ofType:nil];
        NSArray *fileNamesLevel2 = [myFileManager contentsOfDirectoryAtPath:pathLevel2 error:&errorLevel];
        [mutableLevel2 addObject:fileNamesLevel2];
    }
    
    // Level 3 names
    NSMutableArray *mutableLevel3 = [NSMutableArray arrayWithCapacity:countLevel1];
    //
    
    for(int i=0;i<countLevel1;i++)
    {
        //L2 count
        countLevel2 = [[mutableLevel2 objectAtIndex:i]count];
        for(int j = 0; j < countLevel2; j++)
        {
            
            NSString *pathNameLevel3 = [NSString stringWithFormat:@"%@/%@/%@",pathNameLevel1,
                                                                              [fileNamesLevel1 objectAtIndex:i],
                                                                              [[mutableLevel2 objectAtIndex:i]objectAtIndex:j]];

            
//            NSLog(@"--NM %@--",pathNameLevel3);
            NSString *pathLevel3 = [[NSBundle mainBundle] pathForResource:pathNameLevel3 ofType:nil];
            NSArray *fileNamesLevel3 = [myFileManager contentsOfDirectoryAtPath:pathLevel3 error:&errorLevel];
            
//            NSLog(@"--NM %@--",fileNamesLevel3);
            [mutableLevel3 addObject:fileNamesLevel3];

            
            // count x
            countLevel3 = [[mutableLevel3 objectAtIndex:j]count];
            NSLog(@"--L3C %lu --",(unsigned long)countLevel3);
            
            for(int k = 0; k < countLevel3; k++)
            {
                NSString *pathNameLevel4 = [NSString stringWithFormat:@"%@/%@/%@/%@",
                                            pathNameLevel1,
                                            [fileNamesLevel1 objectAtIndex:i],
                                            [[mutableLevel2 objectAtIndex:i]objectAtIndex:j],
                                            [[mutableLevel2 objectAtIndex:j]objectAtIndex:k]

                                            ];

                NSLog(@"--NM4 %@--",pathNameLevel4);

                
                
            }
            
            
        }
        
    }
    
    //L4 names
//    NSMutableArray *mutableLevel4 = [NSMutableArray arrayWithCapacity:countLevel1];
    //
    
    //L3 count
//    NSUInteger countLevel3;
    //
    
    for(int i=0;i<countLevel1;i++)
    {
        //L2 count
        countLevel2 = [[mutableLevel2 objectAtIndex:i]count];
        for(int j = 0; j < countLevel2; j++)
        {
            //L3 count
//            countLevel3 = [[mutableLevel3 objectAtIndex:j]count];
            
//            NSString *pathNameLevel3 = [NSString stringWithFormat:@"%@/%@/%@",pathNameLevel1,[fileNamesLevel1 objectAtIndex:i],[[mutableLevel2 objectAtIndex:i]objectAtIndex:j]];
//            NSLog(@"--NM %@--",pathNameLevel3);

            
//            NSLog(@"-- CL3 %lu --",(unsigned long)countLevel3);
//            for(int k = 0; k < countLevel3; k++)
//            {
//                NSString *pathNameLevel4 = [NSString stringWithFormat:@"%@/%@/%@/%@",pathNameLevel1,[fileNamesLevel1 objectAtIndex:i],[[mutableLevel2 objectAtIndex:i]objectAtIndex:j],[[mutableLevel3 objectAtIndex:k]firstObject] ];
//                NSLog(@"--PL4 %@ --",pathNameLevel4);

                
//            }
            
        }
        
    }
    
//    NSString *pathNameLevel4 = [NSString stringWithFormat:@"%@/%@/%@/%@",pathNameLevel1,[fileNamesLevel1 objectAtIndex:0],[[mutableLevel2 objectAtIndex:0]objectAtIndex:0], [mutableLevel3 objectAtIndex:0]];
//    NSLog(@"--^^ %@--",pathNameLevel4);

    
//    NSLog(@"-- FN1 %@ --",fileNamesLevel1);
//    NSLog(@"-- ML2 %@ --",mutableLevel2);
//    NSLog(@"-- ML3 %@ --",mutableLevel3);

    
    /*
    NSMutableArray *mutableLevel3 = [NSMutableArray arrayWithCapacity:countLevel1];
    for(int i=0;i<countLevel1;i++)
    {
        NSString *pathNameLevel2 = [NSString stringWithFormat:@"%@/%@",pathNameLevel1,[fileNamesLevel1 objectAtIndex:i]];
        NSString *pathLevel2 = [[NSBundle mainBundle] pathForResource:pathNameLevel2 ofType:nil];
        NSArray *fileNamesLevel2 = [myFileManager contentsOfDirectoryAtPath:pathLevel2 error:&errorLevel];
        [mutableLevel2 addObject:fileNamesLevel2];
    }
    */
    
    //
    
    //
    // NSJSONSerialization
    //
    NSError* error;
    myTextClass.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                        options:kNilOptions
                                                                          error:&error];
    
    //
    // The Data Lump
    //
    myTextClass.theCompleteTextArray = [myTextClass.theCompleteDictionary objectForKey:@"stuff"];
    
    /*
    NSUInteger bookArrayCount = [myTextClass.theCompleteTextArray count];
    NSLog(@"-- %lu --",(unsigned long)bookArrayCount);
    NSString*wordObjectByType;
    NSMutableArray *tempWordObjectArray = [NSMutableArray arrayWithCapacity:bookArrayCount];
    for(int i=0;i<bookArrayCount;i++)
    {
        wordObjectByType = [[[
                            myTextClass.theCompleteDictionary objectForKey:@"stuff"]
                            objectAtIndex:i]
                            objectForKey:@"category"];
        [tempWordObjectArray addObject:wordObjectByType];
    }
    myTextClass.theBookTitle = [NSArray arrayWithArray:tempWordObjectArray];
    NSLog(@"-- AR: %@ --",myTextClass.theBookTitle);
    */
    
    /*
    NSUInteger bookTextArrayCount = [myTextClass.theCompleteTextArray count];
    NSLog(@"-- %lu --",(unsigned long)bookTextArrayCount);
    NSString*wordTextObjectByType;
    NSMutableArray *tempWordObjectArray = [NSMutableArray arrayWithCapacity:bookTextArrayCount];
    for(int i=0;i<bookTextArrayCount;i++)
    {
        wordTextObjectByType = [[[
                            myTextClass.theCompleteDictionary objectForKey:@"stuff"]
                            objectAtIndex:i]
                            objectForKey:@"contents"];
        [tempWordObjectArray addObject:wordTextObjectByType];
    }
    myTextClass.theBookTitle = [NSArray arrayWithArray:tempWordObjectArray];
    NSLog(@"-- AR: %@ --",myTextClass.theBookTitle);
    */
    
    // lvl 2 count
    NSArray * wordTextObjectByType;
    wordTextObjectByType = [[[
                            myTextClass.theCompleteDictionary objectForKey:@"stuff"]
                            objectAtIndex:0]
                            objectForKey:@"contents"];

//    NSLog(@"-- (contents) %lu --",(unsigned long)[wordTextObjectByType count]);
    
    /*
    NSUInteger textArrayCount = [myTextClass.theCompleteTextArray count];
    NSLog(@"-- %lu --",(unsigned long)textArrayCount);
    NSString*textObjectByType;
    NSMutableArray *tempTextObjectArray = [NSMutableArray arrayWithCapacity:textArrayCount];
    for(int i=0;i<textArrayCount;i++)
    {
        textObjectByType = [[[[[
                            myTextClass.theCompleteDictionary objectForKey:@"stuff"]
                            objectAtIndex:0]
                            objectForKey:@"contents"]
                            objectAtIndex:i]
                            objectForKey:@"category"];
        [tempTextObjectArray addObject:textObjectByType];
    }
    myTextClass.theBookTitle = [NSArray arrayWithArray:tempTextObjectArray];
    NSLog(@"-- AR: %@ --",myTextClass.theBookTitle);
    */

    
    
    
    
    return myTextClass;
}

@end
