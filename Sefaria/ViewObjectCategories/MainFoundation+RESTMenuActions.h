//
//  MainFoundation+RESTMenuActions.h
//  Sefaria
//
//  Created by MGM on 8/22/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (RESTMenuActions)

- (void) theZeroDepthMenuLoad;
- (void) basicRestMenuLoad : (NSInteger) indexPathRow;

- (bool) isMenuTextLevel : (NSArray*) myRestMenuData; //here for tests


@end
