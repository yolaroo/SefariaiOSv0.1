//
//  ContextGroupComment+Create.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroupComment.h"

@interface ContextGroupComment (Create)

+ (ContextGroupComment*) newContextGroupComment : (NSString*) theComment
                                  withDataGroup : (ContextGroupData*) whatDataGroup
                                    withContext : (NSManagedObjectContext*) context;

@end
