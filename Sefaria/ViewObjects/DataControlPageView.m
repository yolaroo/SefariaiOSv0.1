//
//  DataControlPage.m
//  Sefaria
//
//  Created by MGM on 7/19/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "DataControlPageView.h"

#import "MainFoundation+DataControlPageActions.h"


@interface DataControlPageView ()

@end

@implementation DataControlPageView

#define RESET_DELAY 1.0


- (IBAction)dataLoadButtonPress:(UIButton *)sender {
    @try {
        [self testLoad];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    
    //[self performSelector:@selector(testLoad) withObject:nil afterDelay:RESET_DELAY];

    //[self testLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
