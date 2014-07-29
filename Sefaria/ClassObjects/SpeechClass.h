//
//  SpeechClass.h
//  Sefaria
//
//  Created by MGM on 7/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechClass : NSObject

- (BOOL) runSpeech: (NSArray*) speechArray;
- (void) stopSpeech;
- (void) changeSoundDefaults;

@end
