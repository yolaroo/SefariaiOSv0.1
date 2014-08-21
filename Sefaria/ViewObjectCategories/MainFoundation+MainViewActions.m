//
//  MainFoundation+MainViewActions.m
//  Sefaria
//
//  Created by MGM on 7/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation+MainViewActions.h"

@implementation MainFoundation (MainViewActions)


#pragma mark - Alert

- (void) emptyTextAlert
{
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"The Text is Empty"
                            message:@""
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"ok", nil];
    myAlert.cancelButtonIndex = -1;
    [myAlert setTag:1000];
    [myAlert show];
}

//
//
////
#pragma mark - Load BG Method
////
//
//

- (UIImage*) loadBGImage: (NSString*) nameOfBG
{
    if ([nameOfBG length]) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",nameOfBG] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:fileName];
        return image;
    }
    return nil;
}

//

//
//
////////
#pragma mark - AI
////////
//
//

- (void) startAI {
    if (self.myActivityIndicator) {
    } else {
    }
}

- (void) stopAI
{
    if (self.myActivityIndicator) {
        [self.myActivityIndicator stopAnimating];
        self.myActivityIndicator = nil;
    } else {
    }
}

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

//
//
////////
#pragma mark - View Bounce
////////
//
//

- (void) animateBouncingObjects : (NSArray*) viewGroup
{
    for (UIView* imageView in viewGroup) {
        CGPoint origin = imageView.center;
        CGPoint target = CGPointMake(imageView.center.x, imageView.center.y+10);
        CABasicAnimation *bounce = [CABasicAnimation animationWithKeyPath:@"position.y"];
        bounce.duration = 0.5;
        bounce.fromValue = [NSNumber numberWithInt:origin.y];
        bounce.toValue = [NSNumber numberWithInt:target.y];
        bounce.repeatCount = 2;
        bounce.autoreverses = YES;
        [imageView.layer addAnimation:bounce forKey:@"position"];
    }
}

//
//
////////
#pragma mark - NSAttributed String
////////
//
//



@end
