//
//  MainFoundation+MainViewActions.m
//  Sefaria
//
//  Created by MGM on 7/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+MainViewActions.h"

@implementation MainFoundation (MainViewActions)

- (BOOL) isLanguageHebrew : (NSString*) myString
{
    NSCharacterSet *hebrewCharacters = [NSCharacterSet characterSetWithCharactersInString:@"בבּאהדגחזוכּיטלךכנםמעסןףפפּקץצשׂשׁרתתּש"];
    if ([myString rangeOfCharacterFromSet:hebrewCharacters].location == NSNotFound) {
        return true;
    }else {
        return false;
    }
}


//
//
////////
#pragma mark - Chapter Number Array
////////
//
//

- (NSArray*) chapterNumberArray: (NSInteger) maxNumber
{
    NSMutableArray * myChapterArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < maxNumber; i++) {
        NSString* myString = [NSString stringWithFormat:@"Chapter %d",i+1];
        [myChapterArray addObject:myString];
        myString = nil;
    }
    return [myChapterArray copy];
}


//
//
////////
#pragma mark - View Style
////////
//
//

#define SHADOW_ALPHA 0.1f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

- (void) viewShadow: (UIView*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

//
////
//

- (UIImage*) getDarkBlurredImageWithTargetView:(UIView *)targetView
{
    CGSize size = targetView.frame.size;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, 0);
    [targetView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self blur: image];
}


- (UIImage*) blur:(UIImage*)theImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return returnImage;
}


@end
