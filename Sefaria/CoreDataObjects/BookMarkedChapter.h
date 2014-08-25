//
//  BookMarkedChapter.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BookMarkedChapter : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterNumber;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * displayNumber;
@property (nonatomic, retain) NSString * textTitle;

@end
