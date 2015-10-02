//
//  LabelStylesheet.m
//  SwiftStudies
//
//  Created by Taqtile on 7/8/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelStylesheet.h"
#import "Colors.h"
#import "Stylesheet.h"
#import "Fonts.h"

@implementation LabelStylesheet

+ (NSDictionary *)stylesheet {
    return @{
             @"H1_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_WHITE,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_LIGHT size:FONT_SIZE_MEDIUM]
                     },
             @"H2_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_WHITE,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_LIGHT size:FONT_SIZE_LARGE]
                     },
             @"H1_Bold_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_WHITE,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_BOLD size:FONT_SIZE_EXTRA_LARGE]
                     },
             @"Option_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_WHITE,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_CONDENSED size:FONT_SIZE_INTRO]
                     },
             @"Caption_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_BLACK_80,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_CONDENSED_BOLD size:FONT_SIZE_SMALL]
                     },
             @"Disclaimer_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_BLACK_80,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_LIGHT size:FONT_SIZE_SMALL]
                     },
             @"Intro_Label": @{
                     PK_LABEL_TEXT_COLOR: COLOR_SWATCH_WHITE_60,
                     PK_LABEL_FONT: [UIFont fontWithName:FONT_APP_BOLD size:FONT_SIZE_INTRO]
                     },
             };
}


@end
