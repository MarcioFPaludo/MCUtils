//
//  UIButton+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/06/19.
//

#import "UIButton+MCU.h"

@implementation UIButton (MCU)

@dynamic normalStateImage, normalStateTitle, normalStateTitleColor, selectedStateImage, selectedStateTitle, selectedStateTitleColor;

#pragma mark - Setters

- (void)setNormalStateTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setNormalStateImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setNormalStateTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedStateTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)setSelectedStateImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateSelected];
}

- (void)setSelectedStateTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}

#pragma mark - Getters

- (UIColor *)normalStateTitleColor
{
    return [self titleColorForState:UIControlStateNormal];
}

- (UIColor *)selectedStateTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}

- (UIImage *)normalStateImage
{
    return [self imageForState:UIControlStateNormal];
}

- (UIImage *)selectedStateImage
{
    return [self imageForState:UIControlStateSelected];
}

- (NSString *)normalStateTitle
{
    return [self titleForState:UIControlStateNormal];
}

- (NSString *)selectedStateTitle
{
    return [self titleForState:UIControlStateSelected];
}


@end
