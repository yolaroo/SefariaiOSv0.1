//
//  CommentListDataModel.m
//  Sefaria
//
//  Created by MGM on 7/31/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CommentListDataModel.h"

@implementation CommentListDataModel

@synthesize theCompleteDictionary=_theCompleteDictionary,theCategoryList=_theCategoryList,theCompleteTextArray=_theCompleteTextArray,theLanguage=_theLanguage,theTextName=_theTextName,theCommentator=_theCommentator;

#define DK 2
#define LOG if(DK == 1)

#define ROOT_PATH @"TextComments/Commentary/"

+ (CommentListDataModel*) newCommentDataLoader: (NSString*) filePathStringFromArray {
    
    LOG NSLog(@"-- CMDL --");
    CommentListDataModel* myCommentDataModel = [[CommentListDataModel alloc]init];
    
    NSString* fullString = [NSString stringWithFormat:@"%@%@",ROOT_PATH,filePathStringFromArray];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: fullString ofType:@"json"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    
    if (myData == nil) {
        NSLog(@"-- Error - FS %@ --",fullString);
        NSLog(@"nil data");
    }
    
    //
    // NSJSONSerialization
    //
    NSError* error;
    myCommentDataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                            options:kNilOptions
                                                                              error:&error];
    
    //
    // The Text
    //
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"text"]) {
        myCommentDataModel.theCompleteTextArray = [myCommentDataModel.theCompleteDictionary objectForKey:@"text"];
        LOG NSLog(@"-- Full Text: %@ --",myCommentDataModel.theCompleteTextArray);
    }
    else {
        LOG NSLog(@"Text Error");
        LOG NSLog(@"-- FullPath: %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    //
    // Titles
    //
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"title"]) {
        myCommentDataModel.theEnglishTitle = [myCommentDataModel.theCompleteDictionary objectForKey:@"title"];
        LOG NSLog(@"-- Title: %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"title"]);
    }
    else {
        LOG NSLog(@"Error for English Title");
        LOG NSLog(@"-- FullPath: %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"title"]);
        LOG NSLog(@"-- --");
    }
    
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"heTitle"]) {
        myCommentDataModel.theHebrewTitle = [myCommentDataModel.theCompleteDictionary objectForKey:@"heTitle"];
        LOG NSLog(@"-- Hebrew Title : %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"heTitle"]);
    }
    else {
        LOG NSLog(@"Error for Hebrew Title");
        LOG NSLog(@"-- FullPath : %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"commentaryBook"]) {
        myCommentDataModel.theTextName = [myCommentDataModel.theCompleteDictionary objectForKey:@"commentaryBook"];
        LOG NSLog(@"-- theTextName : %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"commentaryBook"]);
    }
    else {
        LOG NSLog(@"Error for commentaryBook");
        LOG NSLog(@"-- FullPath : %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"commentator"]) {
        myCommentDataModel.theCommentator = [myCommentDataModel.theCompleteDictionary objectForKey:@"commentator"];
        LOG NSLog(@"-- commentator : %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"commentator"]);
    }
    else {
        LOG NSLog(@"Error for commentator");
        LOG NSLog(@"-- FullPath : %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"language"]) {
        myCommentDataModel.theLanguage = [myCommentDataModel.theCompleteDictionary objectForKey:@"language"];
        LOG NSLog(@"-- language : %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"language"]);
    }
    else {
        LOG NSLog(@"Error for language");
        LOG NSLog(@"-- FullPath : %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    if ([myCommentDataModel.theCompleteDictionary objectForKey:@"length"]) {
        myCommentDataModel.theChapterCount = [[myCommentDataModel.theCompleteDictionary objectForKey:@"length"] integerValue];
        LOG NSLog(@"-- length : %@ --",[myCommentDataModel.theCompleteDictionary objectForKey:@"length"]);
    }
    else {
        LOG NSLog(@"Error for chapter length");
        LOG NSLog(@"-- FullPath : %@ --",filePathStringFromArray);
        LOG NSLog(@"-- --");
    }
    
    return myCommentDataModel;
}

- (NSArray*) superCommentList
{
    return @[
             @"Mishnah/Seder Kodashim/Mishnah Arakhin/Bartenura on Mishnah Arakhin/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Arakhin/Tosafot Yom Tov on Mishnah Arakhin/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Bekhorot/Bartenura on Mishnah Bekhorot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Bekhorot/Tosafot Yom Tov on Mishnah Bekhorot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Chullin/Bartenura on Mishnah Chullin/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Chullin/Tosafot Yom Tov on Mishnah Chullin/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Keritot/Bartenura on Mishnah Keritot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Keritot/Tosafot Yom Tov on Mishnah Keritot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Kinnim/Bartenura on Mishnah Kinnim/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Kinnim/Tosafot Yom Tov on Mishnah Kinnim/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Meilah/Bartenura on Mishnah Meilah/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Meilah/Tosafot Yom Tov on Mishnah Meilah/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Menachot/Bartenura on Mishnah Menachot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Menachot/Tosafot Yom Tov on Mishnah Menachot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Middot/Bartenura on Mishnah Middot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Middot/Tosafot Yom Tov on Mishnah Middot/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Tamid/Bartenura on Mishnah Tamid/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Tamid/Tosafot Yom Tov on Mishnah Tamid/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Temurah/Bartenura on Mishnah Temurah/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Temurah/Tosafot Yom Tov on Mishnah Temurah/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Zevachim/Bartenura on Mishnah Zevachim/Hebrew/merged",
             @"Mishnah/Seder Kodashim/Mishnah Zevachim/Tosafot Yom Tov on Mishnah Zevachim/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Beitzah/Bartenura on Mishnah Beitzah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Beitzah/Tosafot Yom Tov on Mishnah Beitzah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Chagigah/Bartenura on Mishnah Chagigah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Chagigah/Tosafot Yom Tov on Mishnah Chagigah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Eruvin/Bartenura on Mishnah Eruvin/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Eruvin/Tosafot Yom Tov on Mishnah Eruvin/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Megillah/Bartenura on Mishnah Megillah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Megillah/Tosafot Yom Tov on Mishnah Megillah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Moed Katan/Bartenura on Mishnah Moed Katan/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Moed Katan/Tosafot Yom Tov on Mishnah Moed Katan/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Pesachim/Bartenura on Mishnah Pesachim/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Pesachim/Tosafot Yom Tov on Mishnah Pesachim/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Rosh Hashanah/Bartenura on Mishnah Rosh Hashanah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Rosh Hashanah/Tosafot Yom Tov on Mishnah Rosh Hashanah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Shabbat/Bartenura on Mishnah Shabbat/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Shabbat/Tosafot Yom Tov on Mishnah Shabbat/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Shekalim/Bartenura on Mishnah Shekalim/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Shekalim/Tosafot Yom Tov on Mishnah Shekalim/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Sukkah/Bartenura on Mishnah Sukkah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Sukkah/Tosafot Yom Tov on Mishnah Sukkah/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Taanit/Bartenura on Mishnah Taanit/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Taanit/Tosafot Yom Tov on Mishnah Taanit/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Yoma/Bartenura on Mishnah Yoma/Hebrew/merged",
             @"Mishnah/Seder Moed/Mishnah Yoma/Tosafot Yom Tov on Mishnah Yoma/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Gittin/Bartenura on Mishnah Gittin/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Gittin/Tosafot Yom Tov on Mishnah Gittin/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Ketubot/Bartenura on Mishnah Ketubot/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Ketubot/Tosafot Yom Tov on Mishnah Ketubot/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Kiddushin/Bartenura on Mishnah Kiddushin/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Kiddushin/Tosafot Yom Tov on Mishnah Kiddushin/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Nazir/Bartenura on Mishnah Nazir/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Nazir/Tosafot Yom Tov on Mishnah Nazir/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Nedarim/Bartenura on Mishnah Nedarim/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Nedarim/Tosafot Yom Tov on Mishnah Nedarim/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Sotah/Bartenura on Mishnah Sotah/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Sotah/Tosafot Yom Tov on Mishnah Sotah/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Yevamot/Bartenura on Mishnah Yevamot/Hebrew/merged",
             @"Mishnah/Seder Nashim/Mishnah Yevamot/Tosafot Yom Tov on Mishnah Yevamot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Avodah Zarah/Bartenura on Mishnah Avodah Zarah/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Avodah Zarah/Tosafot Yom Tov on Mishnah Avodah Zarah/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Batra/Bartenura on Mishnah Bava Batra/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Batra/Tosafot Yom Tov on Mishnah Bava Batra/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Kamma/Bartenura on Mishnah Bava Kamma/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Kamma/Tosafot Yom Tov on Mishnah Bava Kamma/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Metzia/Bartenura on Mishnah Bava Metzia/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Bava Metzia/Tosafot Yom Tov on Mishnah Bava Metzia/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Eduyot/Bartenura on Mishnah Eduyot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Eduyot/Tosafot Yom Tov on Mishnah Eduyot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Horayot/Bartenura on Mishnah Horayot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Horayot/Tosafot Yom Tov on Mishnah Horayot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Makkot/Bartenura on Mishnah Makkot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Makkot/Tosafot Yom Tov on Mishnah Makkot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Sanhedrin/Bartenura on Mishnah Sanhedrin/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Sanhedrin/Tosafot Yom Tov on Mishnah Sanhedrin/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Shevuot/Bartenura on Mishnah Shevuot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Mishnah Shevuot/Tosafot Yom Tov on Mishnah Shevuot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Pirkei Avot/Bartenura on Pirkei Avot/English/merged",
             @"Mishnah/Seder Nezikin/Pirkei Avot/Bartenura on Pirkei Avot/Hebrew/merged",
             @"Mishnah/Seder Nezikin/Pirkei Avot/Tosafot Yom Tov on Pirkei Avot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Kelim/Bartenura on Mishnah Kelim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Kelim/Tosafot Yom Tov on Mishnah Kelim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Makhshirin/Bartenura on Mishnah Makhshirin/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Makhshirin/Tosafot Yom Tov on Mishnah Makhshirin/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Mikvaot/Bartenura on Mishnah Mikvaot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Mikvaot/Tosafot Yom Tov on Mishnah Mikvaot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Negaim/Bartenura on Mishnah Negaim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Negaim/Tosafot Yom Tov on Mishnah Negaim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Niddah/Bartenura on Mishnah Niddah/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Niddah/Tosafot Yom Tov on Mishnah Niddah/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Oholot/Bartenura on Mishnah Oholot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Oholot/Tosafot Yom Tov on Mishnah Oholot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Oktzin/Bartenura on Mishnah Oktzin/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Oktzin/Tosafot Yom Tov on Mishnah Oktzin/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Parah/Bartenura on Mishnah Parah/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Parah/Tosafot Yom Tov on Mishnah Parah/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Tahorot/Bartenura on Mishnah Tahorot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Tahorot/Tosafot Yom Tov on Mishnah Tahorot/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Tevul Yom/Bartenura on Mishnah Tevul Yom/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Tevul Yom/Tosafot Yom Tov on Mishnah Tevul Yom/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Yadayim/Bartenura on Mishnah Yadayim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Yadayim/Tosafot Yom Tov on Mishnah Yadayim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Zavim/Bartenura on Mishnah Zavim/Hebrew/merged",
             @"Mishnah/Seder Tahorot/Mishnah Zavim/Tosafot Yom Tov on Mishnah Zavim/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Berakhot/Bartenura on Mishnah Berakhot/English/merged",
             @"Mishnah/Seder Zeraim/Mishnah Berakhot/Bartenura on Mishnah Berakhot/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Berakhot/Tosafot Yom Tov on Mishnah Berakhot/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Bikkurim/Bartenura on Mishnah Bikkurim/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Bikkurim/Tosafot Yom Tov on Mishnah Bikkurim/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Challah/Bartenura on Mishnah Challah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Challah/Tosafot Yom Tov on Mishnah Challah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Demai/Bartenura on Mishnah Demai/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Demai/Tosafot Yom Tov on Mishnah Demai/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Kilayim/Bartenura on Mishnah Kilayim/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Kilayim/Tosafot Yom Tov on Mishnah Kilayim/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Maaser Sheni/Bartenura on Mishnah Maaser Sheni/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Maaser Sheni/Tosafot Yom Tov on Mishnah Maaser Sheni/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Maasrot/Bartenura on Mishnah Maasrot/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Maasrot/Tosafot Yom Tov on Mishnah Maasrot/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Orlah/Bartenura on Mishnah Orlah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Orlah/Tosafot Yom Tov on Mishnah Orlah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Peah/Bartenura on Mishnah Peah/English/merged",
             @"Mishnah/Seder Zeraim/Mishnah Peah/Bartenura on Mishnah Peah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Peah/Tosafot Yom Tov on Mishnah Peah/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Sheviit/Bartenura on Mishnah Sheviit/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Sheviit/Tosafot Yom Tov on Mishnah Sheviit/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Terumot/Bartenura on Mishnah Terumot/Hebrew/merged",
             @"Mishnah/Seder Zeraim/Mishnah Terumot/Tosafot Yom Tov on Mishnah Terumot/Hebrew/merged",
                          
             @"Tanach/Prophets/I Samuel/Rashi on I Samuel/Hebrew/merged",
             @"Tanach/Prophets/II Kings/Metzudat David on II Kings/English/merged",
             @"Tanach/Prophets/II Kings/Radak on II Kings/English/merged",
             @"Tanach/Prophets/II Kings/Ralbag on II Kings/English/merged",
             @"Tanach/Prophets/II Kings/Rashi on II Kings/English/merged",
             @"Tanach/Prophets/II Kings/Rashi on II Kings/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Ibn Ezra on Zechariah/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Malbim on Zechariah/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Metzudat David on Zechariah/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Metzudat Tzion on Zechariah/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Radak on Zechariah/Hebrew/merged",
             @"Tanach/Prophets/Zechariah/Rashi on Zechariah/Hebrew/merged",
             @"Tanach/Torah/Deuteronomy/Ibn Ezra on Deuteronomy/English/merged",
             @"Tanach/Torah/Deuteronomy/Ibn Ezra on Deuteronomy/Hebrew/merged",
             @"Tanach/Torah/Deuteronomy/Ramban on Deuteronomy/Hebrew/merged",
             @"Tanach/Torah/Deuteronomy/Rashi on Deuteronomy/English/merged",
             @"Tanach/Torah/Deuteronomy/Rashi on Deuteronomy/Hebrew/merged",
             @"Tanach/Torah/Exodus/Ha'amek Davar on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Ibn Ezra on Exodus/English/merged",
             @"Tanach/Torah/Exodus/Ibn Ezra on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Ramban on Exodus/English/merged",
             @"Tanach/Torah/Exodus/Ramban on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Rashbam on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Rashi on Exodus/English/merged",
             @"Tanach/Torah/Exodus/Rashi on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Sforno on Exodus/English/merged",
             @"Tanach/Torah/Exodus/Sforno on Exodus/Hebrew/merged",
             @"Tanach/Torah/Exodus/Shadal on Exodus/English/merged",
             @"Tanach/Torah/Genesis/Abravanel on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Baal HaTurim on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Baal HaTurim on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Ha'amek Davar on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Ibn Ezra on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Ibn Ezra on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Kli Yakar on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Meshech Chochma on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Penei Dovid on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Radak on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Radak on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Ramban on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Ramban on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Rashbam on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Rashbam on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Rashi on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Rashi on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Sepher Torat Elohim on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Sforno on Genesis/English/merged",
             @"Tanach/Torah/Genesis/Sforno on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Shadal on Genesis/Hebrew/merged",
             @"Tanach/Torah/Genesis/Toldot Aharon on Genesis/Hebrew/merged",
             @"Tanach/Torah/Leviticus/Ibn Ezra on Leviticus/English/merged",
             @"Tanach/Torah/Leviticus/Ibn Ezra on Leviticus/Hebrew/merged",
             @"Tanach/Torah/Leviticus/Ramban on Leviticus/English/merged",
             @"Tanach/Torah/Leviticus/Ramban on Leviticus/Hebrew/merged",
             @"Tanach/Torah/Leviticus/Rashi on Leviticus/English/merged",
             @"Tanach/Torah/Leviticus/Rashi on Leviticus/Hebrew/merged",
             @"Tanach/Torah/Leviticus/Shadal on Leviticus/English/merged",
             @"Tanach/Torah/Leviticus/Tiferet Yisrael on Leviticus/Hebrew/merged",
             @"Tanach/Torah/Numbers/Chizkuni on Numbers/Hebrew/merged",
             @"Tanach/Torah/Numbers/Ibn Ezra on Numbers/English/merged",
             @"Tanach/Torah/Numbers/Ibn Ezra on Numbers/Hebrew/merged",
             @"Tanach/Torah/Numbers/Ramban on Numbers/Hebrew/merged",
             @"Tanach/Torah/Numbers/Rashi on Numbers/English/merged",
             @"Tanach/Torah/Numbers/Rashi on Numbers/Hebrew/merged",
             @"Tanach/Torah/Numbers/Sforno on Numbers/Hebrew/merged",
             @"Tanach/Torah/Numbers/Shadal on Numbers/English/merged",
             @"Tanach/Writings/Job/Rashi on Job/Hebrew/merged",
             @"Tanach/Writings/Lamentations/Rashi on Lamentations/English/merged",
             @"Tanach/Writings/Psalms/Ibn Ezra on Psalms/English/merged",
             @"Tanach/Writings/Psalms/Rashi on Psalms/English/merged",
             @"Tanach/Writings/Psalms/Rashi on Psalms/Hebrew/merged"
             ];
}

@end
