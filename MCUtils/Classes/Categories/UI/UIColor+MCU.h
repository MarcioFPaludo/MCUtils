//
//  UIColor+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 16/05/19.
//

#import <UIKit/UIKit.h>

#define UIColorWithRGB(R,G,B)                    UIColorWithRGBA(R,G,B,100)
#define UIColorWithRGBA(R,G,B,A)                 [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A/100.0]
#define UIColorWithPercentScale(scale, A)        [UIColor colorWithWhite:scale/100.0 alpha:A/100.0]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MCU)

@end

NS_ASSUME_NONNULL_END
