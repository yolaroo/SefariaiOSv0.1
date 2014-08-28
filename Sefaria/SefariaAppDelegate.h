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

@property (strong, nonatomic) NSURL* storeURL;
@property (strong, nonatomic) NSString* stringName;

@property (nonatomic) BOOL screenIsPortraitOnly;

@end
