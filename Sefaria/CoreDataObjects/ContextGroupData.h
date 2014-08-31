//
//  ContextGroupData.h
//  Sefaria
//
//  Created by MGM on 8/30/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContextGroup, ContextGroupComment, LineText;

@interface ContextGroupData : NSManagedObject

@property (nonatomic, retain) NSNumber * isComment;
@property (nonatomic, retain) NSNumber * isLineText;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) ContextGroup *whatContextGroup;
@property (nonatomic, retain) ContextGroupComment *whatComment;
@property (nonatomic, retain) LineText *whatLineText;

@end
