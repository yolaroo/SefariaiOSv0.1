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
        LOG NSLog(@"x : %d - y : %f",self.objectTouchCenter,self.touchView.center.y);
    }
}

- (void) touchesMoved : (NSSet *) touches withEvent : (UIEvent *) event
{
    UITouch * touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    self.touchView = [self hitTest:self.touchPoint withEvent:event];
    
    if (self.touchView.tag > 20000){
        LOG NSLog(@"touch move %d",self.touchView.tag);
        
        CGPoint location = [touch locationInView:self];
        NSInteger previousTimestamp = event.timestamp;
        NSTimeInterval timeSincePrevious = event.timestamp - previousTimestamp;
        CGPoint prevLocation = [touch previousLocationInView:self];

        NSInteger velocity = (location.x - prevLocation.x) / timeSincePrevious;
        
        LOG NSLog(@"x : %f y : %f ",self.touchPoint.x,self.touchPoint.y);
        if (self.touchPoint.x < self.objectTouchCenter && velocity < -30) {
            CGPoint myPoint = CGPointMake(location.x,self.touchView.center.y);
            self.touchView.center = myPoint;
            self.tagForDelete = self.touchView.tag - TAG_BASE;
            [self performSelector:@selector(showAlert) withObject:nil afterDelay:RESET_DELAY];
        }
    }
}

- (void) touchesEnded : (NSSet *) touches withEvent : (UIEvent *) event
{
    UITouch * touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self];
    self.touchView = [self hitTest:self.touchPoint withEvent:event];
    if (self.touchView.tag >= 20000){
        LOG NSLog(@"touch end %d",self.touchView.tag);
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
