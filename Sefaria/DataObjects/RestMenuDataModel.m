//
//  RestMenuDataModel.m
//  Sefaria
//
//  Created by MGM on 8/17/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RestMenuDataModel.h"

@implementation RestMenuDataModel

@synthesize theCompleteDictionary=_theCompleteDictionary;;

+ (RestMenuDataModel*) myNewRestMenuDataLoader: (NSURL*) pathURL withData : (NSData*) myData withConnectionError: (NSError*) connectionError
{
    if (myData.length > 0 && connectionError == nil)
    {
        RestMenuDataModel* myTextDataModel = [[RestMenuDataModel alloc]init];

        //
        // NSJSONSerialization
        //

        NSError* error;
        myTextDataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                    options:kNilOptions
                                                                      error:&error];
        return myTextDataModel;
    }
    else {
        NSLog(@"Data Request Error - %@",connectionError);
        return nil;
    }
}

@end
