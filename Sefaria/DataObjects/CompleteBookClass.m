//
//  CompleteBookClass.m
//  Sefaria
//
//  Created by MGM on 7/14/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CompleteBookClass.h"

@implementation CompleteBookClass


- (NSArray*) foundationBooks
{
    return @[
             @"Chasidut",
             @"Halakhah",
             @"Kabbalah",
             @"Liturgy",
             @"Midrash",
             @"Mishnah",
             @"Musar",
             @"Talmud",
             @"Tanach",
             @"Tosefta",
             @"Philosophy",
             @"Other",
             @"Commentary",
             ];
}

//
//
/////
#pragma mark - Chasidut
/////
//
//

- (NSArray*) foundationChasidut
{
    return @[
             @"Ba'al Shem Tov on the Torah",
             @"Chiddushei HaRim Al HaTorah",
             @"Derekh Mitsvotekha",
             @"Kedushat Levi",
             @"Me'or Einayim",
             @"Mekor Mayyim Hayyim",
             @"Panim yafot",
             @"Sefer Shel Benonim",
             @"Tanya",
             ];
}

//
//
/////
#pragma mark - Halakhah
/////
//
//

- (NSArray*) foundationHalakhah
{
    return @[
             @"Arbaah Turim",
             @"Aruch HaShulchan",
             @"Be'er Mayim Chaim",
             @"Ben Ish Hai",
             @"Chofetz Chaim",
             @"Kitzur Shulchan Aruch",
             @"Kolbo",
             @"Maaseh Rav",
             @"Magen Avraham",
             @"Mishna Berura",
             @"Mishneh Berurah",
             @"Mishneh Torah",
             @"Sefer HaChinukh",
             @"Shulchan Aruch HaRav",
             @"Shulchan Arukh",
             @"Yalkut Yosef",
             ];
}

//
//
/////
#pragma mark - Kabbalah
/////
//
//


- (NSArray*) foundationKabbalah
{
    return @[

             @"Be'ur Eser S'firot",
             @"Pardes Rimonim",
             @"Sefer HaBahir",
             @"Sefer HaQanah",
             @"Sefer Yetzirah",
             @"Zohar",
             ];
}

//
//
/////
#pragma mark - Liturgy
/////
//
//


- (NSArray*) foundationLiturgy
{
    return @[
             @"Hadran",
             @"Pesach Haggadah",
             @"Siddur",
             ];
}

//
//
/////
#pragma mark - Midrash
/////
//
//

- (NSArray*) foundationMidrash
{
    return @[
             @"Bemidbar Rabbah",
             @"Bereishit Rabbah",
             @"Devarim Rabbah",
             @"Eichah Rabbah",
             @"Ein Yaakov",
             @"Esther Rabbah",
             @"Kohelet Rabbah",
             @"Legends of the Jews",
             @"Mekhilta",
             @"Midrash on Proverbs",
             @"Midrash Tanchuma",
             @"Midrash Tehilim",
             @"Pesikta de rav kahana ",
             @"Rut Rabba",
             @"Shemot Rabbah",
             @"Shir HaShirim Rabbah",
             @"Vayikra Rabbah",
             ];
}

//
//
/////
#pragma mark - Mishnah
/////
//
//

// L1
- (NSArray*) foundationMishnah
{
    return @[
             @"Seder Kodashim",
             @"Seder Moed",
             @"Seder Nashim",
             @"Seder Nezikin",
             @"Seder Tahorot",
             @"Seder Zeraim",
             ];
}

// L2
- (NSArray*) foundationMishnahSederKodashim
{
    return @[
             @"Mishnah Arakhin",
             @"Mishnah Bekhorot",
             @"Mishnah Chullin",
             @"Mishnah Keritot",
             @"Mishnah Kinnim",
             @"Mishnah Meilah",
             @"Mishnah Menachot",
             @"Mishnah Middot",
             @"Mishnah Tamid",
             @"Mishnah Temurah",
             @"Mishnah Zevachim",
             ];
}


- (NSArray*) foundationMishnahSederMoed
{
    return @[
             @"Mishnah Beitzah",
             @"Mishnah Chagigah",
             @"Mishnah Eruvin",
             @"Mishnah Megillah",
             @"Mishnah Moed Katan",
             @"Mishnah Pesachim",
             @"Mishnah Rosh Hashanah",
             @"Mishnah Shabbat",
             @"Mishnah Shekalim",
             @"Mishnah Sukkah",
             @"Mishnah Taanit",
             @"Mishnah Yoma",
             ];
}

- (NSArray*) foundationMishnahSederNashim
{
    return @[
             @"Mishnah Gittin",
             @"Mishnah Ketubot",
             @"Mishnah Kiddushin",
             @"Mishnah Nazir",
             @"Mishnah Nedarim",
             @"Mishnah Sotah",
             @"Mishnah Yevamot",
             ];
}

- (NSArray*) foundationMishnahSederNezikin
{
    return @[
             @"Mishnah Avodah Zarah",
             @"Mishnah Bava Batra",
             @"Mishnah Bava Kamma",
             @"Mishnah Bava Metzia",
             @"Mishnah Eduyot",
             @"Mishnah Horayot",
             @"Mishnah Makkot",
             @"Mishnah Sanhedrin",
             @"Mishnah Shevuot",
             @"Pirkei Avot",
             ];
}

- (NSArray*) foundationMishnahSederTahorot
{
    return @[
             @"Mishnah Kelim",
             @"Mishnah Makhshirin",
             @"Mishnah Mikvaot",
             @"Mishnah Negaim",
             @"Mishnah Niddah",
             @"Mishnah Oholot",
             @"Mishnah Oktzin",
             @"Mishnah Parah",
             @"Mishnah Tahorot",
             @"Mishnah Tevul Yom",
             @"Mishnah Yadayim",
             @"Mishnah Zavim",
             ];
}

- (NSArray*) foundationMishnahSederZeraim
{
    return @[
             @"Mishnah Berakhot",
             @"Mishnah Bikkurim",
             @"Mishnah Challah",
             @"Mishnah Demai",
             @"Mishnah Kilayim",
             @"Mishnah Maaser Sheni",
             @"Mishnah Maasrot",
             @"Mishnah Orlah",
             @"Mishnah Peah",
             @"Mishnah Sheviit",
             @"Mishnah Terumot",
             ];
}

//
//
/////
#pragma mark - Musar
/////
//
//

- (NSArray*) foundationMusar
{
    return @[
             @"Messilat Yesharim",
             ];
}

//
//
/////
#pragma mark - Philosophy
/////
//
//

- (NSArray*) foundationPhilosophy
{
    return @[
             @"Chovot Halevavot",
             @"Eight Chapters",
             @"Ein Ayah",
             @"For the Perplexed of the Generation",
             @"Guide for the Perplexed",
             @"Kad HaKemach",
             @"Netivot Olam",
             @"Orot HaKodesh",
             @"Sefer Kuzari",
             @"Shmonah Kevatzim",
             ];
}

//
//
/////
#pragma mark - Talmud
/////
//
//


// L1
- (NSArray*) foundationTalmud
{
    return @[
             @"Bavli",
             @"Yerushalmi",
             ];
}

//L2
- (NSArray*) foundationTalmudBavli
{
    return @[
             @"Seder Kodashim",
             @"Seder Moed",
             @"Seder Nashim",
             @"Seder Nezikin",
             @"Seder Tahorot",
             @"Seder Zeraim",
             ];
}

- (NSArray*) foundationTalmudYerushalmi
{
    return @[
             @"Seder Moed",
             @"Seder Nashim",
             @"Seder Nezikin",
             @"Seder Tahorot",
             @"Seder Zeraim",
             ];
}

//L3
- (NSArray*) foundationTalmudBavliSederKodashim
{
    return @[
             @"Arakhin",
             @"Bekhorot",
             @"Chullin",
             @"Keritot",
             @"Meilah",
             @"Menachot",
             @"Tamid",
             @"Temurah",
             @"Zevachim",
             ];
}

- (NSArray*) foundationTalmudBavliSederMoed
{
    return @[
             @"Beitzah",
             @"Chagigah",
             @"Eruvin",
             @"Megillah",
             @"Moed Katan",
             @"Pesachim",
             @"Rosh Hashanah",
             @"Shabbat",
             @"Sukkah",
             @"Taanit",
             @"Yoma",
             ];
}

- (NSArray*) foundationTalmudBavliSederNashim
{
    return @[
             @"Gittin",
             @"Ketubot",
             @"Kiddushin",
             @"Nazir",
             @"Nedarim",
             @"Sotah",
             @"Yevamot",
             ];
}

- (NSArray*) foundationTalmudBavliSederNezikin
{
    return @[
             @"Avodah Zarah",
             @"Bava Batra",
             @"Bava Kamma",
             @"Bava Metzia",
             @"Horayot",
             @"Makkot",
             @"Sanhedrin",
             @"Shevuot",
             ];
}

- (NSArray*) foundationTalmudBavliSederTahorot
{
    return @[
             @"Niddah",
             ];
}

- (NSArray*) foundationTalmudBavliSederZeraim
{
    return @[
             @"Berakhot",
             ];
}

//L3
- (NSArray*) foundationTalmudYerushalmiSederMoed
{
    return @[
             @"Jerusalem Talmud Beitzah",
             @"Jerusalem Talmud Chagigah",
             @"Jerusalem Talmud Eiruvin",
             @"Jerusalem Talmud Megillah",
             @"Jerusalem Talmud Moed Kattan",
             @"Jerusalem Talmud Pesachim",
             @"Jerusalem Talmud Rosh Hashanah",
             @"Jerusalem Talmud Shabbat",
             @"Jerusalem Talmud Shekalim",
             @"Jerusalem Talmud Sukkah",
             @"Jerusalem Talmud Ta'anit",
             @"Jerusalem Talmud Yoma",
             ];
}

- (NSArray*) foundationTalmudYerushalmiSederNashim
{
    return @[
             @"Jerusalem Talmud Gittin",
             @"Jerusalem Talmud Ketubot",
             @"Jerusalem Talmud Kiddushin",
             @"Jerusalem Talmud Nazir",
             @"Jerusalem Talmud Nedarim",
             @"Jerusalem Talmud Sotah",
             @"Jerusalem Talmud Yevamot",
             ];
}

- (NSArray*) foundationTalmudYerushalmiSederNezikin
{
    return @[
             @"Jerusalem Talmud Avodah Zarah",
             @"Jerusalem Talmud Bava Batra",
             @"Jerusalem Talmud Bava Kamma",
             @"Jerusalem Talmud Bava Metsia",
             @"Jerusalem Talmud Horayot",
             @"Jerusalem Talmud Makkot",
             @"Jerusalem Talmud Sanhedrin",
             @"Jerusalem Talmud Shevuot",
             ];
}

- (NSArray*) foundationTalmudYerushalmiSederTahorot
{
    return @[
             @"Jerusalem Talmud Niddah",
             ];
}

- (NSArray*) foundationTalmudYerushalmiSederZeraim
{
    return @[
             @"Jerusalem Talmud Berakhot",
             @"Jerusalem Talmud Bikkurim",
             @"Jerusalem Talmud Demai",
             @"Jerusalem Talmud Hallah",
             @"Jerusalem Talmud Kilayim",
             @"Jerusalem Talmud Ma'aser Sheni",
             @"Jerusalem Talmud Ma'asrot",
             @"Jerusalem Talmud Orlah",
             @"Jerusalem Talmud Peah",
             @"Jerusalem Talmud Shevi'it",
             @"Jerusalem Talmud Terumot",
             ];
}

//
//
/////
#pragma mark - Tosefta
/////
//
//


// L1
- (NSArray*) foundationTosefta
{
    return @[
             @"Seder Kodashim",
             @"Seder Moed",
             @"Seder Nashim",
             @"Seder Nezikin",
             @"Seder Toharot",
             @"Seder Zeraim",
             ];
}

//L2
- (NSArray*) foundationToseftaSederKodashim
{
    return @[
             @"Tosefta Arakhin",
             @"Tosefta Bekhorot",
             @"Tosefta Chullin",
             @"Tosefta Keritot",
             @"Tosefta Meilah",
             @"Tosefta Menahot",
             @"Tosefta Temurah",
             @"Tosefta Zevahim",
             ];
}

- (NSArray*) foundationToseftaSederMoed
{
    return @[
             @"Tosefta Beitsah",
             @"Tosefta Chagigah",
             @"Tosefta Eiruvin",
             @"Tosefta Megillah",
             @"Tosefta Moed Kattan",
             @"Tosefta Pesachim",
             @"Tosefta Rosh HaShanah",
             @"Tosefta Shabbat",
             @"Tosefta Shekalim",
             @"Tosefta Sukkah",
             @"Tosefta Ta'anit",
             @"Tosefta Yoma",
             ];
}

- (NSArray*) foundationToseftaSederNashim
{
    return @[
             @"Tosefta Gittin",
             @"Tosefta Ketubot",
             @"Tosefta Kiddushin",
             @"Tosefta Nazir",
             @"Tosefta Nedarim",
             @"Tosefta Sotah",
             @"Tosefta Yevamot",
             ];
}

- (NSArray*) foundationToseftaSederNezikin
{
    return @[
             @"Tosefta Avodah Zarah",
             @"Tosefta Bava Batra",
             @"Tosefta Bava Kamma",
             @"Tosefta Bava Metzia",
             @"Tosefta Eduyot",
             @"Tosefta Horayot",
             @"Tosefta Makkot",
             @"Tosefta Sanhedrin",
             @"Tosefta Shevuot",
             ];
}

- (NSArray*) foundationToseftaSederToharot
{
    return @[
             @"Tosefta Keilim Batra",
             @"Tosefta Keilim Kamma",
             @"Tosefta Keilim Metsia",
             @"Tosefta Makhshirin",
             @"Tosefta Mikvaot",
             @"Tosefta Negaim",
             @"Tosefta Niddah",
             @"Tosefta Ohalot",
             @"Tosefta Parah",
             @"Tosefta Tevul Yom",
             @"Tosefta Tohorot",
             @"Tosefta Uktsin",
             @"Tosefta Yadayim",
             @"Tosefta Zavim",
             ];
}

- (NSArray*) foundationToseftaSederZeraim
{
    return @[
             @"Tosefta Berakhot",
             @"Tosefta Bikkurim",
             @"Tosefta Challah",
             @"Tosefta Demai",
             @"Tosefta Kilaim",
             @"Tosefta Ma'aser Sheni",
             @"Tosefta Ma'asrot",
             @"Tosefta Orlah",
             @"Tosefta Peah",
             @"Tosefta Shevi'it",
             @"Tosefta Terumot",
             ];
}


















@end
