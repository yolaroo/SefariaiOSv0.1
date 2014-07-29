//
//  MainFoundation+MenuActions.h
//  Sefaria
//
//  Created by MGM on 7/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (MenuActions)


- (NSString*) objectName: (NSManagedObject*)myObject;

- (NSArray*) setMenuFromDepth: (NSString*)myString;

- (void) tableViewMenuAction:(NSInteger)tableViewTag didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) menuForTorahAction : (NSInteger) buttonNumber;


@end
