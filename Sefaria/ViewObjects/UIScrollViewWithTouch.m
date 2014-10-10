//
//  UIScrollViewWithTouch.m
//  Picture Dictionary
//
//  Created by Pi on 4/8/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import "UIScrollViewWithTouch.h"

@implementation UIScrollViewWithTouch

#define DK 2
#define LOG if(DK == 1)

#define CENTER_X 330
#define TAG_BASE 20000

#define RESET_DELAY 0.3

//
//
////////
#pragma mark - Touches
////////
//
//

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    LOG NSLog(@"touchesShouldCancelInContentView");
    
    if (view.tag > 99) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void) touchesBegan : (NSSet *) touches withEvent : (UIEvent *) event
{
    UITouch * touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    self.touchView = [self hitTest:self.touchPoint withEvent:event];
    
    if (self.touchView.tag >= 20000){
        self.objectTouchCenter = self.touchView.center.x;
        LOG NSLog(@"x : %ld - y : %f",(long)self.objectTouchCenter,self.touchView.center.y);
    }
}

- (void) touchesMoved : (NSSet *) touches withEvent : (UIEvent *) event
{
    UITouch * touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    self.touchView = [self hitTest:self.touchPoint withEvent:event];
    
    if (self.touchView.tag > TAG_BASE){
        LOG NSLog(@"touch move %ld",(long)self.touchView.tag);
        
        CGPoint location = [touch locationInView:self];
        NSInteger previousTimestamp = event.timestamp;
        NSTimeInterval timeSincePrevious = event.timestamp - previousTimestamp;
        CGPoint prevLocation = [touch previousLocationInView:self];
        NSInteger velocity = (location.x - prevLocation.x) / timeSincePrevious;
        
        LOG NSLog(@"x : %f y : %f v : %ld",self.touchPoint.x,self.touchPoint.y,(long)velocity);
        if (velocity < -2) {
            CGPoint myPoint = CGPointMake(self.touchView.center.x-5,self.touchView.center.y);
            self.touchView.center = myPoint;
            self.tagForDelete = self.touchView.tag - TAG_BASE;
            [self animationFroSwipe];
        }
    }
}

#define ANIMATE_DURATION 0.6

- (void) animationFroSwipe {
    
    //NSLog(@"animation start");
    
    if (!self.isAnimating){
        self.isAnimating = true;
        [self viewDeepShadow : self.touchView];
        [UIView animateWithDuration : ANIMATE_DURATION
                              delay : 0
                            options : UIViewAnimationOptionCurveEaseIn
                         animations : ^{
                             CGPoint myPoint = CGPointMake(150,self.touchView.center.y);
                             self.touchView.center = myPoint;
                         }
                         completion:^(BOOL finished){
                             //empty
                             [self showAlert];
                             self.touchView.layer.shadowColor = [[UIColor clearColor] CGColor];

                             self.isAnimating = false;
                         }];
    }
}

- (void) touchesEnded : (NSSet *) touches withEvent : (UIEvent *) event
{
    UITouch * touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    self.touchView = [self hitTest:self.touchPoint withEvent:event];
    if (self.touchView.tag >= 20000){
        LOG NSLog(@"touch end %ld",(long)self.touchView.tag);
    }
}

//
//
////////
#pragma mark - Reset View
////////
//
//

- (void) showAlert {
    if(!self.isShowingAlert){
        self.isShowingAlert = true;
        [self showAlertWithYesAndNo];
    }
}

//
//
////////
#pragma mark - Alert
////////
//
//

- (void) showAlertWithYesAndNo
{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle : @"Delete Section"
                                                     message : @"" delegate:self
                                           cancelButtonTitle : @"NO"
                                           otherButtonTitles : @"YES", nil];
    [dialog setAlertViewStyle:UIAlertViewStyleDefault];
    [dialog show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex : (NSInteger) buttonIndex
{
    if (buttonIndex == 0) { // no
        self.isShowingAlert = false;
        CGPoint myPoint = CGPointMake( CENTER_X,self.touchView.center.y);
        self.touchView.center = myPoint;
    }
    if (buttonIndex == 1) { // yes
        self.isShowingAlert = false;
        [self deleteObject];
    }
}

- (void) deleteObject {
    LOG NSLog(@"delete notification");
    
    NSDictionary* data = @{@"numberIndexForDelete":[NSNumber numberWithInteger : self.tagForDelete]};
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"deleteSheetObject"
     object:self
     userInfo:data];
    
    self.tagForDelete = -1;
}

//
//
////////
#pragma mark - Setter
////////
//
//

- (void) setTouchPoint:(CGPoint)touchPoint
{
    _touchPoint =touchPoint;
}

- (void) setTouchView:(UIView*)touchView
{
    _touchView=touchView;
}

//
//
////////
#pragma mark - Shadow
////////
//
//

#define SHADOW_ALPHA 0.6f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

- (void) viewDeepShadow: (UIView*)shadowObject
{
    CGFloat radius = shadowObject.frame.size.width / 50;
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 5;
    shadowObject.layer.shadowOffset = CGSizeMake(6.0f, 6.0f);
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

//
//
////////
#pragma mark - Init
////////
//
//

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
