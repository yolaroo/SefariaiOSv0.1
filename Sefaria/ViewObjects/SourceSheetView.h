//
//  SourceSheetView.h
//  Sefaria
//
//  Created by MGM on 8/28/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainFoundation.h"

@interface SourceSheetView : MainFoundation <UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITextField *titleTextField;
    IBOutlet UITextView *titleTextView;
    IBOutlet UITextView *commentTextView;
    IBOutlet UITextField *searchTextField;
}

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end
