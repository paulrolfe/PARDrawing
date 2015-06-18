//
//  ColorCollectionViewCell.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setupWithColor:(UIColor *)color{
    self.layer.cornerRadius = .5 * self.bounds.size.height;
    self.layer.borderWidth = 4;
    self.contentView.backgroundColor = color;
}

- (void) setupAsAddButton{
    UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [add setTranslatesAutoresizingMaskIntoConstraints:NO];
    add.text = @"+";
    [self.contentView addSubview:add];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:add attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:add attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraints:@[centerX, centerY]];
    
    self.layer.cornerRadius = .5 * self.bounds.size.height;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.layer.borderColor = selected? [UIColor darkGrayColor].CGColor : [UIColor clearColor].CGColor;
}

- (void)prepareForReuse{
    for (UIView * subview in self.contentView.subviews){
        [subview removeFromSuperview];
    }
}

@end
