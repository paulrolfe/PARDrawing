//
//  UIColor+colorFromDictionary.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/18/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "UIColor+colorFromDictionary.h"

@implementation UIColor (colorFromDictionary)

- (NSDictionary *)dictionaryWithRGBAValues{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSDictionary *dictionary = @{@"R":[NSNumber numberWithDouble:red], @"G":[NSNumber numberWithDouble:green], @"B":[NSNumber numberWithDouble:blue], @"A":[NSNumber numberWithDouble:alpha]};
    return dictionary;
}

+ (UIColor *)colorFromDictionary:(NSDictionary *)dictionary{
    CGFloat red = [dictionary[@"R"] doubleValue];
    CGFloat green = [dictionary[@"G"] doubleValue];
    CGFloat blue = [dictionary[@"B"] doubleValue];
    CGFloat alpha = [dictionary[@"A"] doubleValue];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
