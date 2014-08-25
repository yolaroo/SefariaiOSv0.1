//
//  SpeechClass.m
//  Sefaria
//
//  Created by MGM on 7/9/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SpeechClass.h"
@import AVFoundation;

@interface SpeechClass () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) NSMutableArray* speechArray;
@property (nonatomic, strong) NSMutableString* speechString;
@property (nonatomic, strong) AVSpeechSynthesizer* mySpeechSynthesizer;
@property (nonatomic) NSInteger speechArrayCounter;
@property (nonatomic) BOOL speechIsPlaying;
@property (nonatomic) BOOL isSpeechOk;
@property (nonatomic, strong) NSMutableArray* speechQue;
@property (nonatomic) BOOL isClearingQue;
@property (nonatomic) BOOL soundSet;

@end

@implementation SpeechClass

@synthesize speechArray=_speechArray,speechString=_speechString;

#define DK 2
#define LOG if(DK == 1)

//
////
#pragma mark - init
////
//

- (id)init
{
    if ((self = [super init])) {
        [self loadDefaults];
    }
    return self;
}

//
////
#pragma mark - Public Functions
////
//

- (void) stopSpeech
{
    self.isSpeechOk = false;
}


- (void) changeSoundDefaults
{
    self.soundSet = !self.soundSet;
}

//
////
//

- (BOOL) runSpeech: (NSArray*) speechArray
{
    [self.mySpeechSynthesizer continueSpeaking ];
    if (self.speechIsPlaying)return true;
    if (!self.soundSet)return true;
    if (self.mySpeechSynthesizer.isSpeaking){
        if ([self.speechQue count] >=1){
            LOG NSLog(@"-- que full --");
            return true;
        }
        else {
            LOG NSLog(@"-- que empty --");
            [self.speechQue addObject:[speechArray firstObject]];
            if (!self.isClearingQue){
                LOG NSLog(@"-- que empty started --");
                self.isClearingQue = true;
                [self performSelector:@selector(clearQue) withObject:nil afterDelay:0.6];
            }
            return true;
        }
    }
    self.speechArrayCounter = 0;
    self.isSpeechOk = true;
    self.speechArray = [speechArray mutableCopy];
    [self speechAction];
    return false;
}

//
////
#pragma mark - Defaults
////
//

- (void) loadDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"sound"] == TRUE) {
        self.soundSet = false;
    }
    else {
        self.soundSet = true;
    }
}
//
////
#pragma mark - Main Functions
////
//

- (void) speechAction {
    if (!self.isSpeechOk) return;
    if (self.speechArrayCounter < [self.speechArray count]-1) {
        self.speechString = [self.speechArray objectAtIndex:self.speechArrayCounter];
        [self speechFunction:^(void){
            self.speechIsPlaying = false;
            self.speechArrayCounter ++;
            LOG NSLog(@"-- %lu - %ld --",(unsigned long)[self.speechArray count],(long)self.speechArrayCounter);
        }];
    }
    else if (self.speechArrayCounter == [self.speechArray count]-1) {
        self.speechString = [self.speechArray lastObject];
        [self speechFunction:^(void){
            LOG NSLog(@"-- LAST --");
            self.speechIsPlaying = false;
            self.speechArrayCounter ++;
        }];
    }
    else {
        LOG NSLog(@"-- speech error--");
    }
}

//
#pragma mark - Play Action
//

- (void) speechPlay :(NSString*)speechString {
    if (!self.isSpeechOk) return;
    self.speechIsPlaying = true;
    if ([speechString length] <= 0) return;
    LOG NSLog(@"-- Play Start --");
    
    AVSpeechUtterance *utterance =
    [AVSpeechUtterance speechUtteranceWithString:speechString];
    utterance.rate = AVSpeechUtteranceMaximumSpeechRate / 10.0f;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];    
    [self.mySpeechSynthesizer speakUtterance:utterance];
}

- (void) speechFunction: (void (^)(void)) completionHandler {
    if (!self.isSpeechOk) return;
    [self speechPlay:[self.speechString copy]];
    completionHandler();
};

- (void) lastSpeechFunction: (void (^)(void)) completionHandler {
    if (!self.isSpeechOk) return;
    [self speechPlay:[self.speechString copy]];
    completionHandler();
};

//
#pragma mark - AVSpeechSynthesizer delegate protocol
//

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
    if (!self.isSpeechOk){
        [self.mySpeechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        self.isSpeechOk = true;
        self.speechIsPlaying = false;
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)mySpeechSynthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    LOG NSLog(@"-- (string): %@ --",self.speechString);
    [self addQuePlay];
    [self performSelector:@selector(notifyOfFinish) withObject:nil afterDelay:.02];
    if (self.isSpeechOk && !self.mySpeechSynthesizer.isSpeaking) [self speechAction];
}

//
#pragma mark - Que
//

- (void) addQuePlay{
    if ([self.speechQue count] ==1){
        LOG NSLog(@"que play true");
        [self speechPlay:[self.speechQue firstObject]];
        [self performSelector:@selector(clearQue) withObject:nil afterDelay:.01];
    }
    else {
        LOG NSLog(@"que play false");
    }
    self.speechIsPlaying = false;
}

- (void) clearQue {
    LOG NSLog(@"que clear");
    [self.speechQue removeAllObjects];
    self.isClearingQue = false;
}

//
#pragma mark - notification
//

- (void) notifyOfFinish{
    if (!self.mySpeechSynthesizer.isSpeaking){
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"soundIsFinished"
         object:self];
    }
}

//
#pragma mark - init
//

- (NSMutableArray*) speechArray {
    if (!_speechArray) {
        _speechArray = [[NSMutableArray alloc] init];
    }
    return _speechArray;
}

- (NSMutableArray*) speechQue {
    if (!_speechQue) {
        _speechQue = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _speechQue;
}

- (NSMutableString*) speechString {
    if (!_speechString) {
        _speechString = [[NSMutableString alloc] init];
    }
    return _speechString;
}

- (AVSpeechSynthesizer *)mySpeechSynthesizer {
    if (!_mySpeechSynthesizer){
        _mySpeechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        _mySpeechSynthesizer.delegate = self;
    }
    return _mySpeechSynthesizer;
}

@end
