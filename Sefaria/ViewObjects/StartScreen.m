//
//  StartScreen.m
//  Sefaria
//
//  Created by MGM on 7/5/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "StartScreen.h"
#import "SefariaAppDelegate.h"

@interface StartScreen ()
{
    bool retryload;
}

@property (strong, nonatomic) UIAlertView *myPermanentAlert;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;


@end

@implementation StartScreen

#define SHADOW_ALPHA 0.4f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

//
//
////////
#pragma mark - Alert View
////////
//
//

- (void) myPermanentAlert: (NSString*)myString
{
    self.myPermanentAlert = [[UIAlertView alloc]
                             initWithTitle:myString
                             message:@""
                             delegate:self
                             cancelButtonTitle:nil
                             otherButtonTitles:nil, nil];
    self.myPermanentAlert.cancelButtonIndex = -1;
    [self.myPermanentAlert setTag:10000];
    [self.myPermanentAlert show];
}

- (void) saveSoundDefaultsOnFirstLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"sound"];
    [defaults synchronize];
}

//
//
////////
#pragma mark - first check
////////
//
//

- (void) firstLoadCheck {
    if (![self hasFirstLoaded]){
        [self myPermanentAlert:@"Welcome, Loading Data"];
        
        [self saveSoundDefaultsOnFirstLoad];
        
        //[self performSelector:@selector(mainMigrate) withObject:nil afterDelay:5.0];
        [self performSelector:@selector(saveFirstLoadDefault) withObject:nil afterDelay:2.0];
    }
}


- (BOOL) hasFirstLoaded {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"firstLoad"] == TRUE) {
        return true;
    }
    else {
        return false;
    }
}

- (void) saveFirstLoadDefault {
    NSLog(@"-- Save first load state --");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:TRUE forKey:@"firstLoad"];
    [defaults synchronize];
    [self.myPermanentAlert dismissWithClickedButtonIndex:0 animated:YES];

}

- (void) mainMigrate { //probably needs the MOC to load first?
    NSLog(@"migrate action");
    SefariaAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    @try {
        [appDelegate migrateFromSeed];
    }
    @catch (NSException *exception) {
        NSLog(@"migrate exception %@",exception);
        if (!retryload){
            retryload = true;
            [self performSelector:@selector(mainMigrate) withObject:nil afterDelay:5.0];
        }
    }
    @finally {
        [self.myPermanentAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
}

//
//
////////
#pragma mark - Life Cycle
////////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self firstLoadCheck];
    [self viewStyleForLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//
//
////////
#pragma mark - View Style
////////
//
//

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}

- (void) viewShadow: (UIView*)shadowObject
{
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 100;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}


@end
