//
//  UIView+UIViewStyle.m
//  Netshoes
//
//  Created by Taqtile on 4/23/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import "UIView+UIViewStyle.h"
#import "UIViewAttributes.h"

@implementation UIView (UIViewStyle)

-(UIColor *)borderColor {
    return [UIColor colorWithCGColor:[self.layer borderColor]];
}

-(void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"style"])
        [UIViewAttributes setStyle:value forView:self];
    else{}
}

@end
