//
//  UIColor+colorFromDictionary.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/18/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (colorFromDictionary)

- (NSDictionary *)dictionaryWithRGBAValues;
+ (UIColor *)colorFromDictionary:(NSDictionary *)dictionary;

@end
