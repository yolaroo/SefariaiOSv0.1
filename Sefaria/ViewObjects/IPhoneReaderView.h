//
//  IPhoneReaderView.h
//  Sefaria
//
//  Created by MGM on 9/20/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface IPhoneReaderView : MainFoundation  <UIScrollViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *searchNavTextField;
}

@property (weak, nonatomic) IBOutlet UITextField *searchNavTextField;


@end
