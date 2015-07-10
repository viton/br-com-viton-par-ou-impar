//
//  MainStylesheet.m
//  Netshoes
//
//  Created by Taqtile on 4/23/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import "MainStylesheet.h"
#import "BaseStylesheet.h"
#import "ViewStylesheet.h"
#import "LabelStylesheet.h"
#import "ButtonStylesheet.h"

#define CLASS_SUFFIX @"Stylesheet"

@implementation MainStylesheet
+ (NSDictionary *)stylesheet {
    NSMutableDictionary *mainDictionary = [[NSMutableDictionary alloc] init];
    
    [MainStylesheet importStylesheetClass:[BaseStylesheet class] toMainDictionary:mainDictionary];
    [MainStylesheet importStylesheetClass:[ViewStylesheet class] toMainDictionary:mainDictionary];
    [MainStylesheet importStylesheetClass:[LabelStylesheet class] toMainDictionary:mainDictionary];
    [MainStylesheet importStylesheetClass:[ButtonStylesheet class] toMainDictionary:mainDictionary];
    
    return mainDictionary;
}

+ (void)importStylesheetClass:(Class)stylesheetClass toMainDictionary:(NSMutableDictionary *)mainDictionary {
    if ([NSStringFromClass(stylesheetClass) rangeOfString:CLASS_SUFFIX].location == NSNotFound) {
    } else {
        [mainDictionary addEntriesFromDictionary:[stylesheetClass stylesheet]];
    }
}
@end
