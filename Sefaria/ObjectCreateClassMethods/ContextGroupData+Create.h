//
//  ContextGroupData+Create.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ContextGroupData.h"

@interface ContextGroupData (Create)

+ (ContextGroupData*) newContextGroupComment : (ContextGroup*) whatContextGroup
                            withGroupComment : (NSString*) theComment
                                 withContext : (NSManagedObjectContext*) context;

+ (ContextGroupData*) newContextGroupLineText : (ContextGroup*) whatContextGroup
                                 withLineText : (LineText*) theLineText
                                  withContext : (NSManagedObjectContext*) context;

@end
