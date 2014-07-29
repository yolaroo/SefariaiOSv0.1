//
//  SefariaAppDelegate.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SefariaAppDelegate.h"

@implementation SefariaAppDelegate

@synthesize managedObjectContext=_managedObjectContext,persistentStoreCoordinator=_persistentStoreCoordinator,seedManagedObjectContext=_seedManagedObjectContext,seedPersistentStoreCoordinator=_seedPersistentStoreCoordinator,managedObjectModel=_managedObjectModel,seedManagedObjectModel=_seedManagedObjectModel;

#define NILLOG 2
#define LOG if(NILLOG == 1) //one is pass - two is normal


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

//
//
//////////
#pragma mark - Core Data stack
//////////
//
//

- (NSManagedObjectContext *) managedObjectContext {
    LOG NSLog(@"**MANAGED ATTEMPT**");
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    LOG NSLog(@"**MANAGED SUCCESS**");
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc]
                                       initWithConcurrencyType:
                                       NSMainQueueConcurrencyType];
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];
            
        }];
        _managedObjectContext = moc;
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    LOG NSLog(@"**PERS ATTEMPT**");
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    LOG NSLog(@"**PERS SUCCESS**");
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:
                                   [self managedObjectModel]];
    
    NSPersistentStoreCoordinator* psc = _persistentStoreCoordinator;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString* stringName = @"SafariaCoreData";
        NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",stringName];
        NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
        
        NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
        [pragmaOptions setObject:@"DELETE" forKey:@"journal_mode"];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                 pragmaOptions, NSSQLitePragmasOption,
                                 nil];
        
        /*
         NSDictionary *options = @{
         NSMigratePersistentStoresAutomaticallyOption : @YES,
         NSInferMappingModelAutomaticallyOption : @YES,
         };
         */
        
        [psc lock];
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                         URL:storeUrl
                                     options:options
                                       error:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
        }
        [psc unlock];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LOG NSLog(@"Persistent Store Added");
            
        });
    });
    return _persistentStoreCoordinator;
}


//
//
//////////
#pragma mark - Model
//////////
//
//

- (NSManagedObjectModel *) managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

//
//
//////////
#pragma mark - Core Data Utilities
//////////
//
//

- (NSString *) applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
}


@end
