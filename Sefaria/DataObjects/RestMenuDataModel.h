//
//  RestMenuDataModel.h
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestMenuDataModel : NSObject

//
// NSJSONSerialization
//
@property (strong, nonatomic) NSArray* theCompleteDictionary;

//
//
//
+ (RestMenuDataModel*) myNewRestMenuDataLoader: (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError;


@end
