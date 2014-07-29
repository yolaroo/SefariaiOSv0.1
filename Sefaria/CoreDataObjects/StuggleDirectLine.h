//
//  StuggleDirectLine.h
//  Sefaria
//
//  Created by MGM on 7/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Struggle;

@interface StuggleDirectLine : NSManagedObject

@property (nonatomic, retain) NSString * bookTitle;
@property (nonatomic, retain) NSNumber * chapterNumber;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * lineNumber;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * textTitle;
@property (nonatomic, retain) Struggle *whatStruggle;

@end
