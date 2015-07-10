//
//  UIViewAttributes.m
//  Netshoes
//
//  Created by Taqtile on 4/23/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import "UIViewAttributes.h"
#import "MainStylesheet.h"

@implementation UIViewAttributes

/**
 Name convention:
    style == user input ( == in HTML, what the user would put inside class="...")
    styleContainter == css class
    styleContainterName == css class name
    styleKey == css style rule
    styleValue == css style value
 **/
+(void) setStyle:(NSString*) style forView:(UIView*) view {
    static NSDictionary *mainStylesheet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainStylesheet = [MainStylesheet stylesheet];
    });
    
    // Apply base rules
    NSDictionary *styleContainer = mainStylesheet[NSStringFromClass([view class])];
    for(NSString *styleKey in styleContainer) {
        [self applyStyleRuleWithStyleKey:styleKey fromStylesheet:styleContainer onView:view];
    }
    
    //Apply component specific rules
    [self applyEachStyleContainerFromStyle:style fromMainStylesheet:mainStylesheet onView:view];
}

#pragma mark - private

+ (void)applyStyleRuleWithStyleKey:(NSString *)style fromStylesheet:(NSDictionary *)stylesheet onView:(UIView *)view {
    NSArray *properties = [style componentsSeparatedByString:@"."];
    id object = [UIViewAttributes elementToApplyStyleKey:style fromView:view properties:properties];
    
    if ([object respondsToSelector:NSSelectorFromString([properties lastObject])]) {
        [object setValue:[stylesheet objectForKey:style] forKey:[properties lastObject]];
    } else {
        
    }
}

/**
 gets the element (UIView, CALayer) to apply a styleValue. For instance, if styleKey is @"layer.borderWidth", then this method will return the CALayer of the view.
 **/
+ (id)elementToApplyStyleKey:(NSString *)styleKey fromView:(UIView *)view properties:(NSArray *)properties{
    id object = view;
    for (int i = 0; i < [properties count] - 1; i++) {
        if ([object respondsToSelector:NSSelectorFromString(properties[i])]) {
            object = [object valueForKey:properties[i]];
        } else {
        }
    }
    return  object;
}

/**
 This method get each style container the user has entered (for instance, it will get [@"a" , @"b"] from @"a b") and apply the style rules from it on the View.
 **/
+ (void)applyEachStyleContainerFromStyle:(NSString *)style fromMainStylesheet:(NSDictionary *)mainStylesheet onView:(UIView *)view {
    NSMutableArray *styleContainerNameArray = [[style componentsSeparatedByString:@" "] mutableCopy];
    [styleContainerNameArray removeObject:@""];
    
    for (NSString *styleContainerName in styleContainerNameArray) {
        NSDictionary *styleContainer = mainStylesheet[styleContainerName];
        for(NSString *styleKey in styleContainer) {
            [self applyStyleRuleWithStyleKey:styleKey fromStylesheet:styleContainer onView:view];
        }
    }
}

@end
