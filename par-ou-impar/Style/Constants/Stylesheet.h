//
//  Stylesheet.h
//  Netshoes
//
//  Created by Taqtile on 4/24/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

/*****************
All constants in this file use the following pattern (in eBNF):
"PK_" class_name_without_ui "_" attribute_name

 ps: PK is an acronym for Property key, because all constant values are
 ,in fact, the properties you want to set in your UI class
*****************/

#ifndef Netshoes_Stylesheet_h
#define Netshoes_Stylesheet_h

#define PK_BUTTON_BORDER_COLOR                          @"borderColor"
#define PK_BUTTON_BORDER_WIDTH                          @"layer.borderWidth"
#define PK_BUTTON_LABEL_COLOR                           @"titleLabel.textColor"
#define PK_BUTTON_LABEL_FONT                            @"titleLabel.font"
#define PK_BUTTON_BACKGROUND_COLOR                      @"backgroundColor"
#define PK_BUTTON_CONTENT_HORIZONTAL_ALIGNMENT          @"contentHorizontalAlignment"
#define PK_BUTTON_TINT_COLOR                            @"tintColor"
// Created properties on UIButton+ButtonStyle
#define PK_BUTTON_NORMAL_BACKGROUND_IMAGE               @"normalBackgroundImage"
#define PK_BUTTON_NORMAL_TITLE_COLOR                    @"normalTitleColor"
#define PK_BUTTON_HIGHLIGHTED_BACKGROUND_IMAGE          @"highlightedBackgroundImage"
#define PK_BUTTON_HIGHLIGHTED_TITLE_COLOR               @"highlightedTitleColor"
#define PK_BUTTON_CONTENT_EDGE_INSETS                   @"buttonContentEdgeInsets"
#define PK_BUTTON_TITLE_EDGE_INSETS                     @"buttonTitleEdgeInsets"
#define PK_BUTTON_IMAGE_EDGE_INSETS                     @"buttonImageEdgeInsets"

#define PK_LABEL_FONT                                   @"font"
#define PK_LABEL_TEXT_COLOR                             @"textColor"
#define PK_LABEL_TEXT_ALIGNMENT                         @"textAlignment"
#define PK_LABEL_ADJUST_FONT_SIZE_TO_FIT_WIDTH          @"adjustsFontSizeToFitWidth"
#define PK_LABEL_NUMBER_OF_LINES                        @"numberOfLines"

#define PK_TEXTFIELD_BORDER_STYLE                       @"borderStyle"
#define PK_TEXTFIELD_FONT                               @"font"
#define PK_TEXTFIELD_TEXT_COLOR                         @"textColor"
#define PK_TEXTFIELD_TINT_COLOR                         @"tintColor"

#define PK_FLOATLABELED_TEXTFIELD_LABEL_FONT            @"floatingLabel.font"
#define PK_FLOATLABELED_TEXTFIELD_LABEL_COLOR           @"floatingLabelTextColor"
#define PK_FLOATLABELED_TEXTFIELD_LABEL_ACTIVE_COLOR    @"floatingLabelActiveTextColor"

#define PK_VIEW_BACKGROUND_COLOR                        @"backgroundColor"
#define PK_VIEW_MASKS_TO_BOUNDS                         @"layer.masksToBounds"
#define PK_VIEW_SHADOW_OFFSET                           @"layer.shadowOffset"
#define PK_VIEW_SHADOW_OPACITY                          @"layer.shadowOpacity"
#define PK_VIEW_BORDER_COLOR                            @"borderColor"
#define PK_VIEW_BORDER_WIDTH                            @"layer.borderWidth"
#define PK_VIEW_CORNER_RADIUS                           @"layer.cornerRadius"

#define PK_TEXT_VIEW_FONT                               NSFontAttributeName
#define PK_TEXT_VIEW_COLOR                              NSForegroundColorAttributeName

#endif
