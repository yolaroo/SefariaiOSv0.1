//
//  TitleGroupUIView.h
//  Sefaria
//
//  Created by MGM on 8/29/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleGroupUIView : UIView

@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* subTitleLabel;

@property (nonatomic) NSInteger thisViewHeight;

@property (nonatomic,strong) NSString* titleString;
@property (nonatomic,strong) NSString* theSubtitleString;

@end
