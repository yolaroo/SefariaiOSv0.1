//
//  Comment.h
//  Sefaria
//
//  Created by MGM on 8/23/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CommentAuthor, CommentCollectionTitle, LineText, TextTitle;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterNumber;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * englishText;
@property (nonatomic, retain) NSString * hebrewText;
@property (nonatomic, retain) NSNumber * isEnglish;
@property (nonatomic, retain) NSNumber * isHebrew;
@property (nonatomic, retain) NSNumber * lineNumber;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSNumber * isBookmarked;
@property (nonatomic, retain) NSNumber * isUnliked;
@property (nonatomic, retain) NSNumber * isLiked;
@property (nonatomic, retain) CommentAuthor *whatAuthor;
@property (nonatomic, retain) CommentCollectionTitle *whatCollectionTitle;
@property (nonatomic, retain) LineText *whatLineText;
@property (nonatomic, retain) TextTitle *whatTextTitle;

@end
