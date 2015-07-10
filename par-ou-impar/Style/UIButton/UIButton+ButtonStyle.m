//
//  UIButton+ButtonStyle.m
//  Schutz
//
//  Created by Taqtile on 2/3/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import "UIButton+ButtonStyle.h"

@implementation UIButton (ButtonStyle)

-(UIColor *)normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor {
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

-(UIColor *)highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted | UIControlStateSelected];
}

-(void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor {
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

-(UIImage *)normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage {
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}

-(UIImage *)highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

-(void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage {
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateSelected];
}

-(NSValue *)buttonContentEdgeInsets {
    return [NSValue valueWithUIEdgeInsets:self.contentEdgeInsets];
}

-(void)setButtonContentEdgeInsets:(NSValue *)buttonContentEdgeInsets {
    self.contentEdgeInsets = [buttonContentEdgeInsets UIEdgeInsetsValue];
}

-(NSValue *)buttonTitleEdgeInsets {
    return [NSValue valueWithUIEdgeInsets:self.titleEdgeInsets];
}

-(void)setButtonTitleEdgeInsets:(NSValue *)buttonTitleEdgeInsets {
    self.titleEdgeInsets = [buttonTitleEdgeInsets UIEdgeInsetsValue];
}

-(NSValue *)buttonImageEdgeInsets {
    return [NSValue valueWithUIEdgeInsets:self.imageEdgeInsets];
}

-(void)setButtonImageEdgeInsets:(NSValue *)buttonImageEdgeInsets {
    self.imageEdgeInsets = [buttonImageEdgeInsets UIEdgeInsetsValue];
}
@end
