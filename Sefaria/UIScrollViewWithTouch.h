//
//  UIScrollViewWithTouch.h
//  Picture Dictionary
//
//  Created by Pi on 4/8/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKit/UIScrollView.h"

@interface UIScrollViewWithTouch : UIScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;


@property (nonatomic) CGPoint touchPoint;
@property (strong, nonatomic) UIView* touchView;
@property (nonatomic) NSInteger objectTouchCenter;

@property (nonatomic) bool isShowingAlert;
@property (nonatomic) NSInteger tagForDelete;


@end
