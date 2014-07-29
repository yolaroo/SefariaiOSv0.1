//
//  MenuFromPathData.m
//  Sefaria
//
//  Created by MGM on 7/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MenuFromPathData.h"

@interface MenuFromPathData ()

@property (nonatomic,strong) NSFileManager *myFileManager;

@end

@implementation MenuFromPathData

@synthesize myFileManager=_myFileManager;

#define ROOT_DIRECTORY @"TextData"

//
////
//

- (void) simpleMenuArrayBuilder
{
    NSArray *fileNamesLevel1 = [self fullArrayReturn:ROOT_DIRECTORY];
    
    for(int i = 0; i < [fileNamesLevel1 count]; i++)
    {
        NSString *pathNameLevel2 = [NSString stringWithFormat:@"%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i]];
        NSArray *fileNamesLevel2 = [self fullArrayReturn:pathNameLevel2];
    
        for(int j = 0; j < [fileNamesLevel2 count]; j++)
        {
            NSString *pathNameLevel3 = [NSString stringWithFormat:@"%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j] ];
            NSArray *fileNamesLevel3 = [self fullArrayReturn:pathNameLevel3];
            
            for(int k = 0; k < [fileNamesLevel3 count]; k++)
            {
                NSString *pathNameLevel4 = [NSString stringWithFormat:@"%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k]  ];
                NSArray *fileNamesLevel4 = [self fullArrayReturn:pathNameLevel4];
                
                for(int l = 0; l < [fileNamesLevel4 count]; l++)
                {
                    NSString *pathNameLevel5 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l]  ];
                    NSArray *fileNamesLevel5 = [self fullArrayReturn:pathNameLevel5];
                    
                    for(int m = 0; m < [fileNamesLevel5 count]; m++)
                    {
                        NSString *pathNameLevel6 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l], [fileNamesLevel5 objectAtIndex:m] ];
                        NSArray *fileNamesLevel6 = [self fullArrayReturn:pathNameLevel6];
                        NSLog(@"-- LVL 6.0 %@ -- ",pathNameLevel6);

                        for(int n = 0; n < [fileNamesLevel6 count]; n++)
                        {
                            NSString *pathNameLevel7 = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@%@",ROOT_DIRECTORY,[fileNamesLevel1 objectAtIndex:i],[fileNamesLevel2 objectAtIndex:j],[fileNamesLevel3 objectAtIndex:k],[fileNamesLevel4 objectAtIndex:l], [fileNamesLevel5 objectAtIndex:m],[fileNamesLevel6 objectAtIndex:n] ];
                            //NSArray *fileNamesLevel7 = [self fullArrayReturn:pathNameLevel7];
                            NSLog(@"-- LVL 7.0 %@ -- ",pathNameLevel7);
                            
                            
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

    @end
