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
- (NSArray*) foundationMishnahSederKodashim //text level
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


- (NSArray*) foundationMishnahSederMoed //text level
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

- (NSArray*) foundationMishnahSederNashim  //text level
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

- (NSArray*) foundationMishnahSederNezikin  //text level
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

- (NSArray*) foundationMishnahSederTahorot //text level
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

- (NSArray*) foundationMishnahSederZeraim  //text level
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

//
////
//

- (NSArray*) completeMishnahFileLocation
{
    return @[
        @"Mishnah/Seder Kodashim/Mishnah Arakhin/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Arakhin/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Bekhorot/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Bekhorot/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Chullin/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Chullin/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Keritot/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Keritot/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Kinnim/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Kinnim/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Meilah/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Meilah/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Menachot/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Menachot/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Middot/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Middot/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Tamid/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Tamid/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Temurah/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Temurah/Hebrew/merged",
        @"Mishnah/Seder Kodashim/Mishnah Zevachim/English/merged",
        @"Mishnah/Seder Kodashim/Mishnah Zevachim/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Beitzah/English/merged",
        @"Mishnah/Seder Moed/Mishnah Beitzah/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Chagigah/English/merged",
        @"Mishnah/Seder Moed/Mishnah Chagigah/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Eruvin/English/merged",
        @"Mishnah/Seder Moed/Mishnah Eruvin/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Megillah/English/merged",
        @"Mishnah/Seder Moed/Mishnah Megillah/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Moed Katan/English/merged",
        @"Mishnah/Seder Moed/Mishnah Moed Katan/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Pesachim/English/merged",
        @"Mishnah/Seder Moed/Mishnah Pesachim/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Rosh Hashanah/English/merged",
        @"Mishnah/Seder Moed/Mishnah Rosh Hashanah/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Shabbat/English/merged",
        @"Mishnah/Seder Moed/Mishnah Shabbat/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Shekalim/English/merged",
        @"Mishnah/Seder Moed/Mishnah Shekalim/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Sukkah/English/merged",
        @"Mishnah/Seder Moed/Mishnah Sukkah/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Taanit/English/merged",
        @"Mishnah/Seder Moed/Mishnah Taanit/Hebrew/merged",
        @"Mishnah/Seder Moed/Mishnah Yoma/English/merged",
        @"Mishnah/Seder Moed/Mishnah Yoma/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Gittin/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Gittin/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Ketubot/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Ketubot/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Kiddushin/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Kiddushin/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Nazir/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Nazir/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Nedarim/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Nedarim/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Sotah/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Sotah/Hebrew/merged",
        @"Mishnah/Seder Nashim/Mishnah Yevamot/English/merged",
        @"Mishnah/Seder Nashim/Mishnah Yevamot/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Avodah Zarah/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Avodah Zarah/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Batra/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Batra/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Kamma/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Kamma/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Metzia/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Bava Metzia/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Eduyot/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Eduyot/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Horayot/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Horayot/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Makkot/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Makkot/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Sanhedrin/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Sanhedrin/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Mishnah Shevuot/English/merged",
        @"Mishnah/Seder Nezikin/Mishnah Shevuot/Hebrew/merged",
        @"Mishnah/Seder Nezikin/Pirkei Avot/English/merged",
        @"Mishnah/Seder Nezikin/Pirkei Avot/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Kelim/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Kelim/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Makhshirin/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Makhshirin/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Mikvaot/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Mikvaot/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Negaim/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Negaim/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Niddah/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Niddah/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Oholot/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Oholot/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Oktzin/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Oktzin/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Parah/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Parah/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Tahorot/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Tahorot/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Tevul Yom/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Tevul Yom/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Yadayim/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Yadayim/Hebrew/merged",
        @"Mishnah/Seder Tahorot/Mishnah Zavim/English/merged",
        @"Mishnah/Seder Tahorot/Mishnah Zavim/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Berakhot/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Berakhot/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Bikkurim/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Bikkurim/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Challah/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Challah/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Demai/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Demai/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Kilayim/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Kilayim/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Maaser Sheni/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Maaser Sheni/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Maasrot/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Maasrot/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Orlah/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Orlah/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Peah/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Peah/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Sheviit/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Sheviit/Hebrew/merged",
        @"Mishnah/Seder Zeraim/Mishnah Terumot/English/merged",
        @"Mishnah/Seder Zeraim/Mishnah Terumot/Hebrew/merged",
    ];
}















@end
