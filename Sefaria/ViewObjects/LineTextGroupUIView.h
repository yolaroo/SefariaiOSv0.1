//
//  LineTextGroupUIView.h
//  Sefaria
//
//  Created by MGM on 8/28/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineText.h"
#import "TextTitle.h"
#import <QuartzCore/QuartzCore.h>

@interface LineTextGroupUIView : UIView

@property (nonatomic,strong) UILabel* englishLabel;
@property (nonatomic,strong) UILabel* hebrewLabel;
@property (nonatomic,strong) UILabel* infoLabel;

@property (nonatomic) NSInteger thisViewHeight;
@property (nonatomic) NSInteger depth;

@property (nonatomic) NSInteger superViewWidth;

@property (nonatomic) NSInteger leftMargin;
@property (nonatomic) NSInteger topMargin;

@property (nonatomic,weak) LineText* theLineText;

@end
