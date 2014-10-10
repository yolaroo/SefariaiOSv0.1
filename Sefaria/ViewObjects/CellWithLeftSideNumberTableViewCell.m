//
//  CellWithLeftSideNumberTableViewCell.m
//  Sefaria
//
//  Created by MGM on 8/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CellWithLeftSideNumberTableViewCell.h"


@interface CellWithLeftSideNumberTableViewCell ()


@end

@implementation CellWithLeftSideNumberTableViewCell

@synthesize numberLabel=_numberLabel;

#define ACC_FONT_NAME @"HelveticaNeue-Light"
#define ACC_FONT_SIZE 10.0

- (void)awakeFromNib
{
    [self addSubview:self.numberLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    NSString* myLineNumber = [NSString stringWithFormat:@"%ld",(long)self.tag+1];
    _numberLabel.text = myLineNumber;
    CGRect myRect = CGRectMake(0,0,30,self.frame.size.height);
    _numberLabel.frame = myRect;
}

- (UILabel*) numberLabel
{
    CGRect myRect = CGRectMake(0,0,30,self.frame.size.height);
    _numberLabel = [[UILabel alloc]initWithFrame:myRect];
    _numberLabel.textColor = [UIColor grayColor];
    _numberLabel.text = @"0";
    _numberLabel.font = [UIFont fontWithName: ACC_FONT_NAME size:ACC_FONT_SIZE];
    _numberLabel.textAlignment = NSTextAlignmentNatural;
    _numberLabel.tag = 5000;
    return _numberLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}



@end
