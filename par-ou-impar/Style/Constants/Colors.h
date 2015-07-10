//
//  Colors.h
//  Netshoes
//
//  Created by Taqtile on 4/10/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#ifndef Netshoes_Colors_h
#define Netshoes_Colors_h

// Color methods
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define HEXA(hexValue,a) [UIColor colorWithRed:((float)((hexValuergbValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValuergbValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValuergbValue & 0xFF))/255.0 alpha:a]

// New colors
#define COLOR_SWATCH_PRIMARY_COLOR             HEX(0x5B2B85)
#define COLOR_SWATCH_TERTIARY_COLOR            RGB(58, 208, 239)
#define COLOR_SWATCH_TERTIARY_DARK_COLOR       RGB(109, 172, 185)
#define COLOR_SWATCH_TERTIARY_DARKER_COLOR     RGB(34, 124, 143)
#define COLOR_SWATCH_ERROR                     RGB(250, 91, 100)
#define COLOR_SWATCH_SUCCESS                   RGB(73, 207, 170)
#define COLOR_SWATCH_PURPLE_DARK               RGB(91, 43, 133)

#define COLOR_SWATCH_CLEAR                     [UIColor clearColor]
#define COLOR_SWATCH_WHITE                     HEX(0xFFFFFF)
#define COLOR_SWATCH_BLACK                     HEX(0x000000)
#define COLOR_SWATCH_BLACK_80                  RGBA(0, 0, 0, 0.6)

#define COLOR_SWATCH_BLUE                      RGB(86, 206, 239)
#define COLOR_SWATCH_RED                       RGB(233, 106, 133)
#define COLOR_SWATCH_GREEN                     RGB(178, 215, 19)
#define COLOR_SWATCH_ORANGE                    RGB(234, 159, 58)
#define COLOR_SWATCH_PURPLE                    RGB(177, 178, 209)

#endif
