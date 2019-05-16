//
//  UIColor+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 16/05/19.
//

#import <UIKit/UIKit.h>

#define MCUColorForRGB(red,green,blue)              MCUColorForRGBA(red,green,blue,1)
#define MCUColorForRGBA(red,green,blue,alpha)       [UIColor colorWithRed:(red/256.0f) green:(green/256.0f) blue:(blue/256.0f) alpha:alpha]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MCU)

@end

NS_ASSUME_NONNULL_END
