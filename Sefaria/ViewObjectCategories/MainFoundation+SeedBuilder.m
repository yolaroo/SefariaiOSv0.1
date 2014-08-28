//
//  MainFoundation+SeedBuilder.m
//  Sefaria
//
//  Created by MGM on 8/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+SeedBuilder.h"

@implementation MainFoundation (SeedBuilder)

#define DK 2
#define LOG if(DK == 1)

- (void) saveSeedToDesktop
{
    NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",@"SafariaCoreData"];
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
    NSString *storeUrl = [NSURL fileURLWithPath:storePath];
    
    NSString* deskStorePath = [NSString stringWithFormat:@"/Users/%@/Desktop/newMySQL.CDBStore", NSUserName()];
    
    NSFileManager * fileManager = [ NSFileManager defaultManager];
    
    NSError*error;
    if (![fileManager copyItemAtPath:storeUrl toPath: deskStorePath error:&error]){
        NSLog(@"error with path");
    }
    else {
        LOG NSLog(@"Copied");
    }
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
}

@end
