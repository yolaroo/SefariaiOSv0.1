//
//  FileRecursion.h
//  Sefaria
//
//  Created by MGM on 7/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileRecursion : NSObject

- (NSArray*) textListOfMergeFiles;
- (NSArray*) commentListOfMergeFiles;


- (NSArray*) returnPath : (NSString*)pathName;




@end
