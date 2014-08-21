//
//  SefariaAppDelegate.h
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;


@interface SefariaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSManagedObjectContext *seedManagedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *seedPersistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *seedManagedObjectModel;

@property (strong, nonatomic) NSURL* storeURL;
@property (strong, nonatomic) NSString* stringName;

- (void) migrateFromSeed;


@end
