//
//  ButtonStyleSheet.m
//  par-ou-impar
//
//  Created by Taqtile on 7/10/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

#import "ButtonStylesheet.h"
#import <UIKit/UIKit.h>
#import "Colors.h"
#import "Stylesheet.h"
#import "Fonts.h"

@implementation ButtonStylesheet

+ (NSDictionary *)stylesheet {
    return @{
             @"Default_Button": @{
                     PK_BUTTON_NORMAL_TITLE_COLOR: COLOR_SWATCH_WHITE_60,
                     },
             };
}

@end
